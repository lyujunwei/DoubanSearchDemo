//
//  SearchViewController.m
//  DoubanAPIEngineDemo
//
//  Created by imzucknet on 13/8/6.
//
//

#import "SearchViewController.h"
#import "WXHLDataService.h"
#import "DataModel.h"
#import "DoubanCell.h"
#import "DetailViewController.h"
#import "MusicViewController.h"
#import "MovieViewController.h"

@interface SearchViewController ()

#define backCount @"20"

- (void)showHUB:(NSString *)title isDim:(BOOL)isDim;

- (void)hideHUD;

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.hidden = YES;
    self.douban_bg.hidden = NO;
    [self.searchBar becomeFirstResponder];
}

#pragma mark - Data
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    self.douban_bg.hidden = YES;
    [self.searchBar resignFirstResponder];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   searchBar.text,@"q=",backCount,@"count",nil];
    [self showHUB:@"搜索中..." isDim:YES];

    _searchName = nil;
    switch (selectedScope) {
            //books
        case 0:
        {
            _searchName = @"book";
        }
            break;
            //Music
        case 1:
        {
            _searchName = @"music";
        }
            break;
            //Movie
        case 2:
        {
            _searchName = @"movie";
        }
            break;
    }
    
    NSString *tagert = [NSString stringWithFormat:@"%@/search?",_searchName];
    [WXHLDataService requestWithURL:tagert params:params httpMethod:@"GET" completeBlock:^(id result) {
        [self searchFinish:result];
    }];
    
}

#pragma mark - Search Delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    self.douban_bg.hidden = YES;
    [self.searchBar resignFirstResponder];
    [self showHUB:@"搜索中..." isDim:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   searchBar.text,@"q=",backCount,@"count",nil];
    [WXHLDataService requestWithURL:@"book/search" params:params httpMethod:@"GET" completeBlock:^(id result) {
        _searchName = @"book";
        [self searchFinish:result];
    }];
}

- (void)searchFinish:(NSDictionary *)result {
    [self hideHUD];
    
    NSLog(@"RESULT :%@",result);
            
//    if ([[result valueForKey:@"count"] isEqualToString: @"0"] ) {
//        self.tableView.hidden = YES;
//        self.douban_bg.hidden = NO;
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"没有结果！用其他名字试试吧" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alert show];
//        [self.searchBar becomeFirstResponder];
//    }
    self.tableView.hidden = NO;
    NSString *str = nil;
    if ([_searchName isEqualToString:@"movie"]) {
        str = [NSString stringWithFormat:@"subjects"];
    } else {
        str = [NSString stringWithFormat:@"%@s",_searchName];
    }
    NSArray *statues = [result objectForKey:str];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:statues.count];

    for (NSDictionary *statuesDic in statues) {
        self.model = [[DataModel alloc]initWithDataDic:statuesDic];
        [array addObject:self.model];
        [self.model release];
    }
    self.searchArray = array;
    [self.searchBar resignFirstResponder];
    [self.tableView reloadData];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.searchArray == nil) {
        self.tableView.hidden = YES;
    }
    return self.searchArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    DoubanCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[DoubanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.model = self.searchArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([_searchName isEqualToString:@"book"]) {
        DetailViewController *detail = [[DetailViewController alloc]init];
        DataModel *model = [self.searchArray objectAtIndex:indexPath.row];
        detail.dataModel = model;
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:detail];
        [self presentViewController:nav animated:YES completion:^{
        }];
        [detail release];
    } else if ([_searchName isEqualToString:@"music"]) {
        NSLog(@"Music");//音乐
        MusicViewController *musicCtrl = [[MusicViewController alloc]init];
        [self.navigationController pushViewController:musicCtrl animated:YES];
        [musicCtrl release];
    } else if ([_searchName isEqualToString:@"movie"]) {
        NSLog(@"movie");
        MovieViewController *movieCtrl = [[MovieViewController alloc]init];
        [self.navigationController pushViewController:movieCtrl animated:YES];
        [movieCtrl release];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchBar resignFirstResponder];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - custem HUD
- (void)showHUB:(NSString *)title isDim:(BOOL)isDim {
    self.HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.HUD.dimBackground = isDim;
    self.HUD.labelText = title;
}

- (void)hideHUD {
    [self.HUD hide:YES];
}

#pragma mark - UIAlert delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        self.searchBar.text = nil;
        [self.searchBar becomeFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_searchBar release];
    [_tableView release];
    self.searchArray = nil;
    [_douban_bg release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setSearchBar:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}

@end
