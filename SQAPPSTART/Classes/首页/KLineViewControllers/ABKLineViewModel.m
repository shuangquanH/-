//
//  ABKLineViewModel.m
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ABKLineViewModel.h"

#import "NetWorking.h"

@implementation ABKLineViewModel {
    
    NSMutableDictionary *requestParam;
    NSMutableDictionary *dataCashDic;
    NSArray     *kLineTypeArr;/** K线图分类列表  */
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        requestParam = [NSMutableDictionary dictionary];
        [requestParam setValue:@"1min" forKey:@"type"];
        [requestParam setValue:@"btc_usdt" forKey:@"market"];
        [requestParam setValue:@"1000" forKey:@"size"];
        kLineTypeArr = @[@"1min", @"5min", @"15min", @"30min", @"1hour", @"6hour", @"12hour", @"1day", @"1week", @"1month"];
        
        dataCashDic = [NSMutableDictionary dictionary];
        
    }
    return self;
}


- (Y_KLineGroupModel *)getGroupModelWithCash {
    Y_KLineGroupModel *groupModel = [dataCashDic valueForKey:requestParam[@"type"]];
    if (groupModel) {
        return groupModel;
    } else {
        return nil;
    }
}

- (void)requestGroupModelSuccess:(void(^)(Y_KLineGroupModel *))success failure:(void(^)(NSString *))failure {
    
    [NetWorking requestWithApi:@"http://api.bitkk.com/data/v1/kline" param:requestParam thenSuccess:^(NSDictionary *responseObject) {
        Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:responseObject[@"data"]];
        groupModel.defaultKLineType = [self getKlineTypeWithRequestType:requestParam[@"type"]];
        [dataCashDic setValue:groupModel forKey:requestParam[@"type"]];
        success(groupModel);
        
        
    } fail:^{
        if (failure) { failure(@"请求数据失败!");
        }
    }];
}

- (void)getGroupModelSuccess:(void(^)(Y_KLineGroupModel *groupModel))success {
    Y_KLineGroupModel *groupModel = [self getGroupModelWithCash];
    if (groupModel) {
        success(groupModel);
    } else {
        [self requestGroupModelSuccess:^(Y_KLineGroupModel *groupModel) {
            success(groupModel);
        } failure:nil];
    }
}

- (void)switchSegmentButtonWithBtnTitle:(NSString *)title {
    //先获取按钮点击的类型
    NSString    *requestType = [self getRequestTypeWithButtonTitle:title];
    //如果是修改k线类型
    if ([kLineTypeArr containsObject:requestType]) {
        [requestParam setValue:requestType forKey:@"type"];
        [self.delegate needReloadKLineData];
    } else {
        
        Y_StockChartTargetLineStatus status = [self getChartTargetLineTypeWithRequestType:title];
        if (status==Y_StockChartTargetLineStatusMA||
            status==Y_StockChartTargetLineStatusEMA||
            status==Y_StockChartTargetLineStatusBOLL||
            status==Y_StockChartTargetLineStatusCloseMA) {
            //修改k线图的辅助图形
            [self.delegate needReloadKLineStyle:status];
            
            
        } else if (status==Y_StockChartTargetLineStatusMACD||
                   status==Y_StockChartTargetLineStatusKDJ||
                   status==Y_StockChartTargetLineStatusVOL||
                   status==Y_StockChartTargetLineStatusRSI) {
            [self.delegate needReloadDeputyStyle:status];
            
        } else {
            [self.delegate needReloadDeputyStyle:Y_StockChartTargetLineStatusVOL];
        }
        
        
        
        
    }
}


/** 根据请求的param的type来获取k线显示类型  */
- (KLineType)getKlineTypeWithRequestType:(NSString *)typeStr {
    if ([typeStr isEqualToString:@"1min"]) {
        return KLineTypeTime;
        //return KLineTypeOneMinute;
    } else if ([typeStr isEqualToString:@"5min"]) {
        return KLineTypeFiveMinute;
    } else if ([typeStr isEqualToString:@"15min"]) {
        return KLineTypeFifteenMinute;
    } else if ([typeStr isEqualToString:@"30min"]) {
        return KLineTypeThirtyMinute;
    } else if ([typeStr isEqualToString:@"1hour"]) {
        return KLineTypeOneHour;
    } else if ([typeStr isEqualToString:@"2hour"]) {
        return KLineTypeTwoHour;
    } else if ([typeStr isEqualToString:@"4hour"]) {
        return KLineTypeFourHour;
    } else if ([typeStr isEqualToString:@"6hour"]) {
        return KLineTypeSixHour;
    } else if ([typeStr isEqualToString:@"12hour"]) {
        return KLineTypeTwelveHour;
    } else if ([typeStr isEqualToString:@"1day"]) {
        return KLineTypeDay;
    } else if ([typeStr isEqualToString:@"1week"]) {
        return KLineTypeWeek;
    }
    return KLineTypeTime;
}



/** 根据segment选中button的title来获取请求type  */
- (NSString *)getRequestTypeWithButtonTitle:(NSString *)title {
    if ([title isEqualToString:@"分时"]) {
        return @"1min";
    } else if ([title isEqualToString:@"1分"]) {
        return @"1min";
    } else if ([title isEqualToString:@"5分"]) {
        return @"5min";
    } else if ([title isEqualToString:@"15分"]) {
        return @"15min";
    } else if ([title isEqualToString:@"30分"]) {
        return @"30min";
    } else if ([title isEqualToString:@"1小时"]) {
        return @"1hour";
    } else if ([title isEqualToString:@"2小时"]) {
        return @"2hour";
    } else if ([title isEqualToString:@"4小时"]) {
        return @"4hour";
    } else if ([title isEqualToString:@"6小时"]) {
        return @"6hour";
    } else if ([title isEqualToString:@"12小时"]) {
        return @"12hour";
    } else if ([title isEqualToString:@"日线"]) {
        return @"1day";
    } else if ([title isEqualToString:@"周线"]) {
        return @"1week";
    } else if ([title isEqualToString:@"1月"]) {
        return @"1month";
    } else {
        return nil;
    }
}


//根据按钮title获取技术图形类别
- (Y_StockChartTargetLineStatus)getChartTargetLineTypeWithRequestType:(NSString *)typeStr {
    if ([typeStr isEqualToString:@"MACD"]) {
        return Y_StockChartTargetLineStatusMACD;
    } else if ([typeStr isEqualToString:@"KDJ"]) {
        return Y_StockChartTargetLineStatusKDJ;
    } else if ([typeStr isEqualToString:@"VOL"]) {
        return Y_StockChartTargetLineStatusVOL;
    } else if ([typeStr isEqualToString:@"RSI"]) {
        return Y_StockChartTargetLineStatusRSI;
    } else if ([typeStr isEqualToString:@"隐藏"]) {//关闭k线技术图形，显示成交量
        return Y_StockChartTargetLineStatusCloseMA;
    } else if ([typeStr isEqualToString:@"MA"]) {
        return Y_StockChartTargetLineStatusMA;
    } else if ([typeStr isEqualToString:@"EMA"]) {
        return Y_StockChartTargetLineStatusEMA;
    } else if ([typeStr isEqualToString:@"BOLL"]) {
        return Y_StockChartTargetLineStatusBOLL;
    } else {
        return Y_StockChartTargetLineStatusAccessoryClose;;//关闭技术图上的辅助线
    }
}




@end
