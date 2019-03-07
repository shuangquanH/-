//
//  SQHomeViewController.m
//  SQAPPSTART
//
//  Created by qwuser on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQHomeViewController.h"
#import "Y_StockChartViewController.h"

@interface SQHomeViewController ()

@property (nonatomic, strong)   Y_StockChartViewController        *stockController;
@property (nonatomic, strong)   UIButton        *closeFullButton;
@property (nonatomic, assign)   BOOL        isFullScreen;

@end

@implementation SQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftBarbuttonItemIsImage:YES title:@"home_tab__icon3" selector:@selector(leftAction)];
    [self addRightBarbuttonItemIsImage:NO title:@"优惠券" selector:@selector(leftAction)];
    [self addStockChartViewController];
}

- (void)leftAction {
    if (self.isFullScreen) {
        /** 切换成竖屏  */
        [UIView animateWithDuration:0.2f animations:^{
            self.stockController.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.isFullScreen = NO;
            [self makeStockViewConstraints];
        }];
    } else {
        /** 切换成横屏  */
        [UIView animateWithDuration:0.2f animations:^{
            self.stockController.view.transform = CGAffineTransformMakeRotation(M_PI/2);
            
        } completion:^(BOOL finished) {
            self.isFullScreen = YES;
            [self makeStockViewConstraints];
        }];
    }
}

- (void)addStockChartViewController {
    self.stockController = [[Y_StockChartViewController alloc] init];
    [self addChildVc:self.stockController];
    [self.view addSubview:self.stockController.view];
    [self makeStockViewConstraints];
}
- (void)makeStockViewConstraints {
    if (self.isFullScreen) {
        self.closeFullButton.hidden = NO;
        [self hiddenStatusBar:YES];
        self.navigationController.navigationBar.hidden = YES;
        self.stockController.view.frame = CGRectMake(0, KSTATU_HEIGHT, KAPP_WIDTH, KAPP_HEIGHT-KSTATU_HEIGHT);
    } else {
        self.closeFullButton.hidden = YES;
        [self hiddenStatusBar:NO];
        self.navigationController.navigationBar.hidden = NO;
        self.stockController.view.frame = CGRectMake(0, KNAV_HEIGHT, KAPP_WIDTH, 300);
    }
    [self.stockController reloadData];
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
