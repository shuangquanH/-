//
//  NSString+SQCheckString.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SQCheckString)

/** 判断是否为空字符串 */
- (BOOL)isNullStr;

/** 判断是否是手机号 */
- (BOOL)isMobilePhone;



@end
