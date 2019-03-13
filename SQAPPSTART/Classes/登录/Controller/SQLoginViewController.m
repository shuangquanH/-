//
//  SQLoginViewController.m
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SQLoginViewController.h"
#import "SQLoginView.h"
#import "SQBaseWebViewController.h"
 

@interface SQLoginViewController () <sqLoginViewDelegate>
@property (nonatomic, strong)   SQLoginView        *loginTypeView;

@end

@implementation SQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = self.loginTypeView;
    self.loginTypeView.viewType = self.viewType;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}







- (void)tapedSureButton {
    SQLoginViewController *vc = [[SQLoginViewController alloc] init];
    [[NTESVerifyCodeManager sharedInstance] openVerifyCodeView:nil];
}
- (void)tapedForgetPsswdButton {
    SQLoginViewController *vc = [[SQLoginViewController alloc] init];
    vc.viewType = forgetPsd;
    [self pushVc:vc];
}
- (void)tapedRegistButton {
    SQLoginViewController *vc = [[SQLoginViewController alloc] init];
    vc.viewType = registPage;
    [self pushVc:vc];
}
- (void)tapedGoToLogin {
    SQLoginViewController *vc = [[SQLoginViewController alloc] init];
    vc.viewType = loginPage;
    [self pushVc:vc];
}
- (void)tapedGetVerifyCode {
    //获取短信验证码
}
- (void)tapedUserProtocol {
    self.navigationController.navigationBar.hidden = NO;
    SQBaseWebViewController *web = [[SQBaseWebViewController alloc] init];
    web.title = @"用户协议";
    web.webUrl = @"https://www.baidu.com";
    [self pushVc:web];
}

- (void)tapedBackBtn {
    [self pop];
}
- (void)tapedCloseBtn {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



- (SQLoginView *)loginTypeView {
    if (!_loginTypeView) {
        _loginTypeView = [[SQLoginView alloc] initWithFrame:self.view.frame];
        _loginTypeView.viewType = self.viewType;
        _loginTypeView.delegate = self;
    }
    return _loginTypeView;
}




@end
