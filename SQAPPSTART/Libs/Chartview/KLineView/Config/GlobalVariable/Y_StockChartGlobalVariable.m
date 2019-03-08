//
//  Y_StockChartGlobalVariable.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//
#import "Y_StockChartGlobalVariable.h"
#import "Y_LayoutViewUtil.h"

/**
 *  K线图展示的蜡烛个数
 */
static CGFloat Y_StockChartKLineCount = Y_StockChartKLineMaxCount;

/**
 *  K线图的间隔，默认1
 */
static CGFloat Y_StockChartKLineGap = 1;


@implementation Y_StockChartGlobalVariable

+(CGFloat)kLineWidthByStyle:(Y_StockChartScreenStyle)style {
    if (style == Y_StockChartScreenStyleHalf) {
        CGFloat kLineViewWidth = [Y_LayoutViewUtil sharedInstance].screenWidth - 28 * 2;
        CGFloat klineWidth = (Y_StockChartKLineCount == 0?0 : ((kLineViewWidth + Y_StockChartKLineGap) / Y_StockChartKLineCount - Y_StockChartKLineGap));
        return klineWidth;
    } else if (style == Y_StockChartScreenStyleFull) {
        CGFloat kLineViewWidth = [Y_LayoutViewUtil sharedInstance].screenHeight - 93;
        CGFloat klineWidth = (Y_StockChartKLineCount == 0?0 : ((kLineViewWidth + Y_StockChartKLineGap) / Y_StockChartKLineCount - Y_StockChartKLineGap));
        return klineWidth;
    }
    return 0;
}

+ (NSInteger)kLineCount {
    return Y_StockChartKLineCount;
}

+ (void)setkLineCount:(NSInteger)kLineCount {
    if (kLineCount > Y_StockChartKLineMaxCount) {
        kLineCount = Y_StockChartKLineMaxCount;
    }else if (kLineCount < Y_StockChartKLineMinCount) {
        kLineCount = Y_StockChartKLineMinCount;
    }
    Y_StockChartKLineCount = kLineCount;
}

/**
 *  K线图的间隔，默认1
 */
+ (CGFloat)kLineGap {
    return Y_StockChartKLineGap;
}

+ (void)setkLineGap:(CGFloat)kLineGap {
    Y_StockChartKLineGap = kLineGap;
}


@end
