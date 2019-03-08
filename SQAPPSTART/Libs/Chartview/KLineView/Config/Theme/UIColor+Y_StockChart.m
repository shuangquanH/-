//
//  UIColor+Y_StockChart.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "UIColor+Y_StockChart.h"

@implementation UIColor (Y_StockChart)

+ (UIColor *)colorWithRGBHex:(UInt32)hex {
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}

#pragma mark 所有图表的背景颜色
+(UIColor *)backgroundColor
{
    return [UIColor colorWithRGBHex:0xffffff];
}

#pragma mark 辅助背景色
+(UIColor *)assistBackgroundColor
{
    return [UIColor colorWithRGBHex:0xffffff];
}

#pragma mark 涨的颜色
+(UIColor *)increaseColor
{
    return [UIColor colorWithRGBHex:0x3BB46E];
}

#pragma mark 跌的颜色
+(UIColor *)decreaseColor
{
    return [UIColor colorWithRGBHex:0xEE4343];
}

#pragma mark 主文字颜色
+(UIColor *)mainTextColor
{
    return [UIColor colorWithRGBHex:0xe1e2e6];
}

#pragma mark 辅助文字颜色
+(UIColor *)assistTextColor
{
    return [UIColor colorWithRGBHex:0x565a64];
}

#pragma mark 分时线下面的成交量线的颜色
+(UIColor *)timeLineVolumeLineColor
{
    return [UIColor colorWithRGBHex:0x2d333a];
}

#pragma mark 分时线界面线的颜色
+(UIColor *)timeLineLineColor
{
    return [UIColor colorWithRGBHex:0x49a5ff];
}

#pragma mark 长按时线的颜色
+(UIColor *)longPressLineColor
{
    return [UIColor colorWithRGBHex:0xe1e2e6];
}


#pragma mark 指标线title的颜色
+(UIColor *)accessoryTitleColor
{
    return [UIColor colorWithRGBHex:0x999999];
}

#pragma mark ma5的颜色
+(UIColor *)ma7Color
{
    return [UIColor colorWithRGBHex:0xFF7F0F];
}

#pragma mark ma25颜色
+(UIColor *)ma25Color
{
    return [UIColor colorWithRGBHex:0x5901C3];
}

#pragma mark ma99颜色
+(UIColor *)ma99Color
{
    return [UIColor colorWithRGBHex:0xF03036];
}

#pragma mark ema7颜色
+(UIColor *)ema7Color
{
    return [UIColor colorWithRGBHex:0xFF7F0F];
}

#pragma mark ema25颜色
+(UIColor *)ema25Color
{
    return [UIColor colorWithRGBHex:0x5901C3];
}

#pragma mark ema99颜色
+(UIColor *)ema99Color
{
    return [UIColor colorWithRGBHex:0xF03036];
}

#pragma mark BOLL_MB的颜色
+(UIColor *)BOLL_MBColor
{
    return [UIColor colorWithRGBHex:0xFF7F0F];
}

#pragma mark BOLL_UP的颜色
+(UIColor *)BOLL_UPColor
{
    return [UIColor colorWithRGBHex:0x5901C3];
}

#pragma mark BOLL_DN的颜色
+(UIColor *)BOLL_DNColor
{
    return [UIColor colorWithRGBHex:0xF03036];
}

#pragma mark MACD_DIF颜色
+(UIColor *)MACD_DIFColor
{
    return [UIColor colorWithRGBHex:0xFF7F0F];
}

#pragma mark MACD_DEA的颜色
+(UIColor *)MACD_DEAColor
{
    return [UIColor colorWithRGBHex:0x5901C3];
}

#pragma mark KDJ_K的颜色
+(UIColor *)KDJ_KColor
{
    return [UIColor colorWithRGBHex:0xFF7F0F];
}

#pragma mark KDJ_D的颜色
+(UIColor *)KDJ_DColor
{
    return [UIColor colorWithRGBHex:0x5901C3];
}

#pragma mark KDJ_J的颜色
+(UIColor *)KDJ_JColor
{
    return [UIColor colorWithRGBHex:0xF1464C];
}

#pragma mark RSI_7的颜色
+(UIColor *)RSI_7Color
{
    return [UIColor colorWithRGBHex:0xFF7F0F];
}

#pragma mark RSI_14的颜色
+(UIColor *)RSI_14Color
{
    return [UIColor colorWithRGBHex:0x5901C3];
}

#pragma mark RSI_28的颜色
+(UIColor *)RSI_28Color
{
    return [UIColor colorWithRGBHex:0xF1464C];
}

+ (UIColor *)y_colorWithHexString:(NSString *)color
{
    return [UIColor y_colorWithHexString:color alpha:1];
}

+ (UIColor *)y_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
