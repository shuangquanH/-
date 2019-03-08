//
//  DepthPriceView.m
//  Exchange
//
//  Created by mengfanjun on 2018/5/12.
//  Copyright © 2018年 5th. All rights reserved.
//

#import "DepthPriceView.h"
#import "DepthGroupModel.h"
#import "DepthModel.h"
#import "DepthChartView.h"
#import "UIFont+Y_StockChart.h"
#import "UIColor+Y_StockChart.h"
#import "NSString+Y_StockChart.h"

@interface DepthPriceView ()

@property (nonatomic, strong) NSMutableArray *priceArray;
@property (nonatomic, strong) NSMutableArray *positionsArray;

@end

@implementation DepthPriceView

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    
    if (!self.depthGroupModel) {
        return;
    }
    
    for (NSInteger i = 0; i < self.positionsArray.count ; i++) {
        CGPoint point = [self.positionsArray[i] CGPointValue];
        NSString *amountStr = self.priceArray[i];
        [amountStr drawAtPoint:CGPointMake(point.x, point.y) withAttributes:@{NSFontAttributeName:[UIFont y_customFontWithName:@"Europa-Regular" size:8],NSForegroundColorAttributeName:[UIColor y_colorWithHexString:@"111111" alpha:0.5]}];
    }
    
    CGContextStrokePath(context);
    
}

#pragma mark 将model转化为Position模型
- (void)private_convertToDepthPositionModelWithDepthGroupModel:(DepthGroupModel *)depthGroupModel {
    
    [self.priceArray removeAllObjects];
    [self.positionsArray removeAllObjects];
    
    [self.priceArray removeAllObjects];
    [self.positionsArray removeAllObjects];
    
    if (depthGroupModel.showMaxPrice.doubleValue == 0 && depthGroupModel.showMinPrice.doubleValue == 0) {
        return;
    }
    
    CGFloat maxPrice = depthGroupModel.showMaxPrice.doubleValue;
    CGFloat minPrice = depthGroupModel.showMinPrice.doubleValue;

    CGFloat width = self.frame.size.width * PriceScale;
    CGFloat widthScale = width / (maxPrice - minPrice);

    int verticalCount = 4;
    for (int i = 0; i <= verticalCount; i ++) {
        NSNumber *priceNumber = [NSNumber numberWithDouble:(minPrice + (maxPrice - minPrice) / verticalCount * i)];
        NSString *priceStr;
        if (self.depthGroupModel.bid_fixed) {
            priceStr = [NSString y_stringFromValue:[priceNumber stringValue] formatterStyle:Y_NumberFormatterAutoCompleteDigitStyle digitNumber:self.depthGroupModel.bid_fixed.intValue digitFixedNumber:-1];
        }
        else {
            priceStr = [NSString y_stringFromValue:[priceNumber stringValue] formatterStyle:Y_NumberFormatterDecimalStyle digitNumber:-1 digitFixedNumber:-1];
        }
        [self.priceArray addObject:priceStr];
        if (i == verticalCount) {
            CGSize priceSize = [priceStr sizeWithAttributes:@{NSFontAttributeName:[UIFont y_customFontWithName:@"DIN-Regular" size:8]}];
            CGPoint positionPoint = CGPointMake((priceNumber.floatValue - minPrice) * widthScale - 1 - priceSize.width, 3);
            [self.positionsArray addObject:[NSValue valueWithCGPoint:positionPoint]];
        }
        else if (i == 0) {
            CGPoint positionPoint = CGPointMake((priceNumber.floatValue - minPrice) * widthScale + 1, 3);
            [self.positionsArray addObject:[NSValue valueWithCGPoint:positionPoint]];
        }
        else {
            CGSize priceSize = [priceStr sizeWithAttributes:@{NSFontAttributeName:[UIFont y_customFontWithName:@"DIN-Regular" size:8]}];
            CGPoint positionPoint = CGPointMake((priceNumber.floatValue - minPrice) * widthScale - priceSize.width / 2, 3);
            [self.positionsArray addObject:[NSValue valueWithCGPoint:positionPoint]];
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

- (void)setDepthGroupModel:(DepthGroupModel *)depthGroupModel
{
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

- (NSMutableArray *)priceArray {
    if (!_priceArray) {
        _priceArray = [NSMutableArray array];
    }
    return _priceArray;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
