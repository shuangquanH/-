//
//  NSString+Y_StockChart.h
//  Y_ChartView
//
//  Created by 程守斌 on 2019/1/3.
//



NS_ASSUME_NONNULL_BEGIN

//NSDateFormatterLongStyle
//价格格式
typedef NS_ENUM(int, Y_NumberFormatterStyle) {
    Y_NumberFormatterNoStyle = 0,
    Y_NumberFormatterSellOrderCombineStyle, //卖单合并价格显示风格
    Y_NumberFormatterBuyOrderCombineStyle,      //买单合并价格显示风格
    Y_NumberFormatterAutoCompleteDigitStyle,     //自动补齐小数点位数,小数点3位 0.2 -> 0.200
    Y_NumberFormatterDigitRoundHalfUpStyle, //四舍五入 进1
    Y_NumberFormatterDecimalStyle  //小数风格，保留3位小数
};

@interface NSString (Y_StockChart)

//用对象的方法计算文本的大小
- (CGSize)y_sizeWithFont:(UIFont*)font andMaxSize:(CGSize)size;

/**
 * 转换价格格式
 * digitNumber 小数点显示位数
 * digitFixedNumber 小数点保留位数，只限ABNumberFormatterSellOrderCombineStyle、ABNumberFormatterBuyOrderCombineStyle使用
 **/
+ (NSString *)y_stringFromValue:(NSString *)value
               formatterStyle:(Y_NumberFormatterStyle)style
                  digitNumber:(int)digitNumber
             digitFixedNumber:(int)digitFixedNumber;

@end

NS_ASSUME_NONNULL_END
