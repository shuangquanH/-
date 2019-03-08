//
//  Y_BrokenLine.h
//  Exchange
//
//  Created by ly on 2018/11/15.
//  Copyright © 2018 5th. All rights reserved.
//

#import "Y_BaseLine.h"

NS_ASSUME_NONNULL_BEGIN

@interface Y_BrokenLine : Y_BaseLine

/**
 *  起点位置model
 */
@property (nonatomic, assign) CGPoint startPoint;

/**
 *  终点位置model
 */
@property (nonatomic, assign) CGPoint endPoint;

@property (nonatomic, strong) UIColor *timeLineColor;

@property (nonatomic, assign) CGFloat lineWidth;

@property (nonatomic, assign) CGFloat dash;

@property (nonatomic, assign) CGFloat gap;
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
