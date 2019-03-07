//
//  SQGetNowDate.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQGetNowDate : NSObject

//获取当前时间时间戳float格式
+ (NSTimeInterval)getNowDateTimestampToInterval;

//获取当前时间时间戳string格式
+ (NSString *)getNowDateTimestampToString;

//获取当前时间格式，需要传入时间格式eg:(@"yyyy-MM-dd HH:mm:ss")
+ (NSString *)getNowDateTimeWithFormatter:(NSString *)format;

@end
