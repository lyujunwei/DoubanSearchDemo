//
//  DataModel.m
//  DoubanAPIEngineDemo
//
//  Created by imzucknet on 13/8/6.
//
//

#import "DataModel.h"

@implementation DataModel

- (void)dealloc {
    _subject = nil;
    _title = nil;
    _subArr = nil;
    _image = nil;
    _images = nil;
    _rating = nil;
    _summary = nil;
    _author_intro = nil;
    _large_image = nil;
    _booksName = nil;
    _origin_title = nil;
    _price = nil;
//    _average;
    _publisher = nil;
    _author = nil;
    [super dealloc];
}

@end
