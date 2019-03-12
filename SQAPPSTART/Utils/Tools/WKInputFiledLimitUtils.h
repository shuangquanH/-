//
//  WKInputFiledLimitUtils.h
//  QingYouProject
//
//  Created by mac on 2018/7/24.
//  Copyright © 2018年 ccyouge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKInputFiledLimitUtils : NSObject
//在textField的输入变化event中调用
+ (BOOL)textField:(UITextField *)textField limitCount:(NSInteger)limitCount filterEmoji:(BOOL)filterEmoji;
//在代理textViewDidChanged调用
+ (BOOL)textView:(UITextView *)textView limitCount:(NSInteger)limitCount filterEmoji:(BOOL)filterEmoji;

//过滤特定字符串
+ (BOOL)textField:(UITextField *)textField limitCount:(NSInteger)limitCount filterEmoji:(BOOL)filterEmoji filterString:(NSString *)filterString;
//过滤特定字符串
+ (BOOL)textView:(UITextView *)textView limitCount:(NSInteger)limitCount filterEmoji:(BOOL)filterEmoji filterString:(NSString *)filterString;


/** 是否存在emoji  */
+ (BOOL)hasEmoji:(NSString *)string;

@end
