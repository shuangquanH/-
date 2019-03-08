//
//  Y_MALine.h
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_BaseLine.h"
#import "Y_KLineModel.h"

/**
 *  画均线的线
 */
@interface Y_MALine : Y_BaseLine

@property (nonatomic, strong) NSArray *positions;

/**
 *  k线的model
 */
@property (nonatomic, strong) Y_KLineModel *kLineModel;

/**
 *  最大的Y
 */
@property (nonatomic, assign) CGFloat maxY;

/**
 *  最大的X
 */
@property (nonatomic, assign) CGFloat maxX;


/**
 *  根据context初始化均线画笔
 */
- (instancetype)initWithContext:(CGContextRef)context;

- (void)draw;

@property (nonatomic, strong) UIColor *timeLineColor;

@end
