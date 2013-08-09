//
//  RatingView.m
//  RatingViewDemo
//
//  Created by imzucknet on 13/6/28.
//  Copyright (c) 2013年 zucknet. All rights reserved.
//

#import "RatingView.h"

@implementation RatingView

#define kNormalWidth 35
#define kNormalHeight 33

#define kSmallWidth 15
#define kSmallHeight 14

#define kFullMark 10

#define kNormalFontSize 25
#define kSmallFontSize 12

#pragma mark - init Method
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initGrayStarView];
        
        [self initYellowStarView];
        
        [self initRatingLabel];
    }
    return self;
}

- (void)initGrayStarView
{
    _grayStarsArray = [[NSMutableArray alloc] initWithCapacity:5];
    for (int index = 0; index < 5; index++) {
        UIImageView *grayStarView = [[UIImageView alloc] initWithFrame:CGRectZero];
        grayStarView.image = [UIImage imageNamed:@"gray"];
        [self addSubview:grayStarView];
        [grayStarView release];
        
        [_grayStarsArray addObject:grayStarView];
    }
}

- (void)initYellowStarView
{
    _baseView = [[UIView alloc] initWithFrame:CGRectZero];
    _baseView.backgroundColor = [UIColor clearColor];
    _baseView.clipsToBounds = YES;
    [self addSubview:_baseView];
    
    _yellowStarsArray = [[NSMutableArray alloc] initWithCapacity:5];
    for (int index = 0; index < 5; index++) {
        UIImageView *yellowStarView = [[UIImageView alloc] initWithFrame:CGRectZero];
        yellowStarView.image = [UIImage imageNamed:@"yellow"];
        [_baseView addSubview:yellowStarView];
        [yellowStarView release];
        
        [_yellowStarsArray addObject:yellowStarView];
    }
}

- (void)initRatingLabel
{
    _ratingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _ratingLabel.backgroundColor = [UIColor clearColor];
    _ratingLabel.textColor = [UIColor blackColor];
    [self addSubview:_ratingLabel];
}

#pragma mark - Setter Method

- (void)setRatingScore:(CGFloat)ratingScore {
    _ratingScore = ratingScore;
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f", _ratingScore];
}

#pragma mark - Layout subviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int width = 0;
    for (int index = 0; index < 5; index++) {
        UIView *yellowStar = _yellowStarsArray[index];
        UIView *grayStar   = _grayStarsArray[index];
        
        if (self.style == kSmallStyle) {
            yellowStar.frame = CGRectMake(0+width, 0, kSmallWidth, kSmallHeight);
            grayStar.frame = CGRectMake(0+width, 0, kSmallWidth, kSmallHeight);
            width += kSmallWidth;
        }else {
            yellowStar.frame = CGRectMake(0+width, 0, kNormalWidth, kNormalHeight);
            grayStar.frame = CGRectMake(0+width, 0, kNormalWidth, kNormalHeight);
            width += kNormalWidth;
        }
    }
    
    float baseViewWidth = 0;
    baseViewWidth = self.ratingScore / kFullMark * width;
    
    float height = 0;
    if (self.style == kSmallStyle) {
        _baseView.frame = CGRectMake(0, 0, baseViewWidth, kSmallHeight);
        _ratingLabel.font = [UIFont boldSystemFontOfSize:kSmallFontSize];
        height = kSmallHeight;
    }else {
        _baseView.frame = CGRectMake(0, 0, baseViewWidth, kNormalHeight);
        _ratingLabel.font = [UIFont boldSystemFontOfSize:kNormalFontSize];
        height = kNormalHeight;
    }
    
    _ratingLabel.frame = CGRectMake(width+5, 1, 0, 0);
    [_ratingLabel sizeToFit];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width+_ratingLabel.frame.size.width, height);

}

#pragma mark - Memory
- (void)dealloc
{
    [_baseView release], _baseView = nil;
    [_ratingLabel release], _ratingLabel = nil;
    [_yellowStarsArray release], _yellowStarsArray = nil;
    [_grayStarsArray release], _grayStarsArray = nil;
    [super dealloc];
}

@end
