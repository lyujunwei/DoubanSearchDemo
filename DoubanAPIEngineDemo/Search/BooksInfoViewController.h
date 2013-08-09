//
//  BooksInfoViewController.h
//  DoubanAPIEngineDemo
//
//  Created by imzucknet on 13/8/7.
//
//

#import <UIKit/UIKit.h>

@interface BooksInfoViewController : UIViewController
@property (retain, nonatomic) IBOutlet UIImageView *large_image;
@property (retain, nonatomic) IBOutlet UILabel *booksName;
@property (retain, nonatomic) IBOutlet UILabel *origin_title;
@property (retain, nonatomic) IBOutlet UILabel *price;
@property (retain, nonatomic) IBOutlet UILabel *average;
@property (retain, nonatomic) IBOutlet UILabel *publisher;
@property (retain, nonatomic) IBOutlet UILabel *author;


@end
