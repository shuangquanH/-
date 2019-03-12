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


- (NSString *)phoneCode {
    if (!_phoneCode) {
        NSString *uuid = [[NSUserDefaults standardUserDefaults] valueForKey:@"com.ganglian.uuid"];
        if (!uuid.length) {
            uuid = [NSUUID UUID].UUIDString;
            [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"com.ganglian.uuid"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        _phoneCode = uuid;
    }
    return _phoneCode;
}


@end
