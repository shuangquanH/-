//
//  DepthLongPressView.h
//  Exchange
//
//  Created by mengfanjun on 2018/6/5.
//  Copyright © 2018年 5th. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DepthModel;

@interface DepthLongPressView : UIView

/**
 竖线
 */
@property (nonatomic, strong) UIView *verticalView;

/**
 竖线文字
 */
@property (nonatomic, strong) UILabel *verticalLabel;

/**
 横线
 */
@property (nonatomic, strong) UIView *horizontalView;

/**
 横线文字
 */
@property (nonatomic, strong) UILabel *horizontalLabel;

@property (nonatomic, strong) DepthModel *depthModel;

@end
