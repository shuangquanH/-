//
//  UIFont+Y_StockChart.m
//  Y_ChartView
//
//  Created by 程守斌 on 2019/1/3.
//

#import "UIFont+Y_StockChart.h"

@implementation UIFont (Y_StockChart)

+ (UIFont *)y_customFontWithName:(NSString *)fontName size:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:fontName size:fontSize];
    if (!font) {
        font = [UIFont systemFontOfSize:fontSize];
    }
    return font;
}

@end
