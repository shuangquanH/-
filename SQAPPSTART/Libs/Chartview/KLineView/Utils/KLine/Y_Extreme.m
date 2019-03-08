//
//  Y_Extreme.m
//  Exchange
//
//  Created by ly on 2018/11/8.
//  Copyright © 2018 5th. All rights reserved.
//

#import "Y_Extreme.h"

#import "UIColor+Y_StockChart.h"
#import "Y_StockChartConstant.h"
#import "UIFont+Y_StockChart.h"
#import "NSString+Y_StockChart.h"

@interface Y_Extreme ()

@property (nonatomic, assign) CGContextRef context;

@end

@implementation Y_Extreme

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
    
    if(!self.maxModel || !self.positionMaxModel) {
        return;
    }
    
    [self drawMaxText];
    
    if(!self.minModel || !self.positionMinModel) {
        return;
    }
    
    [self drawMinText];
    
}

- (void)drawMaxText {
    NSString *maxStr;
    CGPoint drawDatePoint;
    UIFont *font = [UIFont y_customFontWithName:@"DIN-Regular" size:8];
    if (self.positionMaxModel.HighPoint.x < self.screenWidth / 2) {
        maxStr = [NSString stringWithFormat:@"←%@",[NSString y_stringFromValue:[self.maxModel.High stringValue] formatterStyle:Y_NumberFormatterDecimalStyle digitNumber:-1 digitFixedNumber:-1]];
        CGSize textSize = [maxStr y_sizeWithFont:font andMaxSize:CGSizeZero];
        drawDatePoint = CGPointMake(self.positionMaxModel.HighPoint.x, self.positionMaxModel.HighPoint.y - textSize.height);
    } else {
        maxStr = [NSString stringWithFormat:@"%@→",[NSString y_stringFromValue:[self.maxModel.High stringValue] formatterStyle:Y_NumberFormatterDecimalStyle digitNumber:-1 digitFixedNumber:-1]];
        CGSize textSize = [maxStr y_sizeWithFont:font andMaxSize:CGSizeZero];
        drawDatePoint = CGPointMake(self.positionMaxModel.HighPoint.x - textSize.width, self.positionMaxModel.HighPoint.y - textSize.height);
    }
    if (!maxStr) {
        return;
    }
    
    NSMutableParagraphStyle * paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    [maxStr drawAtPoint:drawDatePoint withAttributes:@{NSFontAttributeName : font,NSForegroundColorAttributeName : [UIColor y_colorWithHexString:@"111111"],NSParagraphStyleAttributeName : paragraphStyle}];
}

- (void)drawMinText {
    NSString *minStr;
    CGPoint drawDatePoint;
    UIFont *font = [UIFont y_customFontWithName:@"DIN-Regular" size:8];
    if (self.positionMinModel.LowPoint.x < self.screenWidth / 2) {
        minStr = [NSString stringWithFormat:@"←%@",[NSString y_stringFromValue:[self.minModel.Low stringValue] formatterStyle:Y_NumberFormatterDecimalStyle digitNumber:-1 digitFixedNumber:-1]];
        drawDatePoint = CGPointMake(self.positionMinModel.LowPoint.x, self.positionMinModel.LowPoint.y);
    } else {
        minStr = [NSString stringWithFormat:@"%@→",[NSString y_stringFromValue:[self.minModel.Low stringValue] formatterStyle:Y_NumberFormatterDecimalStyle digitNumber:-1 digitFixedNumber:-1]];
        CGSize textSize = [minStr y_sizeWithFont:font andMaxSize:CGSizeZero];
        drawDatePoint = CGPointMake(self.positionMinModel.LowPoint.x - textSize.width, self.positionMinModel.LowPoint.y);
    }
    if (!minStr) {
        return;
    }
    
    NSMutableParagraphStyle * paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    
    [minStr drawAtPoint:drawDatePoint withAttributes:@{NSFontAttributeName : font,NSForegroundColorAttributeName : [UIColor y_colorWithHexString:@"111111"],NSParagraphStyleAttributeName : paragraphStyle}];
}

@end
