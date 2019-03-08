//
//  DepthModel.h
//  Exchange
//
//  Created by mengfanjun on 2018/4/27.
//  Copyright © 2018年 5th. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@class DepthGroupModel;

@interface DepthModel : NSObject

- (instancetype)initWithArray:(NSArray *)array;

/**
 价格，计算时使用
 */
@property (nonatomic, copy) NSString *price;

/**
 价格，显示时使用
 */
@property (nonatomic, copy) NSString *formatPrice;

/**
 价格对应数额，计算时使用
 */
@property (nonatomic, copy) NSString *amount;
/**
 价格对应数额，显示时使用
 */
@property (nonatomic, copy) NSString *formatAmount;

/**
 价格深度图数额
 */
@property (nonatomic, copy) NSString *depthAmount;

/**
 价格深度图数额，显示时使用
 */
@property (nonatomic, copy) NSString *formatDepthAmount;

/**
 *  前一个Model
 */
@property (nonatomic, strong) DepthModel *previousDepthModel;

/**
 *  父ModelArray:用来给当前Model索引到Parent数组
 */
@property (nonatomic, strong) DepthGroupModel *parentGroupModel;

/**
 *  绘图点
 */
@property (nonatomic, assign) CGPoint positionPoint;

@property (nonatomic, copy) NSString *ask_fixed;
@property (nonatomic, copy) NSString *bid_fixed;

@property (nonatomic, assign) BOOL isMyOrderPrice;

@end
