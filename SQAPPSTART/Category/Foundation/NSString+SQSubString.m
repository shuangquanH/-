//
//  NSString+SQSubString.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSString+SQSubString.h"

@implementation NSString (SQSubString)

- (NSString *)subStringWithKeyword:(NSString *)keyWord {
    NSRange range = [self rangeOfString:keyWord]; //现获取要截取的字符串位置
    NSString * result = [self substringFromIndex:range.location]; //截取字符串
    return result;
}


@end
