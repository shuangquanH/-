//
//  UIImage+Extension.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SQExtension)

/** 用颜色返回一张图片 */
+ (UIImage *)createImageWithColor:(UIColor*) color;

/** 剪切图片 */
- (UIImage *)circleImage;

@end
