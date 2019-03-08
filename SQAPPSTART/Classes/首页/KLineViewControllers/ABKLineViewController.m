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

/** 时分秒  */
@property (nonatomic, assign)   NSInteger        currentIndex;
/** 数据源  */
@property (nonatomic, strong)   NSMutableDictionary        *dataDict;

@end

@implementation ABKLineViewController {
    NSArray     *kLineTypeArr;/** K线图分类列表  */
}
- (void)addSubviews {
    self.dataDict = [NSMutableDictionary dictionary];
    kLineTypeArr = @[@"1min", @"5min", @"15min", @"30min", @"1hour", @"12hour", @"1day", @"1week"];
    [self.view addSubview:self.customKLineView];
    [self.view addSubview:self.segment];
}

- (void)addConstrains {
    [self.customKLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(18);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(18);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor backgroundColor];
    
    [self addSubviews];
    [self addConstrains];
    [self reloadData];
}

- (void)y_StockChartSegmentView:(Y_StockChartSegmentView *)segmentView clickSegmentButtonIndex:(NSInteger)index {
    self.currentIndex = index;
    if(![self.dataDict objectForKey:kLineTypeArr[index]]) {//如果没有存储数据，请求
        [self reloadData];
    } else {//如果存储有数据，读取存储的数据
        Y_KLineGroupModel *groupModel = [self.dataDict objectForKey:kLineTypeArr[index]];
        [self.customKLineView updateKLineData:groupModel];
        [self.customKLineView updateAccessoryData:[groupModel.models lastObject]];
    }
}

- (void)reloadData {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"type"] = kLineTypeArr[self.currentIndex];
    param[@"market"] = @"btc_usdt";
    param[@"size"] = @"1000";
    [NetWorking requestWithApi:@"http://api.bitkk.com/data/v1/kline" param:param thenSuccess:^(NSDictionary *responseObject) {
        Y_KLineGroupModel *groupModel = [Y_KLineGroupModel objectWithArray:responseObject[@"data"]];
        groupModel.defaultKLineType = [self getKlineType];
        [self.dataDict setValue:groupModel forKey:self->kLineTypeArr[self.currentIndex]];
        [self.customKLineView updateKLineData:groupModel];
        [self.customKLineView updateAccessoryData:[groupModel.models lastObject]];
    } fail: nil];
}




- (KLineType)getKlineType {
    NSString    *typeStr = kLineTypeArr[self.currentIndex];
    if ([typeStr isEqualToString:@"1min"]) {
        return KLineTypeTime;
//        return KLineTypeOneMinute;
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
        _segment.items = kLineTypeArr;
        _segment.delegate = self;
        _segment.selectedIndex = 0;
    }
    return _segment;
}

@end
