//
//  UITableView+SQAddHeadTip.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (SQAddHeadTip)

/// tableview 要添加提示的列表tableview
/// tishi 自定义要提示的文字内容
/// time 提示条停留的时间
/// height 提示条的高度
/// textColor 提示文字的颜色
/// backgroundColor 提示框背景颜色
/// font 提示文字的大小

- (void)addTip:(NSString *)title stayTime:(NSInteger)stime height:(CGFloat)height color:(UIColor *)tcolor backgroundColor:(UIColor *)bcolor font:(UIFont *)font;

/// tableview 要添加提示的列表tableview
/// tishi 自定义要提示的文字内容
- (void)addTipWithTitle:(NSString   *)title;

@end
