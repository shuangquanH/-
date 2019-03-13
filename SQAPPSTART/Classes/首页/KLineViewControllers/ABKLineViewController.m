//
//  ABKLineViewController.m
//  Y_ChartView_Example
//
//  Created by ly on 2019/1/4.
//  Copyright © 2019 iCoobin. All rights reserved.
//

#import "ABKLineViewController.h"
#import "UIColor+Y_StockChart.h"
#import "Y_ChartView.h"
#import "Y_StockChartSegmentView.h"

#import "ABKInfoWindowWhenPress.h"

#import "ABKLineViewModel.h"



@interface ABKLineViewController ()<Y_ChartViewDelegate, Y_StockChartSegmentViewDelegate, ABKLineViewModelDelegate>

@property (nonatomic, strong) Y_ChartView *customKLineView;

@property (nonatomic, strong)   Y_StockChartSegmentView        *segment;

@property (nonatomic, strong)   ABKLineViewModel        *viewModel;

@property (nonatomic, strong)   ABKInfoWindowWhenPress        *infoWindow;

@property (nonatomic, assign)   CGPoint        firstTapedPoint;


@end

@implementation ABKLineViewController
- (void)addSubviews {
    self.view.backgroundColor = [UIColor backgroundColor];
    [self.view addSubview:self.customKLineView];
    [self.view addSubview:self.segment];
}

- (void)addConstrains {
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [self.customKLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.top.equalTo(self.segment.mas_bottom).offset(6);
    }];

    [self.infoWindow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_customKLineView);
        make.right.equalTo(_customKLineView).offset(-10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(160);
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self addConstrains];
}


- (void)reloadKlineViews {
    [self.viewModel getGroupModelSuccess:^(Y_KLineGroupModel * _Nonnull groupModel) {
        [self.customKLineView updateKLineData:groupModel];
        [self.customKLineView updateAccessoryData:[groupModel.models lastObject]];
    }];
}



#pragma delegate - Y_ChartViewDelegate
- (void)longPressWithModel:(Y_KLineModel *)kLineModel {
    [UIView animateWithDuration:0.4 animations:^{
        self.infoWindow.hidden = NO;
    }];
    self.infoWindow.model = kLineModel;
    if (self.firstTapedPoint.x<self.customKLineView.frame.size.width/2.0) {
        [self.infoWindow mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_customKLineView);
            make.right.equalTo(_customKLineView).offset(-10);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(160);
        }];

    } else {
        [self.infoWindow mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_customKLineView);
            make.left.equalTo(_customKLineView).offset(10);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(160);
        }];
    }
}

- (void)cancelLongPress {
    [UIView animateWithDuration:0.1 animations:^{
        self.infoWindow.hidden = YES;
    }];
}
- (void)firstTapedPoint:(CGPoint)point {
    self.firstTapedPoint = point;
}
- (void)y_StockChartSegmentView:(Y_StockChartSegmentView *)segmentView clickSegmentButton:(UIButton *)button {
    [self.viewModel switchSegmentButtonWithBtnTitle:button.titleLabel.text];
}

- (void)needReloadKLineData {
    [self reloadKlineViews];
}

/** 需要修改k线图技术展示样式  */
- (void)needReloadKLineStyle:(Y_StockChartTargetLineStatus)style {
    [self.customKLineView changeMainChartSegmentType:style];
    
}
/** 需要修改副图技术展示样式  */
- (void)needReloadDeputyStyle:(Y_StockChartTargetLineStatus)style {
    [self.customKLineView changeDeputyChartSegmentType:style];
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
- (ABKLineViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ABKLineViewModel alloc] init];
        _viewModel.delegate = self;
    }
    return _viewModel;
}

- (ABKInfoWindowWhenPress *)infoWindow {
    if (!_infoWindow) {
        _infoWindow = [[ABKInfoWindowWhenPress alloc] init];
        [self.view addSubview:_infoWindow];
        _infoWindow.hidden = YES;
    }
    return _infoWindow;
}

@end
