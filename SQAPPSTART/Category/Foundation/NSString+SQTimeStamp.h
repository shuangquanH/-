//
//  NSString+SQTimeStamp.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SQTimeStamp)

/** 时间戳(string格式)转换成几分钟前，几天前，几个月前，几年前 */
- (NSString *)timestampToTimesAgo;

@end
