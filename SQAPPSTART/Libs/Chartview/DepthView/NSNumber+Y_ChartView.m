//
//  NSNumber+Y_ChartView.m
//  Y_ChartView
//
//  Created by 程守斌 on 2019/1/7.
//

#import "NSNumber+Y_ChartView.h"

@implementation NSNumber (Y_ChartView)

//NSString 转NSNumber
+ (NSNumber *)y_numberWithString:(NSString *)string{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    numberFormatter.groupingSize = UINT_MAX;
    numberFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    return [numberFormatter numberFromString:string];
}

@end
