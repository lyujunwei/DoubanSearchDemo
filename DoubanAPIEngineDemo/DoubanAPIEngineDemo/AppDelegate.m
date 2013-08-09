//
//  AppDelegate.m
//  DoubanAPIEngineDemo
//
//  Created by Lin GUO on 1/16/12.
//  Copyright (c) 2012 Douban Inc. All rights reserved.
//

#import "AppDelegate.h"
#import "NavController.h"
#import "DOUAPIEngine.h"
#import "SearchViewController.h"


@implementation AppDelegate

// 仅用于此 demo, level 较低，大量使用时会遇到访问限制。实际使用，请重新申请。
//static NSString * const kAPIKey = @"03801d00e8e182900a805702baa487b0";
//static NSString * const kPrivateKey = @"Secret822c0c8de247c782";
//static NSString * const kRedirectUrl = @"http://weibo.com/zucknet";

@synthesize window = window_;


- (void)dealloc {
  [window_ release];
  [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  DOUService *service = [DOUService sharedInstance];
  service.clientId = kAPIKey;
  service.clientSecret = kPrivateKey;
  if ([service isValid]) {
    service.apiBaseUrlString = kHttpsApiBaseUrl;
  }
  else {
    service.apiBaseUrlString = kHttpApiBaseUrl;
  }
  
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];

  SearchViewController *navController = [[[SearchViewController alloc] initWithNibName:@"SearchViewController"
                                                                  bundle:nil] autorelease];
  
  UINavigationController *nav = [[[UINavigationController alloc] initWithRootViewController:navController] autorelease];
    nav.navigationBarHidden = YES;

  self.window.rootViewController = nav;
  [self.window makeKeyAndVisible];
  return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
  /*
   Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
   Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
   */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  /*
   Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
   If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
   */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  /*
   Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
   */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  /*
   Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
   */
}

- (void)applicationWillTerminate:(UIApplication *)application {
  /*
   Called when the application is about to terminate.
   Save data if appropriate.
   See also applicationDidEnterBackground:.
   */
}

@end
