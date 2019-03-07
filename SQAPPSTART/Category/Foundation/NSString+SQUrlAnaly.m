//
//  NSString+SQUrlAnaly.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSString+SQUrlAnaly.h"

@implementation NSString (SQUrlAnaly)

-(NSString *)urlAnalyWithItem:(NSString *)item {
    NSError *error;
    NSString *regTags=[[NSString alloc] initWithFormat:@"(^|&|\\?)+%@=+([^&]*)(&|$)",item];
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:regTags
                                  options:NSRegularExpressionCaseInsensitive
                                  error:&error];
    // 执行匹配的过程
    NSArray *matches = [regex matchesInString:self
                                      options:0
                                        range:NSMakeRange(0, [self length])];
    for (NSTextCheckingResult *match in matches) {
        NSString *tagValue = [self substringWithRange:[match rangeAtIndex:2]];  // 分组2所对应的串
        return tagValue;
    }
    return @"";
}

@end
