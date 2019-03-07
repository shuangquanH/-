//
//  SQGetNowDate.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQGetNowDate.h"

@implementation SQGetNowDate

//获取当前时间时间戳float格式
+ (NSTimeInterval)getNowDateTimestampToInterval {
    NSDate  *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval interval = [date timeIntervalSince1970]*1000;
    return interval;
}
//获取当前时间时间戳string格式
+ (NSString *)getNowDateTimestampToString {
    NSTimeInterval  interval = [self getNowDateTimestampToInterval];
    NSString *timeString = [NSString stringWithFormat:@"%f", interval];
    return timeString;
}

//获取当前时间格式，需要传入时间格式eg:(@"yyyy-MM-dd HH:mm:ss")
+ (NSString *)getNowDateTimeWithFormatter:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

@end
