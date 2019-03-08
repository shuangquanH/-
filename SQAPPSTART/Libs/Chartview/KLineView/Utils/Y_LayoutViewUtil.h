//
//  Y_LayoutViewUtil.h
//  Y_ChartView
//
//  Created by 程守斌 on 2019/1/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Y_LayoutViewUtil : NSObject

/// 屏幕宽度（竖屏）
@property (nonatomic, assign) CGFloat screenWidth;

/// 屏幕高度（竖屏）
@property (nonatomic, assign) CGFloat screenHeight;

/// 相对UI设计图缩放比例
@property (nonatomic, assign) CGFloat scaling;

/// 是否是iPhoneX类型手机，如iPhone X、iPhone XS、iPhone XS Max，iPhone XR
@property (nonatomic, assign) BOOL isiPhoneXType;

/// 状态栏高度
@property (nonatomic, assign) CGFloat statusBarHeight;

/// 导航栏高度
@property (nonatomic, assign) CGFloat navBarHeight;

/// 标签栏高度
@property (nonatomic, assign) CGFloat tabBarHeight;

/// 顶部刘海高度
@property (nonatomic, assign) CGFloat topLiuHeight;

/// 底部安全区域高度
@property (nonatomic, assign) CGFloat safeAreaBottomHeight;

/// 获取单例
+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
