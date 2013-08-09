//
//  DetailViewController.h
//  DoubanAPIEngineDemo
//
//  Created by imzucknet on 13/8/6.
//
//

#import <UIKit/UIKit.h>

@class DataModel;
@class BooksInfoViewController;
@class RatingView;

@interface DetailViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic,retain)NSString *titleStr;
@property (retain, nonatomic) UITableView *tableView;

@property(nonatomic,retain)DataModel *dataModel;
@property(nonatomic,retain)NSArray *infoArr;
@property(nonatomic,retain)RatingView *rankView;

@property(nonatomic,retain)BooksInfoViewController *headView;

@property(nonatomic,retain)NSString *infoString;
@property(nonatomic,retain)NSString *author_intro;

@end
