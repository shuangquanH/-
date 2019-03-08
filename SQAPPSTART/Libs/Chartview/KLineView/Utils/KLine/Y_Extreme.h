//
//  Y_Extreme.h
//  Exchange
//
//  Created by ly on 2018/11/8.
//  Copyright © 2018 5th. All rights reserved.
//

#import "Y_BaseLine.h"
#import "Y_KLinePositionModel.h"
#import "Y_KLineModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface Y_Extreme : Y_BaseLine

/**
 *  最大的kline坐标
 */
@property (nonatomic, strong) Y_KLinePositionModel *positionMaxModel;

/**
 *  最小的kline坐标
 */
@property (nonatomic, strong) Y_KLinePositionModel *positionMinModel;

/**
 *  最大的klineModel
 */
@property (nonatomic, strong) Y_KLineModel *maxModel;

/**
 *  最小的klineModel
 */
@property (nonatomic, strong) Y_KLineModel *minModel;

@property (nonatomic, assign) CGFloat screenWidth;
/**
 *  根据context初始化
 */
- (instancetype)initWithContext:(CGContextRef)context;

/**
 *  绘制K线
 */
- (void)draw;

@end

NS_ASSUME_NONNULL_END
