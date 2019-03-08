//
//  Y_LayoutViewUtil.m
//  Y_ChartView
//
//  Created by 程守斌 on 2019/1/3.
//

#import "Y_LayoutViewUtil.h"

@implementation Y_LayoutViewUtil

//MARK: - 初始化相关
/// 获取单例
+ (instancetype)sharedInstance {
    static Y_LayoutViewUtil *singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singleton = [[Y_LayoutViewUtil alloc] init];
    });
    return singleton;
}

- (instancetype)init {
    if (self = [super init]) {
        _screenWidth = [UIScreen mainScreen].bounds.size.width;
        _screenHeight = [UIScreen mainScreen].bounds.size.height;
        _scaling = _screenWidth / 375.0;
        /*
         iPhone X && iPhone XR 尺寸CGSizeMake(1125, 2436)
         iPhone XS 尺寸CGSizeMake(828, 1792)
         iPhone XS Max 尺寸CGSizeMake(1242, 2688)
         */
        _isiPhoneXType = [UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) ||  CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) ||  CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO;
        _statusBarHeight = (_isiPhoneXType ? 44.0f : 20.0f);
        _navBarHeight = (_isiPhoneXType ? 88.0f : 64.0f);
        _tabBarHeight = (_isiPhoneXType ? 83.0f : 49.0f);
        _safeAreaBottomHeight = (_isiPhoneXType ? 34.0f : 0);
        _topLiuHeight = 30;
    }
    return self;
}

@end
