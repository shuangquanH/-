//
//  SQHomeViewController.m
//  SQAPPSTART
//
//  Created by qwuser on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQHomeViewController.h"

@interface SQHomeViewController ()
@end

@implementation SQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftBarbuttonItemIsImage:YES title:@"home_tab__icon3" selector:@selector(leftAction)];
    [self addRightBarbuttonItemIsImage:NO title:@"优惠券" selector:@selector(leftAction)];
}

- (void)leftAction {
    NSLog(@"dd");
}


@end
