//
//  WXHLDataService.h
//  Created by imzucknet on 13/7/27.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"

typedef void(^requestFinishBlock)(id result);

@interface WXHLDataService : NSObject

+ (ASIHTTPRequest *)requestWithURL:(NSString *)urlString
                    params:(NSMutableDictionary *)params
                    httpMethod:(NSString *)httpMethod
                     completeBlock:(requestFinishBlock)block;

@end
