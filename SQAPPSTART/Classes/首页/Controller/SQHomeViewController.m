//
//  SQHomeViewController.m
//  SQAPPSTART
//
//  Created by qwuser on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQHomeViewController.h"
#import "SQLoginViewController.h"

#import "SQHomeTopInfosView.h"
#import "ABKLineViewController.h"
#import "SQHomeBottomDealView.h"
#import "SQHomeUnfoldView.h"

#import "YGStartPageView.h"

@interface SQHomeViewController ()

@property (nonatomic, strong)   UIButton                *closeFullButton;
@property (nonatomic, strong)   ABKLineViewController   *klineVC;
@property (nonatomic, strong)   SQHomeTopInfosView      *topInfoView;
@property (nonatomic, strong)   SQHomeBottomDealView    *bottomDealView;
@property (nonatomic, strong)   SQHomeUnfoldView        *unfoldDealView;

@property (nonatomic, assign)   BOOL                    isFullScreen;

@end

@implementation SQHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [YGStartPageView showLaunchWithViewController:self];
    [self addControllersAndViews];
    [self makeStockViewConstraints];
}

#pragma mark ViewsAndControllers
- (void)addControllersAndViews {
    [self presentVc:[[UINavigationController alloc] initWithRootViewController:[SQLoginViewController new]]];
    [self addLeftBarbuttonItemIsImage:YES title:@"home_tab__icon3" selector:@selector(leftAction)];
    [self addRightBarbuttonItemIsImage:NO title:@"优惠券" selector:@selector(leftAction)];
    [self.view addSubview:self.topInfoView];
    [self.view addSubview:self.klineVC.view];
    [self.view addSubview:self.bottomDealView];
    [self.view addSubview:self.unfoldDealView];
}


#pragma mark constraints
- (void)makeStockViewConstraints {
    self.topInfoView.frame = CGRectMake(0, KNAV_HEIGHT, KAPP_WIDTH, kTopInfoViewH);
    self.bottomDealView.frame = CGRectMake(0, KAPP_HEIGHT-kBottomDealViewH-kUnfoldViewH, KAPP_WIDTH, kBottomDealViewH);
    self.unfoldDealView.frame = CGRectMake(0, KAPP_HEIGHT-kUnfoldViewH, KAPP_WIDTH, kUnfoldViewH);
    
    if (self.isFullScreen) {
        [self hiddenStatusBar:YES];
        self.navigationController.navigationBar.hidden = YES;
        self.klineVC.view.frame = CGRectMake(0, KSTATU_HEIGHT, KAPP_WIDTH, KAPP_HEIGHT-KSTATU_HEIGHT);
    } else {
        [self hiddenStatusBar:NO];
        self.navigationController.navigationBar.hidden = NO;
        CGRect windowFrame = CGRectMake(0, KNAV_HEIGHT+kTopInfoViewH, KAPP_WIDTH, KAPP_HEIGHT-KNAV_HEIGHT-kTopInfoViewH-kBottomDealViewH-kUnfoldViewH);
        self.klineVC.view.frame = windowFrame;
    }
    
    
    [self.klineVC reloadKlineViews];
    
    
}




#pragma mark Actions
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

#pragma mark lazyLoad
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
            make.bottom.right.equalTo(self.view).offset(-8);
        }];
    }
    return _closeFullButton;
}

- (SQHomeTopInfosView *)topInfoView {
    if (!_topInfoView) {
        _topInfoView = [[SQHomeTopInfosView alloc] init];
    }
    return _topInfoView;
}
- (ABKLineViewController *)klineVC {
    if (!_klineVC) {
        _klineVC = [[ABKLineViewController alloc] init];
        [self addChildVc:_klineVC];
    }
    return _klineVC;
}

- (SQHomeBottomDealView *)bottomDealView {
    if (!_bottomDealView) {
        _bottomDealView = [[SQHomeBottomDealView alloc] init];
    }
    return _bottomDealView;
}
- (SQHomeUnfoldView *)unfoldDealView {
    if (!_unfoldDealView) {
        _unfoldDealView = [[SQHomeUnfoldView alloc] init];
    }
    return _unfoldDealView;
}
@end
