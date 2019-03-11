//
//  SQTransformTime.h
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SQTransformTime : NSObject


/** 根据时间戳(string格式)转换成时间格式，需要传入  */
/** timeIntervalStr:@"1495641600";*/
/** formatter:@"yyyy-MM-dd HH:mm:ss"  */
+ (NSString *)getDateWithTimeIntervalStr:(NSString *)timeIntervalStr withFormatter:(NSString *)formatter;



@end

NS_ASSUME_NONNULL_END
