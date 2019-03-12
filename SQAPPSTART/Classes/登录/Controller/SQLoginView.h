//
//  SQLoginView.h
//  QingYouProject
//
//  Created by qwuser on 2018/7/6.
//  Copyright © 2018年 ccyouge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SQLoginModel.h"


@protocol sqLoginViewDelegate
@optional
- (void)tapedSureButton;
- (void)tapedForgetPsswdButton;
- (void)tapedRegistButton;
- (void)tapedGoToLogin;

- (void)tapedBackBtn;
- (void)tapedCloseBtn;
@end


@interface SQLoginView : UIView <UITextFieldDelegate>

@property (nonatomic, strong) UIButton    *sureButton;

@property (nonatomic, assign) SQLoginViewType       viewType;
@property (nonatomic, weak) id <sqLoginViewDelegate>       delegate;




@end
