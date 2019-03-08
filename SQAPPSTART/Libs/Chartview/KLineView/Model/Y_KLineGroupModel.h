//
//  Y-KLineGroupModel.h
//  BTC-Kline
//
//  Created by yate1996 on 16/4/28.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>
@class Y_KLineModel;

typedef NS_ENUM(NSUInteger, KLineType) {
    KLineTypeTime = 0,
    KLineTypeOneMinute,
    KLineTypeFiveMinute,
    KLineTypeFifteenMinute,
    KLineTypeThirtyMinute,
    KLineTypeOneHour,
    KLineTypeTwoHour,
    KLineTypeFourHour,
    KLineTypeSixHour,
    KLineTypeTwelveHour,
    KLineTypeDay,
    KLineTypeWeek,
};


@interface Y_KLineGroupModel : NSObject

@property (nonatomic, assign) KLineType defaultKLineType;
@property (nonatomic, copy) NSString *ask_fixed;
@property (nonatomic, copy) NSString *bid_fixed;
@property (nonatomic, strong) NSMutableArray<Y_KLineModel *> *models;

//初始化Model
+ (instancetype) objectWithArray:(NSArray *)arr;

/**
 添加K线图最新成交数据

 @param array 成交数据源，array[0]表示date，array[1]表示price

 */
- (void)addKLineDataArray:(NSMutableArray *)array;


@end

