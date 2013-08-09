//
//  RatingView.h
//  RatingViewDemo
//
//  Created by imzucknet on 13/6/28.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum kRatingViewStyle {
    kSmallStyle  = 0,
    kNormalStyle = 1
}kRatingViewStyle;

@interface RatingView : UIView
{
@private
    UIView  *_baseView;   
    UILabel *_ratingLabel;
    NSMutableArray *_yellowStarsArray;
    NSMutableArray *_grayStarsArray;
    CGFloat _ratingScore;
}

@property (nonatomic, assign) kRatingViewStyle style;
@property (nonatomic, assign) CGFloat ratingScore;

@end
