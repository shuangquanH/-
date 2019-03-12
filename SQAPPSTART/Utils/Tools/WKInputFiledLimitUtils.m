//
//  WKInputFiledLimitUtils.m
//  QingYouProject
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 ccyouge. All rights reserved.
//

#import "WKInputFiledLimitUtils.h"
//#import "NSString+SQJudge.h"

@implementation WKInputFiledLimitUtils

#pragma mark - For TextFiled
+ (BOOL)textField:(UITextField *)textField limitCount:(NSInteger)limitCount filterEmoji:(BOOL)filterEmoji {
    return [self disableEmoji:filterEmoji andFilterText:nil limitCount:limitCount forTextFiled:textField];
}

+ (BOOL)textField:(UITextField *)textField limitCount:(NSInteger)limitCount filterEmoji:(BOOL)filterEmoji filterString:(NSString *)filterString {
    return [self disableEmoji:filterEmoji andFilterText:filterString limitCount:limitCount forTextFiled:textField];
}

+ (BOOL)disableEmoji:(BOOL)disableEmoji andFilterText:(NSString *)filterText limitCount:(NSInteger)limitCount forTextFiled:(UITextField *)textFiled {
    
    UITextRange *selectedRange = [textFiled markedTextRange];
    UITextPosition *position = [textFiled positionFromPosition:selectedRange.start offset:0];
    if (position) {//还在拼音阶段，不处理
        return YES;
    }
    
    NSString *textFiledText = textFiled.text;
    __block NSMutableString *resultString = @"".mutableCopy;
    __block NSInteger startIndex = [textFiled offsetFromPosition:textFiled.beginningOfDocument toPosition:textFiled.selectedTextRange.start];
    
    [textFiledText enumerateSubstringsInRange:NSMakeRange(0, [textFiledText length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         BOOL isEmoji = [self hasEmoji:substring];
         if (disableEmoji && isEmoji) {
             if (substringRange.location + substringRange.length <= startIndex) {
                 startIndex -= substringRange.length;
             }
         } else if (filterText.length > 0 && [substring isEqualToString:filterText]) {
             if (substringRange.location + substringRange.length <= startIndex) {
                 startIndex -= substringRange.length;
             }
         } else {
             [resultString appendString:substring];
         }
     }];
    
    //获得过滤后的字符串
    BOOL outBounds = NO;
    if (limitCount > 0) {
        outBounds = resultString.length > limitCount;
        if (outBounds) {
            resultString = [resultString substringToIndex:limitCount].mutableCopy;
            if (startIndex > resultString.length) {
                startIndex = resultString.length;
            }
        }
    }
    textFiled.text = [resultString copy];
    UITextPosition *startPosition = [textFiled positionFromPosition:textFiled.beginningOfDocument offset:startIndex];
    textFiled.selectedTextRange = [textFiled textRangeFromPosition:startPosition toPosition:startPosition];
    return !outBounds;
}

#pragma mark - For TextView
+ (BOOL)textView:(UITextView *)textView limitCount:(NSInteger)limitCount filterEmoji:(BOOL)filterEmoji {
    return [self disableEmoji:filterEmoji andFilterText:nil limitCount:limitCount forTextView:textView];
}

+ (BOOL)textView:(UITextView *)textView limitCount:(NSInteger)limitCount filterEmoji:(BOOL)filterEmoji filterString:(NSString *)filterString {
    return [self disableEmoji:filterEmoji andFilterText:filterString limitCount:limitCount forTextView:textView];
}

+ (BOOL)disableEmoji:(BOOL)disableEmoji andFilterText:(NSString *)filterText limitCount:(NSInteger)limitCount forTextView:(UITextView *)textView {
    
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    if (position) {
        return YES;
    }
    
    NSString *textViewText = textView.text;
    __block NSMutableString *resultString = @"".mutableCopy;
    __block NSInteger startIndex = [textView offsetFromPosition:textView.beginningOfDocument toPosition:textView.selectedTextRange.start];
    
    [textViewText enumerateSubstringsInRange:NSMakeRange(0, [textViewText length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         BOOL isEmoji = [self hasEmoji:substring];
         if (disableEmoji && isEmoji) {
             if (substringRange.location + substringRange.length <= startIndex) {
                 startIndex -= substringRange.length;
             }
         } else if (filterText.length > 0 && [substring isEqualToString:filterText]) {
             if (substringRange.location + substringRange.length <= startIndex) {
                 startIndex -= substringRange.length;
             }
         } else {
             [resultString appendString:substring];
         }
     }];
    //获得过滤后的字符串
    BOOL outBounds = NO;
    if (limitCount > 0) {
        outBounds = resultString.length > limitCount;
        if (outBounds) {
            resultString = [resultString substringToIndex:limitCount].mutableCopy;
            if (startIndex > resultString.length) {
                startIndex = resultString.length;
            }
        }
    }
    
    textView.text = [resultString copy];
    UITextPosition *startPosition = [textView positionFromPosition:textView.beginningOfDocument offset:startIndex];
    textView.selectedTextRange = [textView textRangeFromPosition:startPosition toPosition:startPosition];
    return !outBounds;
}


+ (BOOL)hasEmoji:(NSString *)string {
    NSString *pattern = @"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:string];
    return isMatch;
}

@end
