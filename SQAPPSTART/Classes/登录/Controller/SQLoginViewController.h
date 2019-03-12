//
//  SQLoginViewController.h
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/12.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SQBaseViewController.h"
#import "SQLoginModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface SQLoginViewController : SQBaseViewController

@property (nonatomic, assign)   SQLoginViewType        viewType;

@property (nonatomic, copy, nullable) void (^ loginSuccessCallback)(UIViewController *vc);


@end

NS_ASSUME_NONNULL_END
