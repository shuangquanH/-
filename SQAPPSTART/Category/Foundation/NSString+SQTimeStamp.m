//
//  NSString+SQTimeStamp.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "NSString+SQTimeStamp.h"

@implementation NSString (SQTimeStamp)


- (NSString *)timestampToTimesAgo {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    //时间戳string格式转换成NSTimeInterval格式
    NSTimeInterval createTime = [self longLongValue]/1000;
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    if (time<60) {
        return  [NSString stringWithFormat:@"刚刚"];
    }
    NSInteger sec = time/60;
    if (sec<60) {
        return  [NSString stringWithFormat:@"%ld分钟前",sec];
    }
    // 秒转小时
    NSInteger hours = time/3600;
    if (hours<24) {
        return  [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = time/3600/24;
    if (days < 30) {
        return  [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = time/3600/24/30;
    if (months < 12) {
        return  [NSString stringWithFormat:@"%ld月前",months];
    }
    //秒转年
    NSInteger years = time/3600/24/30/12;
    return      [NSString stringWithFormat:@"%ld年前",years];
}

@end
