//
//  Y-KLineGroupModel.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/28.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineGroupModel.h"
#import "Y_KLineModel.h"

@implementation Y_KLineGroupModel

+ (instancetype) objectWithArray:(NSArray *)arr {
    
    NSAssert([arr isKindOfClass:[NSArray class]], @"arr不是一个数组");
    
    Y_KLineGroupModel *groupModel = [Y_KLineGroupModel new];
    NSMutableArray *mutableArr = @[].mutableCopy;
    __block Y_KLineModel *preModel = [[Y_KLineModel alloc]init];

    //设置数据
    for (NSObject *contentObject in arr)
    {
        Y_KLineModel *model = [Y_KLineModel new];
        model.PreviousKlineModel = preModel;
        if ([contentObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *contentDic = (NSDictionary *)contentObject;
            [model initWithDict:contentDic];
        }
        else if ([contentObject isKindOfClass:[NSArray class]]) {
            NSArray *contentArray = (NSArray *)contentObject;
            [model initWithArray:contentArray];
        }
        
        model.ParentGroupModel = groupModel;
        [mutableArr addObject:model];
        preModel = model;
    }
    
    groupModel.models = mutableArr;
    
    NSInteger defaultKLineType = [[NSUserDefaults standardUserDefaults] integerForKey:@"DefaultKLineType"];
    groupModel.defaultKLineType = defaultKLineType;

    return groupModel;
}

- (void)addKLineDataArray:(NSMutableArray *)array {
    Y_KLineModel *lastKLineModel = [self.models lastObject];
    
    NSString *lastTimerString = array[0];
    NSString *priceString = array[1];
    NSString *volumeString = array[2];

    if (lastKLineModel) {
        NSInteger beginTimer = lastKLineModel.Date.integerValue;
        NSInteger lastTimer = lastTimerString.integerValue;
        NSInteger apartTimer = lastTimer - beginTimer;
        NSInteger kLineTimer = [self getKLineTimer];;
        if (apartTimer < 0) {
            return;
        }
        if (apartTimer > kLineTimer) {
            NSInteger apartInteger = apartTimer / kLineTimer;//查看时间差有几个时间段
            if (apartInteger > 1) {
                for (int i = 1 ; i < apartInteger - 1; i++) {
                    NSMutableArray *kLineDataArray = [NSMutableArray array];
                    [kLineDataArray addObject:[NSString stringWithFormat:@"%ld",(long)(beginTimer + kLineTimer * i)]];
                    [kLineDataArray addObject:[NSString stringWithFormat:@"%@",lastKLineModel.Close]];
                    [kLineDataArray addObject:[NSString stringWithFormat:@"%@",lastKLineModel.Close]];
                    [kLineDataArray addObject:[NSString stringWithFormat:@"%@",lastKLineModel.Close]];
                    [kLineDataArray addObject:[NSString stringWithFormat:@"%@",lastKLineModel.Close]];
                    [kLineDataArray addObject:@"0"];
                    
                    Y_KLineModel *kLineModel = [Y_KLineModel new];
                    kLineModel.PreviousKlineModel = lastKLineModel;
                    [kLineModel initWithArray:kLineDataArray];
                    kLineModel.ParentGroupModel = self;
                    [self.models addObject:kLineModel];
                    lastKLineModel = kLineModel;
                }
            }
            
            NSMutableArray *kLineDataArray = [NSMutableArray array];
            [kLineDataArray addObject:[NSString stringWithFormat:@"%ld",(long)(beginTimer + kLineTimer * apartInteger)]];
            //当时间节点属于下一个时间节点，并且不是新时间开始点，那么开盘价就是上一个时间节点的收盘价
            [kLineDataArray addObject:[NSString stringWithFormat:@"%@",lastKLineModel.Close]];
            if (lastKLineModel.Close.floatValue > priceString.floatValue) {
                //当上一个时间节点收盘价大于新的价格时，high应该为上一个时间节点收盘价
                [kLineDataArray addObject:[NSString stringWithFormat:@"%@",lastKLineModel.Close]];
            }
            else {
                //当上一个时间节点收盘价小于新的价格时，high应该为最新交易价
                [kLineDataArray addObject:priceString];
            }
            if (lastKLineModel.Close.floatValue < priceString.floatValue) {
                //当上一个时间节点收盘价小于新的价格时，low应该为上一个时间节点收盘价
                [kLineDataArray addObject:[NSString stringWithFormat:@"%@",lastKLineModel.Close]];
            }
            else {
                //当上一个时间节点收盘价大于新的价格时，low应该为最新交易价
                [kLineDataArray addObject:priceString];
            }
            [kLineDataArray addObject:priceString];
            [kLineDataArray addObject:volumeString];

            Y_KLineModel *kLineModel = [Y_KLineModel new];
            kLineModel.PreviousKlineModel = lastKLineModel;
            [kLineModel initWithArray:kLineDataArray];
            kLineModel.ParentGroupModel = self;
            [self.models addObject:kLineModel];
            
        }
        else {
            
            if (lastKLineModel.High.doubleValue < priceString.doubleValue) {
                lastKLineModel.High = [NSNumber numberWithDouble:priceString.doubleValue];
            }
            else if (lastKLineModel.Low.doubleValue > priceString.doubleValue) {
                lastKLineModel.Low = [NSNumber numberWithDouble:priceString.doubleValue];
            }
            lastKLineModel.Close = [NSNumber numberWithDouble:priceString.doubleValue];
            lastKLineModel.Volume = lastKLineModel.Volume + volumeString.doubleValue;
            
            NSMutableArray *kLineDataArray = [NSMutableArray array];
            [kLineDataArray addObject:lastKLineModel.Date];
            [kLineDataArray addObject:lastKLineModel.Open];
            [kLineDataArray addObject:lastKLineModel.High];
            [kLineDataArray addObject:lastKLineModel.Low];
            [kLineDataArray addObject:lastKLineModel.Close];
            [kLineDataArray addObject:[NSString stringWithFormat:@"%lf",lastKLineModel.Volume]];
            
            Y_KLineModel *kLineModel = [Y_KLineModel new];
            kLineModel.PreviousKlineModel = lastKLineModel.PreviousKlineModel;
            [kLineModel initWithArray:kLineDataArray];
            kLineModel.ParentGroupModel = self;
            [self.models replaceObjectAtIndex:self.models.count - 1 withObject:kLineModel];
        }
    }
    else {
        NSMutableArray *kLineDataArray = [NSMutableArray array];
        [kLineDataArray addObject:lastTimerString];
        [kLineDataArray addObject:priceString];
        [kLineDataArray addObject:priceString];
        [kLineDataArray addObject:priceString];
        [kLineDataArray addObject:priceString];
        [kLineDataArray addObject:volumeString];
        Y_KLineModel *preModel = [[Y_KLineModel alloc]init];
        Y_KLineModel *kLineModel = [Y_KLineModel new];
        kLineModel.PreviousKlineModel = preModel;
        [kLineModel initWithArray:kLineDataArray];
        [self.models addObject:kLineModel];
        kLineModel.ParentGroupModel = self;
    }
}

- (NSInteger )getKLineTimer {
    NSInteger kLineTimer;
    switch (self.defaultKLineType) {
        case KLineTypeTime:
            kLineTimer = 60 * 1;
            break;
        case KLineTypeOneMinute:
            kLineTimer = 60 * 1;
            break;
        case KLineTypeFiveMinute:
            kLineTimer = 60 * 5;
            break;
        case KLineTypeFifteenMinute:
            kLineTimer = 60 * 15;
            break;
        case KLineTypeThirtyMinute:
            kLineTimer = 60 * 30;
            break;
        case KLineTypeOneHour:
            kLineTimer = 60 * 60;
            break;
        case KLineTypeTwoHour:
            kLineTimer = 60 * 60 * 2;
            break;
        case KLineTypeFourHour:
            kLineTimer = 60 * 60 * 4;
            break;
        case KLineTypeSixHour:
            kLineTimer = 60 * 60 * 6;
            break;
        case KLineTypeTwelveHour:
            kLineTimer = 60 * 60 * 12;
            break;
        case KLineTypeDay:
            kLineTimer = 60 * 60 * 24;
            break;
        case KLineTypeWeek:
            kLineTimer = 60 * 60 * 24 * 7;
            break;
            
        default:
            break;
    }
    return kLineTimer;
}

@end
