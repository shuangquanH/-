//
//  Y_TimeLine.h
//  Exchange
//
//  Created by ly on 2018/10/24.
//  Copyright © 2018 5th. All rights reserved.
//

#import "Y_BaseLine.h"
#import "Y_KLineModel.h"
NS_ASSUME_NONNULL_BEGIN

/**
 *  画h分时图的线
 */
@interface Y_TimeLine : Y_BaseLine

@property (nonatomic, strong) NSArray *positions;

@property (nonatomic, strong) NSArray *timeArray;

/**
 *  最大的Y
 */
@property (nonatomic, assign) CGFloat maxY;

/**
 *  最大的X
 */
@property (nonatomic, assign) CGFloat maxX;

/**
 *  时间Y纵坐标坐标的值
 */
@property (nonatomic, assign) CGFloat timeY;

/**
 *  时间Y横坐标间距
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
 *  根据context初始化均线画笔
 */
- (instancetype)initWithContext:(CGContextRef)context;

- (void)draw;

@property (nonatomic, strong) UIColor *timeLineColor;
@property (nonatomic, strong) UIColor *timeFillColor;

@end

NS_ASSUME_NONNULL_END
