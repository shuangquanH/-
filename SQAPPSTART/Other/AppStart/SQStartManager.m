//
//  SQStartManager.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQStartManager.h"

#import "UMMobClick/MobClick.h"
#import <UMSocialCore/UMSocialCore.h>
#import "IQKeyboardManager.h"
#import <Pingpp.h>



@implementation SQStartManager

+ (instancetype)shareManager {
    static SQStartManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SQStartManager alloc] init];
    });
    return manager;
}

- (void)startApplication:(UIApplication *)appcation withOptions:(NSDictionary *)launchOptions {
    
    /** UMengShareSDK  */
    //打开调试日志
    [[UMSocialManager defaultManager] openLog:YES];
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:KUMAPPKEY];
    //设置微信AppId、appSecret，分享url
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:KUMAPPKEYWXAPPID appSecret:KUMAPPKEYWXAPPSECRET redirectURL:KUMAPPKEYWXURL];
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:KUMAPPKEYQQAPPID  appSecret:nil redirectURL:KUMAPPKEYQQURL];
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:KUMAPPKEYSINAAPPID  appSecret:nil redirectURL:KUMAPPKEYSINAURL];
    
    /** UMeng统计  */
    UMConfigInstance.appKey = KUMAPPKEY;
    
    [MobClick setAppVersion:[self getAppVersion]];
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
    [Pingpp setAppId:KPINGPPAPPID];
    [Pingpp setDebugMode:YES];
    
    
    /** IQKeyBoardManager  */
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = NO;
    manager.enableAutoToolbar = YES;
    manager.toolbarManageBehaviour = IQAutoToolbarByPosition;
    manager.toolbarTintColor = KCOLOR_MAIN;
    
    self.userId = [[NSUserDefaults standardUserDefaults] valueForKey:KUSERIDKEY];   
}

- (void)setUserId:(NSString *)userId {
    _userId = userId;
    [[NSUserDefaults standardUserDefaults] setValue:userId forKey:KUSERIDKEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
}


@end
