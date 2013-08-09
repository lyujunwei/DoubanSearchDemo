//
//  MusicViewController.m
//  DoubanAPIEngineDemo
//
//  Created by imzucknet on 13/8/7.
//
//

#import "MusicViewController.h"

@interface MusicViewController ()

@end

@implementation MusicViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)initViews {
    UIImageView *navigationbar = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    navigationbar.image = [UIImage imageNamed:@"nav_bg_all"];
    [self.view addSubview:navigationbar];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
