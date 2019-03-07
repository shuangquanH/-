//
//  NSString+SQSizeOfString.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SQSizeOfString)

/**根据宽度计算文字高度*/
-(CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width;

/**根据宽度计算文字高度(带行间距)*/
-(CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace;

@end
