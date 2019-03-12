//
//  Y_YAxisView.m
//  Exchange
//
//  Created by mengfanjun on 2018/5/29.
//  Copyright © 2018年 5th. All rights reserved.
//

#import "Y_YAxisView.h"
#import "UIColor+Y_StockChart.h"
#import "UIFont+Y_StockChart.h"
#import "NSString+Y_StockChart.h"

@interface Y_YAxisView ()

@property (nonatomic, strong) NSMutableArray *priceArray;
@property (nonatomic, strong) NSMutableArray *positionsArray;

@end

@implementation Y_YAxisView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    for (NSInteger i = 0; i < self.positionsArray.count ; i++) {
        CGPoint point = [self.positionsArray[i] CGPointValue];
        NSString *amountStr = self.priceArray[i];
        
        UIFont  *tfont = [UIFont y_customFontWithName:@"DIN-Regular" size:8];
        CGFloat stwidth = [self getStringWidthWithString:amountStr font:tfont];
        
        
        /** 画价格  */
        if (i == self.positionsArray.count - 1) {
            [amountStr drawAtPoint:CGPointMake(rect.size.width-stwidth-10, point.y - 12) withAttributes:@{NSFontAttributeName:tfont,NSForegroundColorAttributeName:[UIColor y_colorWithHexString:@"111111" alpha:0.5]}];
        } else {
            [amountStr drawAtPoint:CGPointMake(rect.size.width-stwidth-10, point.y) withAttributes:@{NSFontAttributeName:tfont,NSForegroundColorAttributeName:[UIColor y_colorWithHexString:@"111111" alpha:0.5]}];
        }
        
        /** 画线  */
        CGContextSetStrokeColorWithColor(context, [UIColor y_colorWithHexString:@"000000" alpha:0.1].CGColor);
        CGContextSetLineWidth(context, 0.5);
        CGContextMoveToPoint(context, point.x, point.y);
        CGContextAddLineToPoint(context, self.frame.size.width, point.y);
    }

    CGContextStrokePath(context);
}

/**
 重新绘制
 */
- (void)reloaView {
    [self setNeedsDisplay];
}

- (void)setLineCount:(NSInteger)verticalCount maxPrice:(CGFloat )maxPrice minPrice:(CGFloat )minPrice {
    CGFloat heightScale = maxPrice - minPrice == 0?0:self.frame.size.height / (maxPrice - minPrice);
    [self.priceArray removeAllObjects];
    [self.positionsArray removeAllObjects];
    if ((maxPrice == 0 && minPrice == 0)) {
        [self reloaView];
        return;
    }
    if (heightScale == 0) {
        NSNumber *priceNumber = [NSNumber numberWithDouble:(maxPrice - (maxPrice - minPrice) / verticalCount * 3)];
        NSString *priceStr;
        if (self.bid_fixed) {
            priceStr = [NSString y_stringFromValue:[priceNumber stringValue] formatterStyle:Y_NumberFormatterAutoCompleteDigitStyle digitNumber:self.bid_fixed.intValue digitFixedNumber:-1];//
        }
        else {
            priceStr = [NSString y_stringFromValue:[priceNumber stringValue] formatterStyle:Y_NumberFormatterDecimalStyle digitNumber:-1 digitFixedNumber:-1];;
        }
        [self.priceArray addObject:priceStr];
        CGPoint verticalPoint = CGPointMake(self.frame.origin.x, self.frame.size.height - 0.5);
        [self.positionsArray addObject:[NSValue valueWithCGPoint:verticalPoint]];
        [self reloaView];
        return;
    }
    for (int i = 0; i <= verticalCount; i++) {
        NSNumber *priceNumber = [NSNumber numberWithDouble:(maxPrice - (maxPrice - minPrice) / verticalCount * i)];
        NSString *priceStr;
        if (self.bid_fixed) {
            priceStr = [NSString y_stringFromValue:[priceNumber stringValue] formatterStyle:Y_NumberFormatterAutoCompleteDigitStyle digitNumber:self.bid_fixed.intValue digitFixedNumber:-1];
        }
        else {
            priceStr = [NSString y_stringFromValue:[priceNumber stringValue] formatterStyle:Y_NumberFormatterDecimalStyle digitNumber:-1 digitFixedNumber:-1];
        }
        [self.priceArray addObject:priceStr];
        CGPoint verticalPoint = CGPointMake(self.frame.origin.x, heightScale * ((maxPrice - minPrice) / verticalCount * i));
        if (i == verticalCount) {
            verticalPoint = CGPointMake(self.frame.origin.x, heightScale * ((maxPrice - minPrice) / verticalCount * i) - 0.5);
        }
        [self.positionsArray addObject:[NSValue valueWithCGPoint:verticalPoint]];
    }
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



- (CGFloat)getStringWidthWithString:(NSString *)string font:(UIFont *)font {
    CGSize infoSize = CGSizeMake(CGFLOAT_MAX, 10);
    NSDictionary *dic = @{NSFontAttributeName : font};
    CGRect infoRect =   [string boundingRectWithSize:infoSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil];
    return infoRect.size.width;
}




@end
