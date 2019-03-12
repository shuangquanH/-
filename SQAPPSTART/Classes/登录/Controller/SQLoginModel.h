//
//  SQLoginModel.h
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum : NSUInteger {
    loginPage,
    registPage,
    forgetPsd,
} SQLoginViewType;


@interface SQLoginModel : NSObject


@property (nonatomic, copy) NSString       *phoneNumberStr;
@property (nonatomic, copy) NSString       *passWordStr;
@property (nonatomic, copy) NSString       *messageVerifyCode;
@property (nonatomic, copy) NSString       *userNameStr;

//手机UUID -> 用于获得图形验证码
@property (nonatomic, copy) NSString        *phoneCode;
/** 登录之前所在的控制器  */
@property (nonatomic, weak) SQBaseViewController    *sourceVC;


/** 初始化  */
+ (SQLoginModel *)shareModel;


@end

NS_ASSUME_NONNULL_END
