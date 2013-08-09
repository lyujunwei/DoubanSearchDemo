//
//  BooksInfoViewController.m
//  DoubanAPIEngineDemo
//
//  Created by imzucknet on 13/8/7.
//
//

#import "BooksInfoViewController.h"

@interface BooksInfoViewController ()

@end

@implementation BooksInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_booksName release];
    [_origin_title release];
    [_price release];
    [_average release];
    [_publisher release];
    [_author release];
    [super dealloc];
}
@end
