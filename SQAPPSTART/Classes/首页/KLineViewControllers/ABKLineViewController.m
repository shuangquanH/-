//
//  ABKLineViewController.m
//  Y_ChartView_Example
//
//  Created by ly on 2019/1/4.
//  Copyright © 2019 iCoobin. All rights reserved.
//

#import "ABKLineViewController.h"
#import "Y_ChartView.h"
#import "Masonry.h"
#import "ABDataSourceManager.h"
#import "UIColor+Y_StockChart.h"
#import "NetWorking.h"
#import "Y_StockChartSegmentView.h"




@interface ABKLineViewController ()<Y_ChartViewDelegate, Y_StockChartSegmentViewDelegate>

@property (nonatomic, strong) Y_ChartView *customKLineView;

@property (nonatomic, strong)   Y_StockChartSegmentView        *segment;

/** 数据源  */
@property (nonatomic, strong)   NSMutableDictionary        *dataDict;

@property (nonatomic, copy)   NSString        *currentRequestType;

@end

@implementation ABKLineViewController {
    NSArray     *kLineTypeArr;/** K线图分类列表  */
    NSArray     *macdTypeArr;
}
- (void)addSubviews {
    self.dataDict = [NSMutableDictionary dictionary];
    //K线图类型数组
    kLineTypeArr = @[@"1min", @"5min", @"15min", @"30min", @"1hour", @"6hour", @"12hour", @"1day", @"1week"];
    //技术图形类型数组
    macdTypeArr = @[@"macd", @"kdj", @"vol", @"rsi", @"ma", @"ema", @"boll", @"关闭1", @"关闭2"];
    [self.view addSubview:self.customKLineView];
    [self.view addSubview:self.segment];
}

- (void)addConstrains {
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [self.customKLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.inset(20);
        make.top.equalTo(self.segment.mas_bottom);
    }];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor backgroundColor];
    
    [self addSubviews];
    [self addConstrains];
    
    self.currentRequestType = @"1min";
    [self reloadDataWithType:self.currentRequestType];
}
- (void)y_StockChartSegmentView:(Y_StockChartSegmentView *)segmentView clickSegmentButton:(UIButton *)button {
    //先获取按钮点击的类型
    
    NSString    *requestType = [self getRequestTypeWithButtonTitle:button.titleLabel.text];
    //如果是修改k线类型
    if ([kLineTypeArr containsObject:requestType]) {
        self.currentRequestType = requestType;
        [self reloadKlineViews];
    } else {
        //如果是修改技术图形
        Y_StockChartTargetLineStatus status = [self getChartTargetLineTypeWithRequestType:button.titleLabel.text];
        if (status==Y_StockChartTargetLineStatusMA||
            status==Y_StockChartTargetLineStatusEMA||
            status==Y_StockChartTargetLineStatusBOLL) {
            [self.customKLineView changeMainChartSegmentType:status];
        } else if (status==Y_StockChartTargetLineStatusMACD||
                   status==Y_StockChartTargetLineStatusKDJ||
                   status==Y_StockChartTargetLineStatusVOL||
                   status==Y_StockChartTargetLineStatusRSI) {
            [self.customKLineView changeDeputyChartSegmentType:status];
        }   else if (status==Y_StockChartTargetLineStatusCloseMA){
            [self.customKLineView changeMainChartSegmentType:status];
        } else {
            [self.customKLineView changeDeputyChartSegmentType:Y_StockChartTargetLineStatusVOL];
        }
    }
}
- (void)reloadKlineViews {
    //如果没有存储数据，请求
    if(![self.dataDict objectForKey:self.currentRequestType]) {
        [self reloadDataWithType:self.currentRequestType];
        
    } else {//如果存储有数据，读取存储的数据
        Y_KLineGroupModel *groupModel = [self.dataDict objectForKey:self.currentRequestType];
        [self.customKLineView updateKLineData:groupModel];
        [self.customKLineView updateAccessoryData:[groupModel.models lastObject]];
    }
}
- (void)reloadDataWithType:(NSString *)type {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = type;
    param[@"market"] = @"btc_usdt";
    param[@"size"] = @"1000";
    [NetWorking requestWithApi:@"http://api.bitkk.com/data/v1/kline" param:param thenSuccess:^(NSDictionary *responseObject) {
        Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:responseObject[@"data"]];
        groupModel.defaultKLineType = [self getKlineTypeWithRequestType:type];
        [self.dataDict setValue:groupModel forKey:type];
        
        [self.customKLineView updateKLineData:groupModel];
        [self.customKLineView updateAccessoryData:[groupModel.models lastObject]];
    } fail: nil];
}



#pragma delegate - Y_ChartViewDelegate
- (void)longPressWithModel:(Y_KLineModel *)kLineModel {
    
}

- (void)cancelLongPress {
    
}





- (Y_ChartView *)customKLineView {
    if (!_customKLineView) {
        _customKLineView = [[Y_ChartView alloc] init];
        _customKLineView.delegate = self;
        [_customKLineView updateKLineStyle:Y_StockChartScreenStyleHalf];
    }
    return _customKLineView;
}

- (Y_StockChartSegmentView *)segment {
    if (!_segment) {
        _segment = [[Y_StockChartSegmentView alloc] init];
        _segment.items = @[@"分时", @"15分", @"1小时", @"6小时", @"日线", @"更多", @"指标"];
        _segment.delegate = self;
        _segment.selectedIndex = 0;
    }
    return _segment;
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
    } else if ([title isEqualToString:@"1周"]) {
        return @"1week";
    } else {
        return nil;
    }
    
}

/** 根据请求的type来获取k线显示类型  */
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
