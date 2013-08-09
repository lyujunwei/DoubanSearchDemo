//
//  DetailViewController.m
//  DoubanAPIEngineDemo
//
//  Created by imzucknet on 13/8/6.
//
//

#import "DetailViewController.h"
#import "DataModel.h"
#import "BooksInfoViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)loadView {
    [super loadView];
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:) ]) {
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_all"] forBarMetrics:UIBarMetricsDefault];
    }
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(closeVc)];
    closeButton.style = 
    self.navigationItem.rightBarButtonItem = [closeButton autorelease];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.title = @"详细信息";
    self.infoString = self.dataModel.summary;
    self.author_intro = self.dataModel.author_intro;
    self.infoArr = @[self.infoString,self.author_intro];

    [self loadBooksInfoData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 44- 20) style:UITableViewStylePlain];
    self.tableView.dataSource= self;
    self.tableView.delegate = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    self.headView = [[BooksInfoViewController alloc]initWithNibName:@"BooksInfoViewController" bundle:nil];
    self.headView.view.frame = CGRectMake(0, 0, kScreenWidth, 180);
    self.tableView.tableHeaderView = self.headView.view;
}

#pragma mark - FinishData
- (void)loadBooksInfoData {
    [self.headView.large_image setImageWithURL:[NSURL URLWithString:[self.dataModel.images objectForKey:@"large"]]];
    self.headView.booksName.text = [NSString stringWithFormat:@"书名:%@",self.dataModel.title];
    
    self.headView.origin_title.text = [NSString stringWithFormat:@"原作名:%@",self.dataModel.origin_title];
    self.headView.author.text = [NSString stringWithFormat:@"作者:%@",[self.dataModel.author objectAtIndex:0]];
    self.headView.publisher.text = [NSString stringWithFormat:@"出版社:%@",self.dataModel.publisher];
    self.headView.average.text = [NSString stringWithFormat:@"评分:%.1f",[[self.dataModel.rating objectForKey:@"average"]floatValue]];
    self.headView.price.text = [NSString stringWithFormat:@"价格:%@",self.dataModel.price];
    
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"内容介绍";
        case 1:
            return @"作者介绍";
        default:
            return @"nil";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        label.tag = 101;
        label.lineBreakMode = NSLineBreakByClipping;
        label.highlightedTextColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        label.opaque = NO; // 选中Opaque表示视图后面的任何内容都不应该绘制
        label.backgroundColor = [UIColor clearColor];
        [cell addSubview:label];
    }

            UILabel *label = (UILabel *)[cell viewWithTag:101];
            NSString *text;
            text = self.infoArr[indexPath.section];
            CGRect cellFrame = [cell frame];
            cellFrame.origin = CGPointMake(0, 10);
            
            label.text = text;
            label.font = [UIFont systemFontOfSize:14.0f];
            CGRect rect = CGRectInset(cellFrame, 10, 2);
            label.frame = rect;
            [label sizeToFit];
            if (label.frame.size.height > 46) {
                cellFrame.size.height = 50 + label.frame.size.height - 46;
            }
            else {
                cellFrame.size.height = 50;
            }
            [cell setFrame:cellFrame];

    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

//    if (indexPath.section == 0) {
        UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height + 20;
//    } else {
//        return 44;
//    }
}


- (void)closeVc {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_titleLabel release];
    [_tableView release];
    [super dealloc];
}
@end
