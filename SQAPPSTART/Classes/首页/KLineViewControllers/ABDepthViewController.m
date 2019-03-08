//
//  ABDepthViewController.m
//  Y_ChartView_Example
//
//  Created by ly on 2019/1/8.
//  Copyright © 2019 iCoobin. All rights reserved.
//

#import "ABDepthViewController.h"
#import "DepthChartView.h"
#import "Masonry.h"
#import "ABDataSourceManager.h"
#import "UIColor+Y_StockChart.h"

@interface ABDepthViewController ()

@property (nonatomic, strong) DepthChartView *depthChartView;

@end

@implementation ABDepthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor backgroundColor];
    
    [self addSubviews];
    [self addConstrains];
    [self setDatas];
}

- (void)addSubviews {
    [self.view addSubview:self.depthChartView];
}

- (void)addConstrains {
    [self.depthChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.inset(18);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
}

- (void)setDatas {
    DepthGroupModel *depthGroupModel = [[ABDataSourceManager sharedInstance] getDepthDatasLocal];
    if (depthGroupModel) {
        self.depthChartView.depthGroupModel = depthGroupModel;
    }
}

- (DepthChartView *)depthChartView {
    if (!_depthChartView) {
        _depthChartView = [[DepthChartView alloc] init];
    }
    return _depthChartView;
}



@end
