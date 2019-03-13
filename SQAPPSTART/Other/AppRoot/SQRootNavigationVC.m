//
//  SQRootNavigationVC.m
//  SQAPPSTART
//
//  Created by qwuser on 2018/5/4.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQRootNavigationVC.h"
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface SQRootNavigationVC ()

@end

@implementation SQRootNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.tintColor = KCOLOR_BLACK;
    self.navigationBar.barTintColor = KCOLOR_BLACK;
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:KCOLOR_MAIN}];
    
}



@end
