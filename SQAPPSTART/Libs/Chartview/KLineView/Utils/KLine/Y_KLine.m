//
//  Y_KLine.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLine.h"
#import "UIColor+Y_StockChart.h"
#import "Y_StockChartConstant.h"
#import "UIFont+Y_StockChart.h"
#import "NSString+Y_StockChart.h"

@interface Y_KLine()

/**
 *  context
 */
@property (nonatomic, assign) CGContextRef context;

/**
 *  最后一个绘制日期点
 */
@property (nonatomic, assign) CGPoint lastDrawDatePoint;

/**
 *  横坐标x之间的间距
 */
@property (nonatomic, assign) CGFloat widthX;

@end

@implementation Y_KLine

#pragma mark 根据context初始化
- (instancetype)initWithContext:(CGContextRef)context
{
    self = [super init];
    if (self) {
        _context = context;
        _lastDrawDatePoint = CGPointZero;
        _maxCount = 0;
        _index = 0;
    }
    return self;
}

#pragma 绘制K线 - 单个
- (void)draw
{
    //判断数据是否为空
    if(!self.kLineModel || !self.context || !self.kLinePositionModel)
    {
        return;
    }
    
    CGContextRef context = self.context;
    
    //设置画笔颜色
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    
    //画中间较宽的开收盘线段-实体线
    CGContextSetLineWidth(context, self.kLineWidth);
    const CGPoint solidPoints[] = {self.kLinePositionModel.OpenPoint, self.kLinePositionModel.ClosePoint};
    //画线
    CGContextStrokeLineSegments(context, solidPoints, 2);
    
    //画上下影线
    CGContextSetLineWidth(context, Y_StockChartShadowLineWidth);
    const CGPoint shadowPoints[] = {self.kLinePositionModel.HighPoint, self.kLinePositionModel.LowPoint};
    //画线
    CGContextStrokeLineSegments(context, shadowPoints, 2);
    
    //画横坐标时间
    [self drawTimeStr];
}


- (void)drawTimeStr {
    NSString *dateStr = self.kLineModel.kLineTypeFormatDate;
    UIFont *font = [UIFont y_customFontWithName:@"DIN-Regular" size:8];
    NSMutableParagraphStyle * paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    if (_index == 0) {
        CGPoint drawDatePoint = CGPointMake(self.kLinePositionModel.LowPoint.x - self.kLineWidth / 2, self.timeY + 1.5);
        
        [dateStr drawAtPoint:drawDatePoint withAttributes:@{NSFontAttributeName : font,NSForegroundColorAttributeName : [UIColor y_colorWithHexString:@"111111" alpha:0.5],NSParagraphStyleAttributeName : paragraphStyle}];
        self.lastDrawDatePoint = drawDatePoint;
    } else if (_index == _maxCount - 1) {
        CGSize textSize = [dateStr y_sizeWithFont:font andMaxSize:CGSizeZero];
        CGPoint drawDatePoint = CGPointMake(self.kLinePositionModel.LowPoint.x + self.kLineWidth / 2 - textSize.width, self.timeY + 1.5);
        
        if ( drawDatePoint.x >= self.lastDrawDatePoint.x + self.widthX ) {
            [dateStr drawAtPoint:drawDatePoint withAttributes:@{NSFontAttributeName : font,NSForegroundColorAttributeName : [UIColor y_colorWithHexString:@"111111" alpha:0.5],NSParagraphStyleAttributeName : paragraphStyle}];
            self.lastDrawDatePoint = drawDatePoint;
        }
    } else {
        if (self.widthX == 0) {
            CGSize textSize = [dateStr y_sizeWithFont:font andMaxSize:CGSizeZero];
            self.widthX = (self.parentWidth - textSize.width) / 6;
        }
        
        CGPoint drawDatePoint = CGPointMake(self.lastDrawDatePoint.x + self.widthX, self.timeY + 1.5);
        if (drawDatePoint.x <= self.kLinePositionModel.LowPoint.x && drawDatePoint.x > (self.kLinePositionModel.LowPoint.x - self.kLineWidth - self.kLineGap)) {
            [dateStr drawAtPoint:drawDatePoint withAttributes:@{NSFontAttributeName : font,NSForegroundColorAttributeName : [UIColor y_colorWithHexString:@"111111" alpha:0.5],NSParagraphStyleAttributeName : paragraphStyle}];
            self.lastDrawDatePoint = drawDatePoint;
        }
    }
}

- (UIColor *)strokeColor {
    if (!_strokeColor) {
        _strokeColor = [UIColor whiteColor];
    }
    return _strokeColor;
}

@end
