//
//  SQHomeViewController.m
//  SQAPPSTART
//
//  Created by qwuser on 2018/5/15.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQHomeViewController.h"
#import "SQHomeFullScreenVC.h"
#import "SQLoginViewController.h"

#import "SQHomeTopInfosView.h"
#import "ABKLineViewController.h"
#import "SQHomeBottomDealView.h"
#import "SQHomeUnfoldView.h"

#import "YGStartPageView.h"

@interface SQHomeViewController ()

@property (nonatomic, strong)   SQHomeFullScreenVC      *fullScreenVC;
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
    //如果未登录的话
//    [self presentVc:[[UINavigationController alloc] initWithRootViewController:[SQLoginViewController new]]];
    
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
    self.klineVC.view.frame= CGRectMake(0, KNAV_HEIGHT+kTopInfoViewH, KAPP_WIDTH, KAPP_HEIGHT-KNAV_HEIGHT-kTopInfoViewH-kBottomDealViewH-kUnfoldViewH);
}




#pragma mark Actions
- (void)leftAction {
    [self presentVc:self.fullScreenVC];
}

#pragma mark lazyLoad
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

- (SQHomeFullScreenVC *)fullScreenVC {
    if (!_fullScreenVC) {
        _fullScreenVC = [[SQHomeFullScreenVC alloc] init];
        _fullScreenVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        _fullScreenVC.view.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    return _fullScreenVC;
}
@end
