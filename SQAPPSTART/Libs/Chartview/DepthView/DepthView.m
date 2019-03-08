//
//  DepthView.m
//  Exchange
//
//  Created by mengfanjun on 2018/4/27.
//  Copyright © 2018年 5th. All rights reserved.
//

#import "DepthView.h"
#import "DepthGroupModel.h"
#import "DepthModel.h"
#import "UIColor+Y_StockChart.h"

@implementation DepthView

#pragma mark - 绘图相关方法

#pragma mark drawRect方法
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    if (!self.depthGroupModel) {
        return;
    }
    
    NSMutableArray *bidsPositions = @[].mutableCopy;
    for (DepthModel *depthModel in self.depthGroupModel.showBidsArray) {
        [bidsPositions addObject:[NSValue valueWithCGPoint:depthModel.positionPoint]];
    }
    [self drawTestWithPositions:bidsPositions andType:@"bids"];
    
    NSMutableArray *asksPositions = @[].mutableCopy;
    for (DepthModel *depthModel in self.depthGroupModel.showAsksArray) {
        [asksPositions addObject:[NSValue valueWithCGPoint:depthModel.positionPoint]];
    }
    
    [self drawTestWithPositions:asksPositions andType:@"asks"];
    
}

- (void)drawTestWithPositions:(NSArray *)positions andType:(NSString *)type
{
    if (positions.count == 0) {
        return;
    }
    UIColor *strokeColor;
    UIColor *backgroundColor;
    if ([type isEqualToString:@"bids"]) {
        backgroundColor = [UIColor y_colorWithHexString:@"3BB46E" alpha:0.1];
        strokeColor = [UIColor y_colorWithHexString:@"3BB46E"];
    }
    else if ([type isEqualToString:@"asks"]) {
        backgroundColor = [UIColor y_colorWithHexString:@"EE4343" alpha:0.1];
        strokeColor = [UIColor y_colorWithHexString:@"EE4343"];
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);

    CGContextSetLineWidth(context, 0.5);
    for (NSInteger i = 0; i < positions.count ; i++) {
//        ABCCLog(@"positions:%ld",positions.count);
        CGPoint point = [positions[i] CGPointValue];
        if (i == 0) {
            CGContextMoveToPoint(context, point.x, point.y);

            CGPathMoveToPoint(path, NULL,point.x, self.frame.size.height);
            CGPathAddLineToPoint(path, NULL,point.x, point.y);

        }
        else{
            CGContextAddLineToPoint(context, point.x, point.y);
            CGPathAddLineToPoint(path, NULL, point.x, point.y);

            if (i == positions.count - 1) {
                CGPathAddLineToPoint(path, NULL, point.x, self.frame.size.height);
            }
        }
//        ABCCLog(@"point.x:%f,point.y:%f",point.x,point.y);
    }

    CGPathCloseSubpath(path);
    CGContextStrokePath(context);
    [self drawLinearGradient:context path:path startColor:backgroundColor.CGColor endColor:backgroundColor.CGColor];
    CGPathRelease(path);
}

- (void)drawLinearGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSMutableArray *colors = [NSMutableArray array];
    if (startColor != nil) {
        [colors addObject:(__bridge id) startColor];
    }
    if (endColor != nil) {
        [colors addObject:(__bridge id) endColor];
    }
    
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

