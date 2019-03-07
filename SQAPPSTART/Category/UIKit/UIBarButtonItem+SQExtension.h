//
//  UIBarButtonItem+SQExtension.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (SQExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

// 右侧 - 文字按钮
+ (UIBarButtonItem *)createRightWordBarButtonForDelegate:(id)delegate title:(NSString *)title textColor:(UIColor*)color action:(SEL)action;


@end
