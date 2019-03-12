//
//  SQLoginView.m
//  QingYouProject
//
//  Created by qwuser on 2018/7/6.
//  Copyright © 2018年 ccyouge. All rights reserved.
//

#import "SQLoginView.h"
#import "WKInputFiledLimitUtils.h"


/** TextFieldPlacelod  */
#define KPHONESTR       @"手机号"
#define KPASSWORD       @"密码"
#define KFUJIAMA        @"附加码"
#define KVERIFYCODE     @"验证码"
#define KSETNAME        @"姓名2~12个字"
#define KSETPSD         @"密码6-16位"
#define KINVETCODE      @"邀请码 非必填"
#define KSETCOMPYNAME   @"企业名"
#define KSETJOBSTR      @"职务"
#define KSETNEWPSD      @"设置新密码"
#define KREPETPSD       @"确认密码"



@implementation SQLoginView {
    BOOL didCompletPhone;
    BOOL didCompletPsswd;//登录密码
    BOOL didCompletFujia;
    BOOL didCompletVerify;
    BOOL didCompletName;
    BOOL didCompletCompany;
    BOOL didCompletJob;
    BOOL didCompletSetPsd;//设置密码
    BOOL didCompletSetNewPsd;//设置新密码
    BOOL didCompletRePsd;//重复密码
}

