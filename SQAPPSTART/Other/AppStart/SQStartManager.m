//
//  SQStartManager.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQStartManager.h"

#import "UMMobClick/MobClick.h"
#import "IQKeyboardManager.h"


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
    
    
    /** UMeng统计  */
    UMConfigInstance.appKey = KUMAPPKEY;
    [MobClick setAppVersion:[self getAppVersion]];
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    
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
