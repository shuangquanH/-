//
//  ABKLineViewModel.h
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Y_KLineGroupModel.h"
#import "Y_StockChartConstant.h"

NS_ASSUME_NONNULL_BEGIN


@protocol ABKLineViewModelDelegate <NSObject>

/** u需要修改k线图分时y展示样式  */
- (void)needReloadKLineData;
/** 需要修改k线图技术展示样式  */
- (void)needReloadKLineStyle:(Y_StockChartTargetLineStatus)style;
/** 需要修改副图技术展示样式  */
- (void)needReloadDeputyStyle:(Y_StockChartTargetLineStatus)style;

@end


@interface ABKLineViewModel : NSObject

@property (nonatomic, weak)  id <ABKLineViewModelDelegate>  delegate;

- (void)getGroupModelSuccess:(void(^)(Y_KLineGroupModel *groupModel))success;

- (void)switchSegmentButtonWithBtnTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
