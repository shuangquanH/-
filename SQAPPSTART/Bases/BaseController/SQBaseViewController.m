//
//  SQBaseViewController.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQBaseViewController.h"
#import <UMMobClick/MobClick.h>
#import "SQStartManager.h"
#import "SQLoginViewController.h"


@implementation SQBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KCOLOR_WHIT;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];//友盟统计
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];//友盟统计
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

- (BOOL)loginOrNot {
    if (![SQStartManager shareManager].userId) {
        SQLoginViewController *controller = [[SQLoginViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
        return NO;
    } else {
        return YES;
    }
}


- (void)setNavTitleString:(NSString *)string {
    self.navigationItem.title = string;
}

- (void)pop {
    if (self.navigationController == nil) return ;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRootVc {
    if (self.navigationController == nil) return ;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)presentVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentVc:vc completion:nil];
}

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:completion];
}

- (void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
}

- (void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = self.view.bounds;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    NSLog(@"【【【控制器:[%@]--已经销毁了】】】", self);
}



- (void)addLeftBarbuttonItemIsImage:(BOOL)isImage title:(NSString *)title selector:(SEL)selector {
    UIBarButtonItem *item = [self creatBarbuttonItemIsImage:isImage title:title selector:selector];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)addRightBarbuttonItemIsImage:(BOOL)isImage title:(NSString *)title selector:(SEL)selector {
    UIBarButtonItem *item = [self creatBarbuttonItemIsImage:isImage title:title selector:selector];
    self.navigationItem.rightBarButtonItem = item;
}
- (UIBarButtonItem *)creatBarbuttonItemIsImage:(BOOL)isImage title:(NSString *)title selector:(SEL)selector {
    UIButton *barButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    barButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    if (isImage) {
        [barButton setImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
    } else {
        [barButton setTitle:title forState:UIControlStateNormal];
        [barButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    [barButton addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:barButton];
    return barButtonItem;
}

- (void)hiddenStatusBar:(BOOL)hidden {
    [[UIApplication sharedApplication] setStatusBarHidden:hidden animated:YES];
}
@end
