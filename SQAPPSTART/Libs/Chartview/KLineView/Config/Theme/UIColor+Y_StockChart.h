//
//  UIColor+Y_StockChart.h
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Y_StockChart)

/**
 *  根据十六进制转换成UIColor
 *
 *  @param hex UIColor的十六进制
 *
 *  @return 转换后的结果
 */
+(UIColor *)colorWithRGBHex:(UInt32)hex;

/**
 *  所有图表的背景颜色
 */
+(UIColor *)backgroundColor;

/**
 *  辅助背景色
 */
+(UIColor *)assistBackgroundColor;

/**
 *  涨的颜色
 */
+(UIColor *)increaseColor;


/**
 *  跌的颜色
 */
+(UIColor *)decreaseColor;

/**
 *  主文字颜色
 */
+(UIColor *)mainTextColor;

/**
 *  辅助文字颜色
 */
+(UIColor *)assistTextColor;

/**
 *  分时线下面的成交量线的颜色
 */
+(UIColor *)timeLineVolumeLineColor;

/**
 *  分时线界面线的颜色
 */
+(UIColor *)timeLineLineColor;

/**
 *  长按时线的颜色
 */
+(UIColor *)longPressLineColor;

/**
 *  指标线title的颜色
 */
+(UIColor *)accessoryTitleColor;

/**
 *  ma5的颜色
 */
+(UIColor *)ma7Color;

/**
 *  ma25颜色
 */
+(UIColor *)ma25Color;

/**
 *  ma99颜色
 */
+(UIColor *)ma99Color;

/**
 *  ma5的颜色
 */
+(UIColor *)ema7Color;

/**
 *  ma25颜色
 */
+(UIColor *)ema25Color;

/**
 *  ma99颜色
 */
+(UIColor *)ema99Color;

/**
 *  BOLL_MB颜色
 */
+(UIColor *)BOLL_MBColor;

/**
 *  BOLL_UP颜色
 */
+(UIColor *)BOLL_UPColor;

/**
 *  BOLL_DN颜色
 */
+(UIColor *)BOLL_DNColor;

/**
 *  MACD_DIF颜色
 */
+(UIColor *)MACD_DIFColor;

/**
 *  MACD_DEA颜色
 */
+(UIColor *)MACD_DEAColor;

/**
 *  KDJ_K颜色
 */
+(UIColor *)KDJ_KColor;

/**
 *  KDJ_D颜色
 */
+(UIColor *)KDJ_DColor;

/**
 *  KDJ_J颜色
 */
+(UIColor *)KDJ_JColor;

/**
 *  RSI_7颜色
 */
+(UIColor *)RSI_7Color;

/**
 *  RSI_14颜色
 */
+(UIColor *)RSI_14Color;

/**
 *  RSI_28颜色
 */
+(UIColor *)RSI_28Color;

/**
 十六进制创建color
 
 @param color 十六进制色值
 @return 颜色对象
 */
+ (UIColor *)y_colorWithHexString:(NSString *)color;

/**
 十六进制创建color
 
 @param color 十六进制色值
 @param alpha 透明度:0-1
 @return 颜色对象
 */
+ (UIColor *)y_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
