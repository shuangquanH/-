//
//  Y_TimeLine.m
//  Exchange
//
//  Created by ly on 2018/10/24.
//  Copyright © 2018 5th. All rights reserved.
//

#import "Y_TimeLine.h"
#import "UIColor+Y_StockChart.h"
#import "Y_StockChartConstant.h"
#import "UIFont+Y_StockChart.h"
#import "NSString+Y_StockChart.h"

@interface Y_TimeLine ()

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

@implementation Y_TimeLine
/**
 *  根据context初始化画线
 */
- (instancetype)initWithContext:(CGContextRef)context
{
    self = [super init];
    if(self)
    {
        self.context = context;
        self.lastDrawDatePoint = CGPointZero;
        _maxCount = 0;
        _index = 0;
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
    
    CGMutablePathRef path = CGPathCreateMutable();
    
    for (NSInteger idx = 0; idx < self.positions.count ; idx++) {
        CGPoint point = [self.positions[idx] CGPointValue];
        _index = idx;
        [self drawTimeStr:point timeStr:self.timeArray[idx]];
        //必须在日期之后设置画笔颜色，因为画日期时会改变画笔颜色
        CGContextSetStrokeColorWithColor(self.context, self.timeLineColor.CGColor);
        CGContextSetLineWidth(self.context, Y_StockChartMALineWidth);
        if (idx == 0) {
            CGContextMoveToPoint(self.context, point.x, point.y);
            
            CGPoint firstPoint = CGPointMake(point.x, self.maxY);
            CGPathMoveToPoint(path, NULL, firstPoint.x, firstPoint.y);
            CGPathAddLineToPoint(path, NULL,point.x, point.y);
        }
        CGContextAddLineToPoint(self.context, point.x, point.y);
        CGPathAddLineToPoint(path, NULL, point.x, point.y);
        
        if (idx == self.positions.count - 1) {
            CGPoint lastPoint = CGPointMake(point.x, self.maxY);
            CGPathAddLineToPoint(path, NULL, lastPoint.x, lastPoint.y);
        }
    }
    CGPathCloseSubpath(path);
    CGContextStrokePath(self.context);
    [self drawLinearGradient:self.context path:path startColor:self.timeFillColor.CGColor endColor:[[UIColor whiteColor] colorWithAlphaComponent:0.2].CGColor];
    CGPathRelease(path);
    
}

- (void)drawTimeStr:(CGPoint)point timeStr:(NSString *)time{
    NSString *dateStr = time;
    UIFont *font = [UIFont y_customFontWithName:@"DIN-Regular" size:8];
    NSMutableParagraphStyle * paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    if (_index == 0) {
        CGPoint drawDatePoint = CGPointMake(point.x - self.kLineWidth / 2, self.timeY + 1.5);
        
        [dateStr drawAtPoint:drawDatePoint withAttributes:@{NSFontAttributeName : font,NSForegroundColorAttributeName : [UIColor y_colorWithHexString:@"111111" alpha:0.5],NSParagraphStyleAttributeName : paragraphStyle}];
        self.lastDrawDatePoint = drawDatePoint;
    } else if (_index == _maxCount - 1) {
        CGSize textSize = [dateStr y_sizeWithFont:font andMaxSize:CGSizeZero];
        CGPoint drawDatePoint = CGPointMake(point.x - textSize.width, self.timeY + 1.5);
        
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
        if (drawDatePoint.x <= point.x && drawDatePoint.x > (point.x - self.kLineWidth - self.kLineGap)) {
            [dateStr drawAtPoint:drawDatePoint withAttributes:@{NSFontAttributeName : font,NSForegroundColorAttributeName : [UIColor y_colorWithHexString:@"111111" alpha:0.5],NSParagraphStyleAttributeName : paragraphStyle}];
            self.lastDrawDatePoint = drawDatePoint;
        }
        
    }
    
}

#pragma mark - 重绘分时图
- (UIColor *)timeLineColor {
    if (!_timeLineColor) {
        _timeLineColor = [UIColor mainTextColor];
    }
    return _timeLineColor;
}

- (UIColor *)timeFillColor {
    if (!_timeFillColor) {
        _timeFillColor = [UIColor whiteColor];
    }
    return _timeFillColor;
}

- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGRect pathRect = CGPathGetBoundingBox(path);
    
    //具体方向可根据需求修改 可改变方向是的渐变颜色45°或者垂直方向渐变颜色
    CGPoint startPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMinY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMaxY(pathRect));
    
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
