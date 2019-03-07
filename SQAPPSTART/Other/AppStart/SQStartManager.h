//
//  SQStartManager.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQStartManager : NSObject

+ (instancetype)shareManager;

@property (nonatomic, copy) NSString       *userId;

/** 启动时调用 */
- (void)startApplication:(UIApplication *)appcation withOptions:(NSDictionary *)launchOptions;


@end
