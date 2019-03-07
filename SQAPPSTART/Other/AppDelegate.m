//
//  AppDelegate.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "SQStartManager.h"
#import "SQRootNavigationVC.h"
#import "SQHomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[SQStartManager shareManager] startApplication:application withOptions:launchOptions];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    SQHomeViewController    *homeVC = [[SQHomeViewController alloc] init];
    homeVC.title = @"BTC/USDT";
    self.window.rootViewController = [[SQRootNavigationVC alloc] initWithRootViewController:homeVC];
    [self.window makeKeyAndVisible];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
