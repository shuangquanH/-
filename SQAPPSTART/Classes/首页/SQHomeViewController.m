//
//  SQHomeViewController.m
//  SQAPPSTART
//
//  Created by qwuser on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQHomeViewController.h"


#import "ABKLineViewController.h"

@interface SQHomeViewController ()

@property (nonatomic, strong)   UIButton        *closeFullButton;
@property (nonatomic, assign)   BOOL        isFullScreen;
@property (nonatomic, strong)   ABKLineViewController   *klineVC;

@end

@implementation SQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addLeftBarbuttonItemIsImage:YES title:@"home_tab__icon3" selector:@selector(leftAction)];
    [self addRightBarbuttonItemIsImage:NO title:@"优惠券" selector:@selector(leftAction)];
    [self addKLineViewController];
}

- (void)leftAction {
    /** 切换成竖屏  */
    if (self.isFullScreen) {
        [UIView animateWithDuration:0.2f animations:^{
            self.klineVC.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            self.isFullScreen = NO;
            [self makeStockViewConstraints];
            self.closeFullButton.hidden = YES;
        }];
    } else {
        /** 切换成横屏  */
        [UIView animateWithDuration:0.2f animations:^{
            self.klineVC.view.transform = CGAffineTransformMakeRotation(M_PI/2);
        } completion:^(BOOL finished) {
            self.isFullScreen = YES;
            [self makeStockViewConstraints];
            self.closeFullButton.hidden = NO;
        }];
    }
}
- (void)makeStockViewConstraints {
    if (self.isFullScreen) {
        [self hiddenStatusBar:YES];
        self.navigationController.navigationBar.hidden = YES;
        self.klineVC.view.frame = CGRectMake(0, KSTATU_HEIGHT, KAPP_WIDTH, KAPP_HEIGHT-KSTATU_HEIGHT);
    } else {
        [self hiddenStatusBar:NO];
        self.navigationController.navigationBar.hidden = NO;
        self.klineVC.view.frame = CGRectMake(0, KNAV_HEIGHT, KAPP_WIDTH, 400);
    }
}


- (void)addKLineViewController {
    self.klineVC = [ABKLineViewController new];
    [self addChildVc:self.klineVC];
    [self.view addSubview:self.klineVC.view];
    [self makeStockViewConstraints];
}

- (UIButton *)closeFullButton {
    if (!_closeFullButton) {
        _closeFullButton = [[UIButton alloc] init];
        _closeFullButton.layer.cornerRadius = 11;
        _closeFullButton.layer.masksToBounds = YES;
        _closeFullButton.backgroundColor = KCOLOR_MAIN;
        [_closeFullButton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
        _closeFullButton.hidden = YES;
        [self.view addSubview:_closeFullButton];
        [_closeFullButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(22);
            make.bottom.right.equalTo(self.view).offset(-10);
        }];
    }
    return _closeFullButton;
}
@end
