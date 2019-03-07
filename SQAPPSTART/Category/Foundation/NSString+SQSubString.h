//
//  NSString+SQSubString.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SQSubString)

/**根据关键字截取后面的字符串(包含关键字)*/
- (NSString *)subStringWithKeyword:(NSString *)keyWord;

@end
