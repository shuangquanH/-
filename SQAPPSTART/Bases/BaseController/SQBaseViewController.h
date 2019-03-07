//
//  SQBaseViewController.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//  基类视图控制器(所有的控制器请继承自本基类控制器)

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UINavigationController+FDFullscreenPopGesture.h"

@interface SQBaseViewController : UIViewController

/** 判断是否已经登录，如果没有登录则跳转到登录页面  */
- (BOOL)loginOrNot;

- (void)setNavTitleString:(NSString *)string;

- (void)pop;

- (void)popToRootVc;

- (void)popToVc:(UIViewController *)vc;

- (void)dismiss;

- (void)presentVc:(UIViewController *)vc;

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion;

- (void)pushVc:(UIViewController *)vc;

- (void)removeChildVc:(UIViewController *)childVc;

- (void)addChildVc:(UIViewController *)childVc;

/** 创建barbuttonItem（图片）  */
- (void)addLeftBarbuttonItemIsImage:(BOOL)isImage title:(NSString *)title selector:(SEL)selector;
- (void)addRightBarbuttonItemIsImage:(BOOL)isImage title:(NSString *)title selector:(SEL)selector;

/** 显示隐藏状态栏  */
- (void)hiddenStatusBar:(BOOL)hidden;

@end
