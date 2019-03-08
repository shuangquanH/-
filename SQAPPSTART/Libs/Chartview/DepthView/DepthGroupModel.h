//
//  DepthGroupModel.h
//  Exchange
//
//  Created by mengfanjun on 2018/4/27.
//  Copyright © 2018年 5th. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DepthGroupModel : NSObject

@property (nonatomic, strong) NSMutableArray *bidsArray;
@property (nonatomic, strong) NSMutableArray *asksArray;

@property (nonatomic, strong) NSNumber *maxPrice;
@property (nonatomic, strong) NSNumber *minPrice;
@property (nonatomic, strong) NSNumber *maxDepthAmount;
@property (nonatomic, strong) NSNumber *minDepthAmount;

@property (nonatomic, strong) NSNumber *maxSellAmount;
@property (nonatomic, strong) NSNumber *maxBuyAmount;

/**
 根据当前价需要显示的买单
 */
@property (nonatomic, strong) NSMutableArray *showBidsArray;

/**
 根据当前价需要显示的卖单
 */
@property (nonatomic, strong) NSMutableArray *showAsksArray;

/**
 最高价
 */
@property (nonatomic, strong) NSNumber *currentPrice;

/**
 根据当前价需要显示的最高价
 */
@property (nonatomic, strong) NSNumber *showMaxPrice;

/**
 根据当前价需要显示的最低价
 */
@property (nonatomic, strong) NSNumber *showMinPrice;

/**
 根据当前价需要显示的深度图最大额度
 */
@property (nonatomic, strong) NSNumber *showMaxDepthAmount;

/**
 根据当前价需要显示的深度图最小额度
 */
@property (nonatomic, strong) NSNumber *showMinDepthAmount;

@property (nonatomic, copy) NSString *ask_fixed; //币数量精度
@property (nonatomic, copy) NSString *bid_fixed; //币价格精度

- (instancetype)initWithBidsArray:(NSArray *)bidsArray asksArray:(NSArray *)asksArray;

@end
