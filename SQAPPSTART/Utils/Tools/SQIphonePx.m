//
//  SQIphonePx.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQIphonePx.h"

@implementation SQIphonePx

+ (instancetype)shareInstance {
    static SQIphonePx *iphonePx = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        iphonePx = [[SQIphonePx alloc] init];
    });
    return iphonePx;
}

- (instancetype)init {
    if (self = [super init]) {
        _phoneWidth = [UIScreen mainScreen].bounds.size.width;
        _phoneHeight = [UIScreen mainScreen].bounds.size.height;
        _navHeight = (self.isiPhoneX == YES ? 88.0f : 64.0f);
        _tabHeight = (self.isiPhoneX == YES ? 83.0f : 49.0f);
        _statuHeight = (self.isiPhoneX == YES ? 44.0f : 20.0f);
        _uiScaling = (_phoneWidth/750.0);
    }
    return self;
}
- (BOOL)isiPhoneX {
    if (!_isiPhoneX) {
        if (@available(iOS 11.0, *)) {
            if ([UIApplication sharedApplication].delegate.window.safeAreaInsets.bottom > 0) {//iphoneX横屏
                _isiPhoneX = YES;
            } else {
                _isiPhoneX = NO;
            }
        } else {
            _isiPhoneX = NO;
        }
    }
    return _isiPhoneX;
}


@end
