//
//  SQHomeViewController.m
//  SQAPPSTART
//
//  Created by qwuser on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQHomeViewController.h"


#import "ABKLineViewController.h"
#import "ABDepthViewController.h"

@interface SQHomeViewController ()

@property (nonatomic, strong)   UIButton        *closeFullButton;
@property (nonatomic, assign)   BOOL        isFullScreen;

@end

@implementation SQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftBarbuttonItemIsImage:YES title:@"home_tab__icon3" selector:@selector(leftAction)];
    [self addRightBarbuttonItemIsImage:NO title:@"优惠券" selector:@selector(leftAction)];
    [self addKLineViewController];
}

- (void)leftAction {

}

- (void)addKLineViewController {
    ABKLineViewController   *klineVC = [ABKLineViewController new];
    [self addChildVc:klineVC];
    [self.view addSubview:klineVC.view];
    [klineVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(400);
        make.top.mas_equalTo(KNAV_HEIGHT);
    }];
    
//    ABDepthViewController   *depthVC = [ABDepthViewController new];
//    [self addChildVc:depthVC];
//    [self.view addSubview:depthVC.view];
//    [depthVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.height.mas_equalTo(400);
//        make.top.mas_equalTo(KNAV_HEIGHT);
//    }];
//    depthVC.view.hidden = YES;
}

- (UIButton *)closeFullButton {
    if (!_closeFullButton) {
        _closeFullButton = [[UIButton alloc] init];
        _closeFullButton.frame = CGRectMake(KAPP_WIDTH-44, KAPP_HEIGHT-44, 44, 44);
        _closeFullButton.backgroundColor = KCOLOR_MAIN;
        [_closeFullButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        _closeFullButton.hidden = YES;
        [self.view addSubview:_closeFullButton];
    }
    return _closeFullButton;
}
@end
