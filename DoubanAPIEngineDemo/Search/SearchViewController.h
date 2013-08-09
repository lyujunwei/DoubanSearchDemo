//
//  SearchViewController.h
//  DoubanAPIEngineDemo
//
//  Created by imzucknet on 13/8/6.
//
//

#import <UIKit/UIKit.h>

@class DataModel;

@interface SearchViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UIScrollViewDelegate> {
//    NSMutableArray *_subjectsArray;
    NSString *_searchName;
}

@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,retain)NSArray *data;
@property(nonatomic,retain)NSMutableArray *searchArray;
@property(nonatomic,retain)MBProgressHUD *HUD;
@property (retain, nonatomic) IBOutlet UIImageView *douban_bg;
@property(nonatomic,retain)DataModel *model;

@end
