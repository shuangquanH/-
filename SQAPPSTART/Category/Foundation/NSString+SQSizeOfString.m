//
//  NSString+SQSizeOfString.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSString+SQSizeOfString.h"

@implementation NSString (SQSizeOfString)

- (CGFloat)getWidthWithFont:(UIFont *)font height:(CGFloat)height {
    CGSize infoSize = CGSizeMake(CGFLOAT_MAX, height);
    NSDictionary *dic = @{NSFontAttributeName : font};
    CGRect infoRect =   [self boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return infoRect.size.width;
}


-(CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentJustified;
    paraStyle.hyphenationFactor = 1.0;
    NSDictionary *dic=@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0};
    CGSize size=[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

-(CGFloat)getHeightWithFont:(UIFont *)font width:(CGFloat)width lineSpace:(CGFloat)lineSpace {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paraStyle.alignment = NSTextAlignmentJustified;
    paraStyle.lineSpacing = lineSpace; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    NSDictionary *dic=@{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0};
    CGSize size=[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

@end
