//
//  DataModel.h
//  DoubanAPIEngineDemo
//
//  Created by imzucknet on 13/8/6.
//
//

#import <Foundation/Foundation.h>
#import "WXBaseModel.h"

@interface DataModel : WXBaseModel

@property(nonatomic,retain)NSDictionary *subject;
@property(nonatomic,retain)NSArray *subArr;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSDictionary *images;
@property(nonatomic,copy)NSDictionary *rating;
@property(nonatomic,copy)NSString *summary;
@property(nonatomic,copy)NSString *author_intro;


@property (retain, nonatomic) NSString *large_image;
@property (retain, nonatomic) NSString *booksName;
@property (retain, nonatomic) NSString *origin_title;
@property (retain, nonatomic) NSString *price;
@property (retain, nonatomic) NSString *publisher;
@property (retain, nonatomic) NSArray *author;

@end
