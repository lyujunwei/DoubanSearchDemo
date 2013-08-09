//
//  DoubanCell.m
//  DoubanAPIEngineDemo
//
//  Created by imzucknet on 13/8/6.
//
//

#import "DoubanCell.h"
#import "DataModel.h"
#import "RatingView.h"

@implementation DoubanCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        self.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initView {
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_titleLabel];
    
    _smallImage = [[UIImageView alloc]initWithFrame:CGRectZero];
    [self.contentView addSubview:_smallImage];
    
    _rankView = [[RatingView alloc]initWithFrame:CGRectZero];
    _rankView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_rankView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];

    _smallImage.frame = CGRectMake(10, 10, 44, 60);
    
    NSString *small = nil;
    if (self.model.image == NULL) {
        small = [self.model.images objectForKey:@"small"];
    } else {
        small = self.model.image;
    }
    
    NSURL *url = [NSURL URLWithString:small];
    [_smallImage setImageWithURL:url];
    
    _titleLabel.frame = CGRectMake(_smallImage.right+10, 10, 220, 30);
    _titleLabel.text = self.model.title;
    _titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    
    _rankView.frame = CGRectMake(_smallImage.right+10, _titleLabel.bottom+7,0, 0);
    _rankView.style = kSmallStyle;
    _rankView.ratingScore = [[self.model.rating objectForKey:@"average"]floatValue];
    
}

- (void)dealloc {
    [super dealloc];
    self.model = nil;
    [_titleLabel release],_titleLabel = nil;
    [_smallImage release],_smallImage = nil;
    [_rankView release],_rankView = nil;
}


@end
