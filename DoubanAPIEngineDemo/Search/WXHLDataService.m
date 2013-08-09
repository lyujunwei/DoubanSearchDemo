//
//  WXHLDataService.m
//  Created by imzucknet on 13/7/27.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "WXHLDataService.h"
#import "JSONKit.h"

#define BASE_URL @"https://api.douban.com/v2/"

@implementation WXHLDataService

+ (ASIHTTPRequest *)requestWithURL:(NSString *)urlString
                            params:(NSMutableDictionary *)params
                        httpMethod:(NSString *)httpMethod
                     completeBlock:(requestFinishBlock)block {
    
    //取得微博Token 否则没有权限访问接口
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    NSString *accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
    
    //Token是参数 所以前面加个问号 拼接好重复赋给urlString
    urlString = [BASE_URL stringByAppendingFormat:@"%@?access_token=%@",urlString,accessToken];

    
    //如果是Get请求 是放在请求提的后面 用问号连接起来
    NSComparisonResult comparGet = [httpMethod caseInsensitiveCompare:@"GET"];
    if (comparGet == NSOrderedSame) {
        //处理Get请求参数
        
        //拼接参数
        NSMutableString *paramsString = [NSMutableString string];
        NSArray *allkeys = [params allKeys];
        for (int i = 0; i<params.count; i++) {
            NSString *key = [allkeys objectAtIndex:i];
            id value = [params objectForKey:key];
            
            [paramsString appendFormat:@"%@=%@",key,value];
            
            if (i<params.count-1) {
                [paramsString appendString:@"&"];
            }
        }
        
        //判断它是不是大于0 大于0就可以拼接
        if (paramsString.length > 0) {
            urlString = [urlString stringByAppendingFormat:@"&%@",paramsString];
        }
        
    }
    
    
    //先要创建request对象
    NSURL *url = [NSURL URLWithString:urlString];
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    //设置超时时间
    [request setTimeOutSeconds:60];
    //传输方式 "GET":"POST"
    [request setRequestMethod:httpMethod];
    
    //处理POST请求方式
    //如果httpMethod = post 写的时候要忽略大小写
    //返回的是枚举
    NSComparisonResult comparRet = [httpMethod caseInsensitiveCompare:@"POST"];
    if (comparRet == NSOrderedSame) {
        //遍历出来设置上去
        NSArray *allKeys = [params allKeys];
        for (int i = 0; i<params.count; i++) {
            //通过索引拿到全部的Key
            NSString *key = [allKeys objectAtIndex:i];
            id value = [params objectForKey:key];
            
            //判断文件是否上传
            if ([value isKindOfClass:[NSData class]]) {
                [request addData:value forKey:key];
            } else {
                [request addPostValue:value forKey:key];
            }
        }
    }
    
    //在这里拿到数据 进行解析
    [request setCompletionBlock:^{
        NSData *data = request.responseData;
        float version = WXHLOSVersion();
        id result = nil;
        if (version >= 5.0) {
            result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        } else {
            //倒入JSONKit.h进行解析
            result = [data objectFromJSONData];
        }
        if (block != nil) {
            block(result);
        }
    }];
    
    [request startAsynchronous];
    
    return nil;
        
}

@end
