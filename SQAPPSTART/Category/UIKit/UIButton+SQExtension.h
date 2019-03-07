//
//  UIButton+SQExtension.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (SQExtension)

/** 给btn设置文字（正常和高亮状态） */
- (void) setTitle: (NSString *) title;

/** 给btn设置文字和文字颜色（正常和高亮状态) */
- (void) setTitle: (NSString *) title Color: (UIColor *) color;

//设置默认状态的颜色
- (void)setButtonImageWithUrl:(NSString *)url;

/** 给button设置网络图片  */
- (void)setButtonImageWithUrl:(NSString *)url withType:(UIControlState)state;

/** 开始倒计时 */
-(void)startCountdownWitTime:(NSInteger)timeInt;

@end
