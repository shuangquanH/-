//
//  UIView+SQExtension.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SQExtension)

- (void)changeRoundRadius:(float)radius withBorderColor:(UIColor *)bColor;

- (void)setAllCornerWithRadius:(float)radius;
- (void)setAllCornerWithRadius:(float)radius withBorderColor:(UIColor *)bColor;
- (void)drawDashLineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

@end
