//
//  UITabBar+SQExtension.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (SQExtension)

/// 显示小红点
/// - 参数:
///     - index: tabbarItem的索引
- (void)showBadgeOnItemIndex:(int)index;
/// 隐藏小红点
/// - 参数:
///     - index: tabbarItem的索引
- (void)hideBadgeOnItemIndex:(int)index;


@end
