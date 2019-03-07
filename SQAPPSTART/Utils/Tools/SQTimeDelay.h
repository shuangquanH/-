//
//  SQTimeDelay.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQTimeDelay : NSObject

/** 延时执行 */
+ (void)timeDelayWithTime:(CGFloat)delay complet:(void(^)(void))block;

@end
