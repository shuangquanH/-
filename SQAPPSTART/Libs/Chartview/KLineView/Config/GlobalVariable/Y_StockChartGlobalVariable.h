//
//  Y_StockChartGlobalVariable.h
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Y_StockChartConstant.h"
@interface Y_StockChartGlobalVariable : NSObject

/**
 *  通过样式获得K线图蜡烛的宽度
 */
+(CGFloat)kLineWidthByStyle:(Y_StockChartScreenStyle)style;

/**
 *  K线图蜡烛数量
 */
+(NSInteger)kLineCount;
+(void)setkLineCount:(NSInteger)kLineCount;

/**
 *  K线图的间隔，默认1
 */
+(CGFloat)kLineGap;

+(void)setkLineGap:(CGFloat)kLineGap;


@end
