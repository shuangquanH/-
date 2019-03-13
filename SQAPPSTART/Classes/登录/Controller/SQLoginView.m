//
//  SQLoginView.m
//  QingYouProject
//
//  Created by qwuser on 2018/7/6.
//  Copyright © 2018年 ccyouge. All rights reserved.
//

#import "SQLoginView.h"
#import "WKInputFiledLimitUtils.h"
#import "UILabel+SQAttribut.h"
#import "UIView+SQGesture.h"


@implementation SQLoginView {
    UITextField *passwordTextField;
    BOOL        isAcceptUserProtocol;
}

- (void)setViewType:(SQLoginViewType)viewType {
    _viewType = viewType;
    self.backgroundColor = KCOLOR_WHIT;
    
    switch (viewType) {
            
        case loginPage:/** 登陆页  */
        {
            [self creatCloseButton];
            UIImageView *topLogo = [self topLogoImage];
            UITextField *phone = [self creatTextFieldWithString:@"请输入手机号" top:topLogo.sqBottom+KMARGIN*2 icon:[UIImage imageNamed:@"login_icon_password"]];
            UITextField *passwd = [self creatTextFieldWithString:@"请输入密码" top:phone.sqBottom+KMARGIN*2 icon:[UIImage imageNamed:@"login_icon_password"]];
            passwordTextField = passwd;
            UIButton *showPasswd = [self creatImageButtonIntextfield:passwd image:[UIImage imageNamed:@"login_icon_password"] selectImage:[UIImage imageNamed:@"login_icon_password"]];
            [showPasswd addTarget:self action:@selector(showPassWordAct:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton    *sure = [self creatSureButtonWithString:@"登录" top:passwd.sqBottom+KMARGIN*2];
            [sure addTarget:self action:@selector(makeSureAction) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *forget = [self creatBtnWithTitle:@"忘记密码" color:kCOLOR_999 top:sure.sqBottom+KMARGIN*2];
            [forget addTarget:self.delegate action:@selector(tapedForgetPsswdButton) forControlEvents:UIControlEventTouchUpInside];

            UIButton    *bright = [self creatBottomRegistBtn];
            [bright addTarget:self.delegate action:@selector(tapedRegistButton) forControlEvents:UIControlEventTouchUpInside];
            

        }
            break;
            
        case registPage:/** 注册页  */
        {
            [self creatBackButton];
            UIImageView *topLogo = [self topLogoImage];
            UITextField *phone = [self creatTextFieldWithString:@"本人实名手机号" top:topLogo.sqBottom+KMARGIN*2 icon:[UIImage imageNamed:@"login_icon_password"]];
            UITextField *verify = [self creatTextFieldWithString:@"请输入短信验证码" top:phone.sqBottom+KMARGIN*2 icon:[UIImage imageNamed:@"login_icon_password"]];
            UIButton *getVerifyBtn = [self creatTextButtonIntextfield:verify text:@"获取验证码"];
            [getVerifyBtn addTarget:self action:@selector(getVerifyAction) forControlEvents:UIControlEventTouchUpInside];
            
            UITextField *passwd = [self creatTextFieldWithString:@"6-16位的数字或字母" top:verify.sqBottom+KMARGIN*2 icon:[UIImage imageNamed:@"login_icon_password"]];
            passwordTextField = passwd;
            UIButton *showPasswd = [self creatImageButtonIntextfield:passwd image:[UIImage imageNamed:@"login_icon_password"] selectImage:[UIImage imageNamed:@"login_icon_password"]];
            [showPasswd addTarget:self action:@selector(showPassWordAct:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *userProl = [self creatUserProtolLabelWithTop:passwd.sqBottom+KMARGIN];
            
            UIButton    *sure = [self creatSureButtonWithString:@"立即注册" top:userProl.sqBottom+KMARGIN];
            [sure addTarget:self action:@selector(makeSureAction) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *tologin = [self creatBtnWithTitle:@"已有账号,马上登录" color:kCOLOR_999 top:sure.sqBottom+KMARGIN*2];
            [tologin addTarget:self.delegate action:@selector(tapedGoToLogin) forControlEvents:UIControlEventTouchUpInside];

        }
            break;
            
        case forgetPsd:
        {
            [self creatBackButton];
            UIImageView *topLogo = [self topLogoImage];
            UITextField *phone = [self creatTextFieldWithString:@"本人实名手机号" top:topLogo.sqBottom+KMARGIN*2 icon:[UIImage imageNamed:@"login_icon_password"]];
            UITextField *verify = [self creatTextFieldWithString:@"请输入短信验证码" top:phone.sqBottom+KMARGIN*2 icon:[UIImage imageNamed:@"login_icon_password"]];
            UIButton *getVerifyBtn = [self creatTextButtonIntextfield:verify text:@"获取验证码"];
            [getVerifyBtn addTarget:self action:@selector(getVerifyAction) forControlEvents:UIControlEventTouchUpInside];
            
            UITextField *passwd = [self creatTextFieldWithString:@"6-16位的数字或字母" top:verify.sqBottom+KMARGIN*2 icon:[UIImage imageNamed:@"login_icon_password"]];
            passwordTextField = passwd;
            UIButton *showPasswd = [self creatImageButtonIntextfield:passwd image:[UIImage imageNamed:@"login_icon_password"] selectImage:[UIImage imageNamed:@"login_icon_password"]];
            [showPasswd addTarget:self action:@selector(showPassWordAct:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton    *sure = [self creatSureButtonWithString:@"确定" top:passwd.sqBottom+KMARGIN*2];
            [sure addTarget:self action:@selector(makeSureAction) forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;
            
        default:
            break;
    }
}

/** 返回按钮  */
- (UIButton *)creatBackButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    btn.frame = CGRectMake(KMARGIN, KSTATU_HEIGHT, 44, 44);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTitleColor:KCOLOR_BLACK forState:UIControlStateNormal];
    [btn addTarget:self.delegate action:@selector(tapedBackBtn) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (UIButton *)creatCloseButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    btn.frame = CGRectMake(KAPP_WIDTH-44-KMARGIN, KSTATU_HEIGHT, 44, 44);
    [btn setTitle:@"关闭" forState:UIControlStateNormal];
    [btn setTitleColor:KCOLOR_BLACK forState:UIControlStateNormal];
    [btn addTarget:self.delegate action:@selector(tapedCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (UIImageView *)topLogoImage {
    UIImageView *imagev = [UIImageView new];
    imagev.frame = CGRectMake(0, KNAV_HEIGHT, 80, 80);
    imagev.backgroundColor = KCOLOR_MAIN;
    [self addSubview:imagev];
    imagev.sqCenterX=self.sqWidth/2.0;
    return imagev;
}



/** 创建输入框  */
- (UITextField *)creatTextFieldWithString:(NSString *)plachode top:(CGFloat)top icon:(UIImage *)icon {
    UIView  *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = KCOLOR_LINE;
    [self addSubview:bottomLine];
    
    UITextField *textField = [[UITextField alloc] init];
    textField.backgroundColor = KCOLOR_WHIT;
    [self addSubview:textField];
    textField.placeholder = plachode;
    textField.delegate = self;
    [textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
    if ([textField.placeholder containsString:@"密码"]||
        [textField.placeholder containsString:@"6-16位"]) {
        textField.secureTextEntry = YES;
    }
    
    
    
    if (icon) {
        UIImageView *iconimage = [[UIImageView alloc] initWithImage:icon];
        [self addSubview:iconimage];
        textField.frame = CGRectMake(KMARGIN*2, top, KAPP_WIDTH-KMARGIN*3, 30);
        iconimage.frame = CGRectMake(KMARGIN, top, KMARGIN, 30);
    } else {
        textField.frame = CGRectMake(KMARGIN, top, KAPP_WIDTH-KMARGIN*2, 30);
    }
    bottomLine.frame = CGRectMake(KMARGIN, textField.sqBottom, KAPP_WIDTH-KMARGIN*2, 1);
    return textField;
}
/** 创建确认按钮  */
- (UIButton *)creatSureButtonWithString:(NSString *)string top:(CGFloat)top {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:btn];
    btn.backgroundColor = KCOLOR_MAIN;
    [btn setTitle:string forState:UIControlStateNormal];
    btn.layer.cornerRadius = 4;
    btn.layer.masksToBounds = YES;
    btn.frame = CGRectMake(0, top, KAPP_WIDTH-KMARGIN*2, 60);
    btn.sqCenterX = self.sqCenterX;
    return btn;
}
/** 创建textfield上的图片按钮  */
- (UIButton *)creatImageButtonIntextfield:(UITextField *)textfield image:(UIImage *)normale selectImage:(UIImage *)selected {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:normale forState:UIControlStateNormal];
    [button setImage:selected forState:UIControlStateSelected];
    [self addSubview:button];
    button.frame = CGRectMake(textfield.sqRight-44, textfield.sqTop, 44, 44);
    button.sqCenterY = textfield.sqCenterY;
    return button;
}
/** 创建textfield上的文字按钮  */
- (UIButton *)creatTextButtonIntextfield:(UITextField *)textfield text:(NSString *)text {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:KCOLOR_KUP forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    [textfield addSubview:button];
    [button sizeToFit];
    button.sqRight=textfield.sqWidth;
    return button;
}
/** 创建忘记密码按钮  */
- (UIButton *)creatBtnWithTitle:(NSString *)title color:(UIColor *)color top:(CGFloat)top {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, top, 100, 100);
    [self addSubview:button];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button sizeToFit];
    button.sqCenterX = self.sqWidth/2.0;
    return button;
}
- (UIButton *)creatBottomRegistBtn {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, self.sqHeight-100, 100, 100);
    [self addSubview:button];
    [button setTitle:@"注册账号,送0.1BTC" forState:UIControlStateNormal];
    [button setTitleColor:kCOLOR_999 forState:UIControlStateNormal];
    [button sizeToFit];
    button.sqCenterX = self.sqWidth/2.0;
    button.sqBottom = self.sqHeight-KMARGIN*2;
    return button;
}
- (UILabel *)creatUserProtolLabelWithTop:(CGFloat)top {
    UILabel *label = [[UILabel alloc] init];
    label.text = @"我同意《注册使用服务协议》和《个人隐私协议》";
    label.font = KSYSFONT(12);
    label.frame = CGRectMake(KMARGIN, top, KAPP_WIDTH-KMARGIN, 10);
    [self addSubview:label];
    label.userInteractionEnabled = YES;
    WeakSelf(weakSelf);
    [label sq_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakSelf.delegate tapedUserProtocol];
    }];
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:KCOLOR_MAIN
                    range:NSMakeRange(3, 10)];
    [attrStr addAttribute:NSForegroundColorAttributeName
                    value:KCOLOR_MAIN
                    range:NSMakeRange(14, 8)];
    label.attributedText = attrStr;
    
    UIButton    *accept = [UIButton buttonWithType:UIButtonTypeCustom];
    [accept setImage:[UIImage imageNamed:@"login_icon_password"] forState:UIControlStateNormal];
    [self addSubview:accept];
    [accept addTarget:self action:@selector(acceptUserProtocol:) forControlEvents:UIControlEventTouchUpInside];
    accept.frame = CGRectMake(label.sqLeft, label.sqTop, 22, 22);
    label.sqLeft=accept.sqRight;
    return label;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField.placeholder containsString:@"手机号"]) {
        textField.keyboardType = UIKeyboardTypePhonePad;
    }
    if ([textField.placeholder containsString:@"密码"]||
        [textField.placeholder containsString:@"6-16位"]) {
        textField.keyboardType = UIKeyboardTypeASCIICapable;
        textField.secureTextEntry = YES;
    }
    if ([textField.placeholder containsString:@"验证码"]) {
        textField.keyboardType = UIKeyboardTypePhonePad;
    }
}

#pragma mark Notifications:
- (void)textFieldChange:(UITextField *)textField {
    if ([textField.placeholder containsString:@"手机号"]) {
        [WKInputFiledLimitUtils textField:textField limitCount:11 filterEmoji:YES];
        [SQLoginModel shareModel].phoneNumberStr = textField.text;
    }
    if ([textField.placeholder containsString:@"密码"]||
        [textField.placeholder containsString:@"6-16位"]) {
        [WKInputFiledLimitUtils textField:textField limitCount:16 filterEmoji:YES];
        [SQLoginModel shareModel].passWordStr = textField.text;
    }
    if ([textField.placeholder containsString:@"验证码"]) {
        [WKInputFiledLimitUtils textField:textField limitCount:6 filterEmoji:YES];
        [SQLoginModel shareModel].messageVerifyCode = textField.text;
    }
    
    
}


#pragma mark Actions
- (void)showPassWordAct:(UIButton *)btn {
    btn.selected = !btn.selected;
    NSString *text = passwordTextField.text;
    if (btn.selected) {
        passwordTextField.text = @"";
        passwordTextField.secureTextEntry = NO;
        passwordTextField.text = text;
    } else {
        passwordTextField.text = @"";
        passwordTextField.secureTextEntry = YES;
        passwordTextField.text = text;
    }
}

- (void)getVerifyAction {
    [self.codeManager openVerifyCodeView:self];
}
- (void)acceptUserProtocol:(UIButton *)btn {
    btn.selected = !btn.selected;
    isAcceptUserProtocol = btn.selected;
}

- (void)makeSureAction {
    if (self.viewType==loginPage) {
        
    } else if (self.viewType==registPage) {
        if (isAcceptUserProtocol) {
            [self.delegate tapedSureButton];
        } else {
            [SVProgressHUD showInfoWithStatus:@"请同意用户协议!"];
        }
        
    } else if (self.viewType==forgetPsd) {
        
    }
}


- (UITextField *)getTextFieldWithPlace:(NSString *)place {
    for (UITextField *textField in self.subviews) {
        if ([textField isKindOfClass:[UITextField class]]) {
            if ([textField.placeholder containsString:place]) {
                return textField;
            }
        }
    }
    return nil;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




- (NTESVerifyCodeManager *)codeManager {
    if (!_codeManager) {
        _codeManager = [NTESVerifyCodeManager sharedInstance];
        _codeManager.delegate = self;
        // 设置透明度
        _codeManager.alpha = 0.7;
        
        // 设置frame
        _codeManager.frame = CGRectNull;
        // 无感知验证码
        NSString *captchaid = @"50f93d937669429bb2008b2334a67911";
        _codeManager.mode = NTESVerifyCodeNormal;
        [_codeManager configureVerifyCode:captchaid timeout:10.0];
    }
    return _codeManager;
}

#pragma mark - NTESVerifyCodeManagerDelegate
- (void)verifyCodeValidateFinish:(BOOL)result validate:(NSString *)validate message:(NSString *)message{
    if (result) {//成功
        [self.delegate tapedGetVerifyCode];
    }
}


@end
