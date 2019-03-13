//
//  Y_ChartView.h
//  Exchange
//
//  Created by mengfanjun on 2018/4/27.
//  Copyright © 2018年 5th. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Y_KLineGroupModel.h"
#import "Y_StockChartConstant.h"
@class Y_KLineModel;

@protocol Y_ChartViewDelegate <NSObject>

- (void)firstTapedPoint:(CGPoint)point;
- (void)longPressWithModel:(Y_KLineModel *)kLineModel;
- (void)cancelLongPress;

@end

@interface Y_ChartView : UIView


@property (nonatomic, assign) id<Y_ChartViewDelegate> delegate;

/**
 *  更新k线样式(全屏)
 */
- (void)updateKLineStyle:(Y_StockChartScreenStyle)style;

/** 更新k线图数据  */
- (void)updateKLineData:(Y_KLineGroupModel *)groupModel;
/** 更新技术图形数据  */
- (void)updateAccessoryData:(Y_KLineModel *)model;


/** 修改k线的技术图形  */
- (void)changeMainChartSegmentType:(Y_StockChartTargetLineStatus )lineType;
/** 修改副图的技术图形  */
- (void)changeDeputyChartSegmentType:(Y_StockChartTargetLineStatus )lineType;

/** 设置止损止盈线  */
- (void)getStopLossPrice:(CGFloat)lossPrice stopProfitPrice:(CGFloat)profitPrice;

@end
