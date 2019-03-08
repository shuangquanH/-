//
//  DepthChartView.h
//  Exchange
//
//  Created by mengfanjun on 2018/4/27.
//  Copyright © 2018年 5th. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DepthGroupModel;

//最高depthAmount占纵坐标比例
#define AmountScale 0.8

//最高price占横坐标比例
#define PriceScale 1

@interface DepthChartView : UIView

@property (nonatomic, strong) DepthGroupModel *depthGroupModel;

@end
