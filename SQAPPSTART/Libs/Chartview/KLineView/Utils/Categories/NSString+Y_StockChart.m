//
//  NSString+Y_StockChart.m
//  Y_ChartView
//
//  Created by 程守斌 on 2019/1/3.
//

#import "NSString+Y_StockChart.h"
//#import <YYKit/NSNumber+YYAdd.h>
#import "NSNumber+Y_ChartView.h"

@implementation NSString (Y_StockChart)

//用对象的方法计算文本的大小
- (CGSize)y_sizeWithFont:(UIFont*)font andMaxSize:(CGSize)size {
    //特殊的格式要求都写在属性字典中
    NSDictionary*attrs =@{NSFontAttributeName: font};
    //返回一个矩形，大小等于文本绘制完占据的宽和高。
    return  [self  boundingRectWithSize:size  options:NSStringDrawingUsesLineFragmentOrigin  attributes:attrs   context:nil].size;
}

+ (NSString *)y_stringFromValue:(NSString *)value
               formatterStyle:(Y_NumberFormatterStyle)style
                  digitNumber:(int)digitNumber
             digitFixedNumber:(int)digitFixedNumber{
    NSString *resultString = nil;
    
    switch (style) {
            case Y_NumberFormatterDecimalStyle:{
                resultString = [self y_priceFomatter:value];
                break;
            }
            case Y_NumberFormatterBuyOrderCombineStyle:{
                resultString = [self y_buyOrderCombine:value
                                         digitNumber:digitNumber
                                    digitFixedNumber:digitFixedNumber];
                break;
            }
            case Y_NumberFormatterSellOrderCombineStyle:{
                resultString = [self y_sellOrderCombine:value
                                          digitNumber:digitNumber
                                     digitFixedNumber:digitFixedNumber];
                break;
            }
            case Y_NumberFormatterAutoCompleteDigitStyle:{
                resultString = [self y_autoCompleteDigitNumber:digitNumber value:value];
                break;
            }
            case Y_NumberFormatterDigitRoundHalfUpStyle:{
                resultString = [self y_digitRoundingHalf:digitNumber value:value];
                break;
            }
        default:
            break;
    }
    
    return resultString;
}

+ (NSString *)y_buyOrderCombine:(NSString *)value
                  digitNumber:(int)digitNumber
             digitFixedNumber:(int)digitFixedNumber {
    //小数部分显示多少位 digitNumber //保留几位小数 digitFixedNumber
    NSNumberFormatter *roundUpFormatter = [[NSNumberFormatter alloc] init];
    roundUpFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    roundUpFormatter.groupingSize = NSUIntegerMax;
    roundUpFormatter.roundingMode = NSNumberFormatterRoundDown;//TODO://
    roundUpFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    roundUpFormatter.minimumFractionDigits = digitFixedNumber;
    roundUpFormatter.maximumFractionDigits = digitFixedNumber;
    
    NSString *resultString = [roundUpFormatter stringFromNumber:[NSNumber y_numberWithString:value]];
    
    roundUpFormatter.minimumFractionDigits = digitNumber;
    roundUpFormatter.maximumFractionDigits = digitNumber;
    
    resultString = [roundUpFormatter stringFromNumber:[NSNumber y_numberWithString:resultString]];
    
    return resultString;
}

+ (NSString *)y_sellOrderCombine:(NSString *)value
                   digitNumber:(int)digitNumber
              digitFixedNumber:(int)digitFixedNumber {
    //digitNumber; //小数部分多少位 //digitFixedNumber; //保留几位小数
    NSNumberFormatter *roundUpFormatter = [[NSNumberFormatter alloc] init];
    roundUpFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    roundUpFormatter.roundingMode = kCFNumberFormatterRoundUp;
    roundUpFormatter.groupingSize = NSUIntegerMax;
    roundUpFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    roundUpFormatter.minimumFractionDigits = digitFixedNumber;
    roundUpFormatter.maximumFractionDigits = digitFixedNumber;
    
    NSString *resultString = [roundUpFormatter stringFromNumber:[NSNumber y_numberWithString:value]];
    
    roundUpFormatter.minimumFractionDigits = digitNumber;
    roundUpFormatter.maximumFractionDigits = digitNumber;
    resultString = [roundUpFormatter stringFromNumber:[NSNumber y_numberWithString:resultString]];
    
    return resultString;
}


+ (NSString *)y_autoCompleteDigitNumber:(int)digitNumber value:(NSString *)value{
    @try{
        NSDecimalNumber *decimalNumber = [NSDecimalNumber decimalNumberWithString:value];
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.roundingMode = NSNumberFormatterRoundDown;
        numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
        numberFormatter.groupingSize = NSUIntegerMax;
        numberFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        numberFormatter.minimumFractionDigits = digitNumber;
        numberFormatter.maximumFractionDigits = digitNumber;
        
        NSString *resultString = [numberFormatter stringFromNumber:decimalNumber];
        
        return resultString;
    }@catch(NSException *exception){
        return nil;
    }
}

+ (NSString *)y_digitRoundingHalf:(int)digitNumber value:(NSString *)value {
    NSNumberFormatter *roundHalfUpFormatter = [[NSNumberFormatter alloc] init];
    roundHalfUpFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    roundHalfUpFormatter.roundingMode = NSNumberFormatterRoundHalfUp;
    roundHalfUpFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    roundHalfUpFormatter.minimumFractionDigits = digitNumber;
    roundHalfUpFormatter.maximumFractionDigits = digitNumber;
    
    return [roundHalfUpFormatter stringFromNumber:[NSNumber y_numberWithString:value]];
}

+ (NSString *)y_priceFomatter:(NSString *)price {//1,000.0
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = kCFNumberFormatterDecimalStyle;
    numberFormatter.maximumFractionDigits = INT_MAX;
    numberFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    
    return [numberFormatter stringFromNumber:[NSDecimalNumber decimalNumberWithString:price]];
}

@end
