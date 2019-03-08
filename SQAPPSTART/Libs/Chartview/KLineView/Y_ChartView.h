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

- (void)longPressWithModel:(Y_KLineModel *)kLineModel;
- (void)cancelLongPress;

@end

@interface Y_ChartView : UIView


@property (nonatomic, assign) id<Y_ChartViewDelegate> delegate;

/**
 *  更新k线样式
 */
- (void)updateKLineStyle:(Y_StockChartScreenStyle)style;

- (void)updateKLineData:(Y_KLineGroupModel *)groupModel;
- (void)changeMainChartSegmentType:(Y_StockChartTargetLineStatus )lineType;
- (void)changeDeputyChartSegmentType:(Y_StockChartTargetLineStatus )lineType;
- (void)updateAccessoryData:(Y_KLineModel *)model;

@end
