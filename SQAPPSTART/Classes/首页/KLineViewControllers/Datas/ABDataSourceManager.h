//
//  ABDataSourceManager.h
//  Y_ChartView_Example
//
//  Created by ly on 2019/1/4.
//  Copyright © 2019 iCoobin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Y_KLineGroupModel.h"
#import "DepthGroupModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ABDataSourceManager : NSObject

+ (instancetype)sharedInstance;


/**
 获取本地的k线数据

 @return k线groupModel数据
 */
- (Y_KLineGroupModel *)getKLineDatasLocal;

/**
 获取本地的深度图数据
 
 @return 深度图groupModel数据
 */
- (DepthGroupModel *)getDepthDatasLocal;

@end

NS_ASSUME_NONNULL_END
