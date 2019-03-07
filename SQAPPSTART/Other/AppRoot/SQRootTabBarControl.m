//
//  SQRootTabBarControl.m
//  SQAPPSTART
//
//  Created by qwuser on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQRootTabBarControl.h"
//声音
#import <AudioToolbox/AudioToolbox.h>

#import "SQHomeViewController.h"

@interface SQRootTabBarControl () <UITabBarControllerDelegate>

@end

@implementation SQRootTabBarControl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.delegate = self;
    self.tabBar.tintColor = KCOLOR_MAIN;
    self.tabBar.backgroundColor = KCOLOR_WHIT;
    
    SQHomeViewController *vc1 = [[SQHomeViewController alloc] init];
    UITabBarItem * homeItem =  [[UITabBarItem alloc]initWithTitle:@"首页"
                                                            image:[[UIImage imageNamed:@"tabbar_icon_home"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_icon_home_pre"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    vc1.tabBarItem = homeItem;
    
    UIViewController *vc2 = [[UIViewController alloc] init];
    UITabBarItem * youxuanItem = [[UITabBarItem alloc]initWithTitle:@"播报"
                                                              image:[[UIImage imageNamed:@"tabbar_icon_broadcast"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_icon_broadcast_pre"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    vc2.tabBarItem = youxuanItem;
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    UITabBarItem * messageItem = [[UITabBarItem alloc]initWithTitle:@"消息"
                                                              image:[[UIImage imageNamed:@"tabbar_icon_message"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_icon_message_pre"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    vc3.tabBarItem = messageItem;
    
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    UITabBarItem * userItem = [[UITabBarItem alloc]initWithTitle:@"我的"
                                                           image:[[UIImage imageNamed:@"tabbar_icon_mine"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"tabbar_icon_mine_pre"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    vc4.tabBarItem = userItem;
    self.viewControllers = @[vc1, vc2, vc3, vc4];
    
}


//点击声音
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    AudioServicesPlaySystemSound(1103);
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    if ([viewController isKindOfClass:[SQHomeViewController class]]) {
        self.navigationItem.title = @"首页";
    } else {
        self.navigationItem.title = @"我的";
    }
}


@end
