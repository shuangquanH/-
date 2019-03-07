//
//  NSString+SQCheckString.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSString+SQCheckString.h"

@implementation NSString (SQCheckString)

- (BOOL)isNullStr {
    if (!self) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if (!self.length) {
        return YES;
    }
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmedStr = [self stringByTrimmingCharactersInSet:set];
    if (!trimmedStr.length) {
        return YES;
    }
    return NO;
}

/**
 *  判断是否是手机号
 *
 *  @return 是否是手机号
 */
- (BOOL)isMobilePhone {
    NSString *regex = @"^1[3|4|5|7|8][0-9]\\d{8}";
    return [self checkWithPredicate:regex];
}

/**
 *  使用正则表达式校验字符串
 *
 *  @return 使用正则表达式，校验是否通过
 */
- (BOOL)checkWithPredicate:(NSString *)preStr {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", preStr];
    
    return [predicate evaluateWithObject:self];
}

@end
