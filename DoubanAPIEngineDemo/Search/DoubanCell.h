//
//  DoubanCell.h
//  DoubanAPIEngineDemo
//
//  Created by imzucknet on 13/8/6.
//
//

#import <UIKit/UIKit.h>

@class RatingView;
@class DataModel;

@interface DoubanCell : UITableViewCell {
@private
    UILabel *_titleLabel;
    NSDictionary *_contentDic;
    DataModel *_model;
    RatingView *_rankView;
    UIImageView *_smallImage;
}

@property(nonatomic,retain)DataModel *model;

@end