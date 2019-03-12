//
//  SQLoginViewController.m
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SQLoginViewController.h"
#import "SQLoginView.h"

@interface SQLoginViewController () <sqLoginViewDelegate>

@property (nonatomic, strong)   SQLoginView        *loginTypeView;

@end

@implementation SQLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view = self.loginTypeView;
    self.loginTypeView.viewType = self.viewType;
}

- (void)tapedSureButton {
    SQLoginViewController *vc = [[SQLoginViewController alloc] init];
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
