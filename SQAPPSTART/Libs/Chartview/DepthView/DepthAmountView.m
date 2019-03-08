//
//  DepthAmountView.m
//  Exchange
//
//  Created by mengfanjun on 2018/5/12.
//  Copyright © 2018年 5th. All rights reserved.
//

#import "DepthAmountView.h"
#import "DepthGroupModel.h"
#import "DepthModel.h"
#import "DepthChartView.h"
#import "UIColor+Y_StockChart.h"
#import "UIFont+Y_StockChart.h"
#import "NSString+Y_StockChart.h"

@interface DepthAmountView ()

@property (nonatomic, strong) NSMutableArray *amountArray;
@property (nonatomic, strong) NSMutableArray *positionsArray;

@end

@implementation DepthAmountView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);

    if (!self.depthGroupModel) {
        return;
    }
    
    CGContextSetStrokeColorWithColor(context, [UIColor y_colorWithHexString:@"000000" alpha:0.1].CGColor);
    CGContextSetLineWidth(context, 0.5);
    CGContextMoveToPoint(context, 0, 0);
    CGContextAddLineToPoint(context, 0, self.frame.size.height);
    
    for (NSInteger i = 0; i < self.positionsArray.count ; i++) {
        CGPoint point = [self.positionsArray[i] CGPointValue];

        NSString *amountStr = self.amountArray[i];
        if (i == self.positionsArray.count - 1) {
            [amountStr drawAtPoint:CGPointMake(point.x, point.y - 12) withAttributes:@{NSFontAttributeName:[UIFont y_customFontWithName:@"DIN-Regular" size:8],NSForegroundColorAttributeName:[UIColor y_colorWithHexString:@"111111" alpha:0.5]}];
        }
        else {
            [amountStr drawAtPoint:CGPointMake(point.x, point.y) withAttributes:@{NSFontAttributeName:[UIFont y_customFontWithName:@"DIN-Regular" size:8],NSForegroundColorAttributeName:[UIColor y_colorWithHexString:@"111111" alpha:0.5]}];
        }

        CGContextSetStrokeColorWithColor(context, [UIColor y_colorWithHexString:@"000000" alpha:0.1].CGColor);
        CGContextSetLineWidth(context, 0.5);
        CGContextMoveToPoint(context, point.x, point.y);
        CGContextAddLineToPoint(context, self.frame.size.width, point.y);
    }
    
    CGContextStrokePath(context);
    
}

#pragma mark 将model转化为Position模型
- (void)private_convertToDepthPositionModelWithDepthGroupModel:(DepthGroupModel *)depthGroupModel {
    
    [self.amountArray removeAllObjects];
    [self.positionsArray removeAllObjects];
    
    if (depthGroupModel.showMaxDepthAmount.doubleValue == 0 && depthGroupModel.showMinDepthAmount.doubleValue == 0) {
        return;
    }

    CGFloat maxAmount = depthGroupModel.showMaxDepthAmount.doubleValue / AmountScale;
    CGFloat minAmount = depthGroupModel.showMinDepthAmount.doubleValue;
    CGFloat heightScale = self.frame.size.height / (maxAmount - minAmount);

    int verticalCount = 4;
    for (int i = 0; i <= verticalCount; i ++) {
        NSNumber *amoutNumber = [NSNumber numberWithDouble:(maxAmount - (maxAmount - minAmount) / verticalCount * i)];
        NSString *amoutString;
        if (self.depthGroupModel.ask_fixed) {
            amoutString = [NSString y_stringFromValue:[amoutNumber stringValue] formatterStyle:Y_NumberFormatterAutoCompleteDigitStyle digitNumber:self.depthGroupModel.ask_fixed.intValue digitFixedNumber:-1];
        }
        else {
            amoutString = [NSString y_stringFromValue:[amoutNumber stringValue] formatterStyle:Y_NumberFormatterDecimalStyle digitNumber:-1 digitFixedNumber:-1];
        }
        [self.amountArray addObject:amoutString];
        CGPoint verticalPoint = CGPointMake(1, heightScale * ((maxAmount - minAmount) / verticalCount * i));
        if (i == verticalCount) {
            verticalPoint = CGPointMake(self.frame.origin.x, heightScale * ((maxAmount - minAmount) / verticalCount * i) - 0.5);
        }
        [self.positionsArray addObject:[NSValue valueWithCGPoint:verticalPoint]];
    }
}

/**
 重新绘制
 */
- (void)reloaView {
    [self private_convertToDepthPositionModelWithDepthGroupModel:self.depthGroupModel];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setNeedsDisplay];
    });
}

- (void)setDepthGroupModel:(DepthGroupModel *)depthGroupModel {
    _depthGroupModel = depthGroupModel;
    [self reloaView];
}

#pragma mark - Getters & Setters
- (NSMutableArray *)positionsArray
{
    if (!_positionsArray) {
        _positionsArray = [NSMutableArray array];
    }
    return _positionsArray;
}

- (NSMutableArray *)amountArray {
    if (!_amountArray) {
        _amountArray = [NSMutableArray array];
    }
    return _amountArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
