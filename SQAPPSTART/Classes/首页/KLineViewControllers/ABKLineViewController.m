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

@interface ABKLineViewController ()<Y_ChartViewDelegate>

@property (nonatomic, strong) Y_ChartView *customKLineView;

@end

@implementation ABKLineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor backgroundColor];
    self.title = @"Y_KLineView";
    
    [self addSubviews];
    [self addConstrains];
    [self setDatas];
}

- (void)addSubviews {
    [self.view addSubview:self.customKLineView];
}

- (void)addConstrains {
    [self.customKLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(18);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
}

- (void)setDatas {
    Y_KLineGroupModel *groupModel = [[ABDataSourceManager sharedInstance] getKLineDatasLocal];
    if (groupModel) {
        [self.customKLineView updateKLineData:groupModel];
        if (groupModel.models.count > 0) {
            [self.customKLineView updateAccessoryData:[groupModel.models lastObject]];
        }
    }
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

@end
