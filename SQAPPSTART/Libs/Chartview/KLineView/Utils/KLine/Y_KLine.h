//
//  Y_KLine.h
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_BaseLine.h"
#import "Y_KLinePositionModel.h"
#import "Y_KLineModel.h"
/**
 *  K线的线
 */
@interface Y_KLine : Y_BaseLine

/**
 *  K线的位置model
 */
@property (nonatomic, strong) Y_KLinePositionModel *kLinePositionModel;

/**
 *  k线的model
 */
@property (nonatomic, strong) Y_KLineModel *kLineModel;

/**
 *  最大的Y
 */
@property (nonatomic, assign) CGFloat maxY;

/**
 *  时间Y纵坐标坐标的值
 */
@property (nonatomic, assign) CGFloat timeY;

/**
 *  父视图宽度
 */
@property (nonatomic, assign) CGFloat parentWidth;

/**
 *  需要绘制的总数
 */
@property (nonatomic, assign) NSInteger maxCount;

/**
 *  当前画的KLine的index
 */
@property (nonatomic, assign) NSInteger index;

/**
 *  画笔颜色
 */
@property (nonatomic, strong) UIColor *strokeColor;
/**
 *  根据context初始化
 */
- (instancetype)initWithContext:(CGContextRef)context;

/**
 *  绘制K线
 */
- (void)draw;


@end
