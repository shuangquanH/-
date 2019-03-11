//
//  SQTransformTime.m
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SQTransformTime.h"

@implementation SQTransformTime

+ (NSString *)getDateWithTimeIntervalStr:(NSString *)timeIntervalStr withFormatter:(NSString *)formatter {
    long long time = [timeIntervalStr longLongValue];
    if (time>9999999999) {
        time = time/1000;
    }
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    NSDateFormatter *theFormatter = [[NSDateFormatter alloc]init];
    [theFormatter setDateFormat: formatter];
    NSString *timeString = [theFormatter stringFromDate:date];
    return timeString;
}

@end