#pragma mark 将model转化为Position模型
- (void)private_convertToDepthPositionModelWithDepthGroupModel:(DepthGroupModel *)depthGroupModel {
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    CGFloat maxPrice = depthGroupModel.showMaxPrice.doubleValue;
    CGFloat minPrice = depthGroupModel.showMinPrice.doubleValue;
    
    CGFloat maxAmount = depthGroupModel.showMaxDepthAmount.doubleValue;
    CGFloat minAmount = depthGroupModel.showMinDepthAmount.doubleValue;
    
    CGFloat heightScale = (0 - height) / (maxAmount - minAmount);
    CGFloat widthScale = (0 - width) / (minPrice - maxPrice);
    
    for (int i = 0; i < depthGroupModel.showAsksArray.count; i++) {
        DepthModel *depthModel = depthGroupModel.showAsksArray[i];
        CGFloat xValue = widthScale * (depthModel.price.doubleValue - minPrice);
        CGFloat yValue = heightScale * (depthModel.depthAmount.doubleValue - maxAmount);
        depthModel.positionPoint = CGPointMake(xValue, yValue);
    }
    
    for (int i = 0; i < depthGroupModel.showBidsArray.count; i++) {
        DepthModel *depthModel = depthGroupModel.showBidsArray[i];
        CGFloat xValue = widthScale * (depthModel.price.doubleValue - minPrice);
        CGFloat yValue = heightScale * (depthModel.depthAmount.doubleValue - maxAmount);
        depthModel.positionPoint = CGPointMake(xValue, yValue);
    }
    
}

/**
 *  长按的时候根据原始的x位置获得精确的x的位置
 */
- (void)getExactXPositionWithOriginXPosition:(CGFloat)originXPosition {
    
    DepthModel *lastDepthModel;
    if (originXPosition >= self.frame.size.width / 2) {
        for (int index = 0; index < self.depthGroupModel.showAsksArray.count; index++) {
            DepthModel *depthModel = self.depthGroupModel.showAsksArray[index];
            if (index == 0) {
                if (depthModel.positionPoint.x > originXPosition) {
                    if ([self.delegate respondsToSelector:@selector(depthViewLongPressDepthModel:)]) {
                        [self.delegate depthViewLongPressDepthModel:depthModel];
                    }
                    break;
                }
            }
            if (depthModel.positionPoint.x > originXPosition && lastDepthModel.positionPoint.x < originXPosition) {
                CGFloat leftDistance = ABS(originXPosition - lastDepthModel.positionPoint.x);
                CGFloat rightDistance = ABS(originXPosition - depthModel.positionPoint.x);
                if (leftDistance >= rightDistance) {
                    if ([self.delegate respondsToSelector:@selector(depthViewLongPressDepthModel:)]) {
                        [self.delegate depthViewLongPressDepthModel:depthModel];
                    }
                    break;
                }
                else {
                    if ([self.delegate respondsToSelector:@selector(depthViewLongPressDepthModel:)]) {
                        [self.delegate depthViewLongPressDepthModel:lastDepthModel];
                    }
                    break;
                }
            }
            lastDepthModel = depthModel;
        }
    }
    else {
        for (int index = 0; index < self.depthGroupModel.showBidsArray.count; index++) {
            DepthModel *depthModel = self.depthGroupModel.showBidsArray[index];
            if (index == 0) {
                if (depthModel.positionPoint.x < originXPosition) {
                    if ([self.delegate respondsToSelector:@selector(depthViewLongPressDepthModel:)]) {
                        [self.delegate depthViewLongPressDepthModel:depthModel];
                    }
                    break;
                }
            }
            if (depthModel.positionPoint.x < originXPosition && lastDepthModel.positionPoint.x > originXPosition) {
                CGFloat leftDistance = ABS(originXPosition - depthModel.positionPoint.x);
                CGFloat rightDistance = ABS(originXPosition - lastDepthModel.positionPoint.x);
                if (leftDistance >= rightDistance) {
                    if ([self.delegate respondsToSelector:@selector(depthViewLongPressDepthModel:)]) {
                        [self.delegate depthViewLongPressDepthModel:lastDepthModel];
                    }
                    break;
                }
                else {
                    if ([self.delegate respondsToSelector:@selector(depthViewLongPressDepthModel:)]) {
                        [self.delegate depthViewLongPressDepthModel:depthModel];
                    }
                    break;
                }
            }
            lastDepthModel = depthModel;
        }
    }
}

/**
 重新绘制
 */
- (void)reloaView
{
    [self private_convertToDepthPositionModelWithDepthGroupModel:self.depthGroupModel];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}

#pragma mark - Getters & Setters
- (void)setDepthGroupModel:(DepthGroupModel *)depthGroupModel
{
    _depthGroupModel = depthGroupModel;
    [self reloaView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
