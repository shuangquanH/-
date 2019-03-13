//
//  SQLoginModel.m
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SQLoginModel.h"

@implementation SQLoginModel


+ (SQLoginModel *)shareModel {
    static SQLoginModel *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^
                  {
                      sharedAccountManagerInstance = [[self alloc] init];
                  });
    return sharedAccountManagerInstance;
}


@end
