//
//  SQTimeDelay.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQTimeDelay.h"

@implementation SQTimeDelay

+ (void)timeDelayWithTime:(CGFloat)delay complet:(void(^)(void))block {
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay*NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), block);
}
@end