- (void)setViewType:(SQLoginViewType)viewType {
    _viewType = viewType;
    self.backgroundColor = KCOLOR_WHIT;
    
    switch (viewType) {
            
        case loginPage:/** 登陆页  */
        {
            UIButton *closebtn = [self creatCloseButton];
            UILabel *title = [self creatTitleWithFont:KSYSFONT(32) title:@"登录" top:closebtn.sqBottom+KMARGIN];
            UITextField *phone = [self creatTextFieldWithString:@"请输入手机号" top:title.sqBottom+KMARGIN*2];
            UITextField *passwd = [self creatTextFieldWithString:@"请输入密码" top:phone.sqBottom+KMARGIN*2];
            UIButton *showPasswd = [self creatImageButtonIntextfield:passwd image:[UIImage imageNamed:@"login_icon_password"] selectImage:[UIImage imageNamed:@"login_icon_password"]];
            [showPasswd addTarget:self action:@selector(showPassWordAct) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton    *sure = [self creatSureButtonWithString:@"登录" top:passwd.sqBottom+KMARGIN*2];
            [sure addTarget:self.delegate action:@selector(tapedSureButton) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton    *bleft = [self creatBottomLeftBtnWithTitle:@"忘记密码" color:kCOLOR_999 top:sure.sqBottom+KMARGIN*2];
            [bleft addTarget:self.delegate action:@selector(tapedForgetPsswdButton) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton    *bright = [self creatBottomRightBtnWithTitle:@"立即注册" color:KCOLOR_MAIN top:bleft.sqTop];
            [bright addTarget:self.delegate action:@selector(tapedRegistButton) forControlEvents:UIControlEventTouchUpInside];
            

        }
            break;
            
        case registPage:/** 注册页  */
        {
            UIButton *backButton = [self creatBackButton];
            UILabel *title = [self creatTitleWithFont:KSYSFONT(32) title:@"注册" top:backButton.sqBottom+KMARGIN];
            UITextField *phone = [self creatTextFieldWithString:@"本人实名手机号" top:title.sqBottom+KMARGIN*2];
            UITextField *verify = [self creatTextFieldWithString:@"请输入短信验证码" top:phone.sqBottom+KMARGIN*2];
            UIButton *getVerifyBtn = [self creatTextButtonIntextfield:verify text:@"获取验证码"];
            [getVerifyBtn addTarget:self action:@selector(getVerifyAction) forControlEvents:UIControlEventTouchUpInside];
            
            UITextField *passwd = [self creatTextFieldWithString:@"6-16位的数字或字母" top:verify.sqBottom+KMARGIN*2];
            UIButton *showPasswd = [self creatImageButtonIntextfield:passwd image:[UIImage imageNamed:@"login_icon_password"] selectImage:[UIImage imageNamed:@"login_icon_password"]];
            [showPasswd addTarget:self action:@selector(showPassWordAct) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton    *sure = [self creatSureButtonWithString:@"立即注册" top:passwd.sqBottom+KMARGIN*2];
            [sure addTarget:self.delegate action:@selector(tapedSureButton) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton    *bleft = [self creatBottomLeftBtnWithTitle:@"已有账号" color:kCOLOR_999 top:sure.sqBottom+KMARGIN*2];
            [bleft addTarget:self.delegate action:@selector(tapedGoToLogin) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton    *bright = [self creatBottomRightBtnWithTitle:@"马上登录" color:KCOLOR_MAIN top:bleft.sqTop];
            [bright addTarget:self.delegate action:@selector(tapedGoToLogin) forControlEvents:UIControlEventTouchUpInside];

        }
            break;
            
        case forgetPsd:
        {
            UIButton *backButton = [self creatBackButton];
            UILabel *title = [self creatTitleWithFont:KSYSFONT(32) title:@"忘记密码" top:backButton.sqBottom+KMARGIN];
            UITextField *phone = [self creatTextFieldWithString:@"本人实名手机号" top:title.sqBottom+KMARGIN*2];
            UITextField *verify = [self creatTextFieldWithString:@"请输入短信验证码" top:phone.sqBottom+KMARGIN*2];
            UIButton *getVerifyBtn = [self creatTextButtonIntextfield:verify text:@"获取验证码"];
            [getVerifyBtn addTarget:self action:@selector(getVerifyAction) forControlEvents:UIControlEventTouchUpInside];
            
            UITextField *passwd = [self creatTextFieldWithString:@"6-16位的数字或字母" top:verify.sqBottom+KMARGIN*2];
            UIButton *showPasswd = [self creatImageButtonIntextfield:passwd image:[UIImage imageNamed:@"login_icon_password"] selectImage:[UIImage imageNamed:@"login_icon_password"]];
            [showPasswd addTarget:self action:@selector(showPassWordAct) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton    *sure = [self creatSureButtonWithString:@"立即注册" top:passwd.sqBottom+KMARGIN*2];
            [sure addTarget:self.delegate action:@selector(tapedSureButton) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton    *bleft = [self creatBottomLeftBtnWithTitle:@"已有账号" color:kCOLOR_999 top:sure.sqBottom+KMARGIN*2];
            [bleft addTarget:self.delegate action:@selector(tapedGoToLogin) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton    *bright = [self creatBottomRightBtnWithTitle:@"马上登录" color:KCOLOR_MAIN top:bleft.sqTop];
            [bright addTarget:self.delegate action:@selector(tapedGoToLogin) forControlEvents:UIControlEventTouchUpInside];
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

/** 创建title并返回底部的y坐标  */
- (UILabel *)creatTitleWithFont:(UIFont *)font title:(NSString *)title top:(CGFloat)top{
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = font;
    label.frame = CGRectMake(KMARGIN, top, KAPP_WIDTH, 60);
    [self addSubview:label];
    return label;
}

/** 创建输入框  */
- (UITextField *)creatTextFieldWithString:(NSString *)plachode top:(CGFloat)top{
    UITextField *textField = [[UITextField alloc] init];
    [self addSubview:textField];
    textField.placeholder = plachode;
    UIView  *bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = KCOLOR_LINE;
    [textField addSubview:bottomLine];
    
    textField.delegate = self;
    [textField addTarget:self action:@selector(textFieldChange:) forControlEvents:UIControlEventAllEditingEvents];
    [textField setValue:kCOLOR_999 forKeyPath:@"_placeholderLabel.textColor"];
    
    
    textField.frame = CGRectMake(0, top, KAPP_WIDTH-2*KMARGIN, 60);
    textField.sqCenterX=self.sqCenterX;
    bottomLine.frame = CGRectMake(0, textField.sqHeight-1, textField.sqWidth, 1);
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
    [textfield addSubview:button];
    [button sizeToFit];
    button.sqRight=textfield.sqWidth;
    button.sqCenterY = textfield.sqHeight/2.0;
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
/** 创建底部左边按钮  */
- (UIButton *)creatBottomLeftBtnWithTitle:(NSString *)title color:(UIColor *)color top:(CGFloat)top {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, top, 100, 100);
    [self addSubview:button];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button sizeToFit];
    button.sqLeft = KAPP_WIDTH/2.0-button.sqWidth-KMARGIN;
    return button;
}
/** 创建底部右边按钮  */
- (UIButton *)creatBottomRightBtnWithTitle:(NSString *)title color:(UIColor *)color top:(CGFloat)top {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, top, 100, 100);
    [self addSubview:button];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button sizeToFit];
    button.sqLeft = KAPP_WIDTH/2.0+KMARGIN;
    return button;
}


- (void)textFieldDidBeginEditing:(UITextField *)textField {
}

#pragma mark Notifications:
- (void)textFieldChange:(UITextField *)textField {
}



- (void)showPassWordAct {
    
}
- (void)getVerifyAction {
    
}



- (UITextField *)getTextFieldWithPlace:(NSString *)place {
    for (UITextField *textField in self.subviews) {
        if ([textField isKindOfClass:[UITextField class]]) {
            if ([textField.placeholder isEqualToString:place]) {
                return textField;
            }
        }
    }
    return nil;
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
