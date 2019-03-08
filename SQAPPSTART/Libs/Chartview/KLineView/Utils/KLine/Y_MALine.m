//
//  Y_MALine.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_MALine.h"
#import "UIColor+Y_StockChart.h"
#import "Y_StockChartConstant.h"
@interface Y_MALine ()

@property (nonatomic, assign) CGContextRef context;
/**
 *  最后一个绘制日期点
 */
@property (nonatomic, assign) CGPoint lastDrawDatePoint;
@end

@implementation Y_MALine

/**
 *  根据context初始化画线
 */
- (instancetype)initWithContext:(CGContextRef)context
{
    self = [super init];
    if(self)
    {
        self.context = context;
    }
    return self;
}

- (void)draw
{
    if(!self.context)
    {
        return;
    }
    
    if(!self.positions || self.positions.count == 0) {
        return;
    }
    
    CGContextSetStrokeColorWithColor(self.context, self.timeLineColor.CGColor);
    
    CGContextSetLineWidth(self.context, Y_StockChartMALineWidth);
    
    CGPoint firstPoint = [self.positions.firstObject CGPointValue];
    NSAssert(!isnan(firstPoint.x) && !isnan(firstPoint.y), @"出现NAN值：BOLL画线");
    CGContextMoveToPoint(self.context, firstPoint.x, firstPoint.y);
    
    for (NSInteger idx = 1; idx < self.positions.count ; idx++)
    {
        CGPoint point = [self.positions[idx] CGPointValue];
        CGContextAddLineToPoint(self.context, point.x, point.y);
    }
    CGContextSetLineDash(self.context, 0, 0, 0);
    CGContextStrokePath(self.context);
}



#pragma mark - 重绘分时图
- (UIColor *)timeLineColor {
    if (!_timeLineColor) {
        _timeLineColor = [UIColor mainTextColor];
    }
    return _timeLineColor;
}

@end

