//
//  Y_AccessoryInfoView.h
//  Exchange
//
//  Created by ly on 2018/11/2.
//  Copyright © 2018 5th. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Y_StockChartConstant.h"
@class Y_KLineModel;
NS_ASSUME_NONNULL_BEGIN

@interface Y_AccessoryInfoView : UIView

@property (nonatomic, strong) UILabel *accessoryLabel0;
@property (nonatomic, strong) UILabel *accessoryLabel1;
@property (nonatomic, strong) UILabel *accessoryLabel2;
@property (nonatomic, strong) UILabel *accessoryLabel3;

@property (nonatomic, strong) Y_KLineModel *kLineModel;
@property (nonatomic, assign) Y_StockChartTargetLineStatus lineType;

@end

NS_ASSUME_NONNULL_END
