//
//  SQHomeFullScreenVC.m
//  SQAPPSTART
//
//  Created by qwuser on 2019/3/13.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SQHomeFullScreenVC.h"
#import "ABKLineViewModel.h"
#import "Y_StockChartSegmentView.h"
#import "Y_ChartView.h"
#import "ABKInfoWindowWhenPress.h"
#import "SQHomeTopInfosView.h"


@interface SQHomeFullScreenVC () <Y_ChartViewDelegate, Y_StockChartSegmentViewDelegate, ABKLineViewModelDelegate>

@property (nonatomic, strong)   UIButton                *closeFullButton;


@property (nonatomic, strong)   ABKLineViewModel        *viewModel;

@property (nonatomic, strong)   SQHomeTopInfosView      *topInfoView;
@property (nonatomic, strong)   Y_StockChartSegmentView        *segment;
@property (nonatomic, strong) Y_ChartView *customKLineView;

@property (nonatomic, strong)   ABKInfoWindowWhenPress        *infoWindow;

@property (nonatomic, assign)   CGPoint        firstTapedPoint;

@end

@implementation SQHomeFullScreenVC {
    BOOL    _showInLeftWindow;
}

- (void)addConstrains {
    [self.topInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(60);
    }];
    
    [self.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_topInfoView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [self.customKLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(_segment.mas_bottom);
    }];
    
    [self.closeFullButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(22);
        make.right.inset(KMARGIN);
        make.centerY.equalTo(_topInfoView);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSubviews];
    [self addConstrains];
    [self reloadKlineViews];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self hiddenStatusBar:YES];
    self.navigationController.navigationBar.hidden = YES;
}
- (void)addSubviews {
    [self hiddenStatusBar:YES];
    [self.view addSubview:self.topInfoView];
    [self.view addSubview:self.customKLineView];
    [self.view addSubview:self.segment];
    [self.view addSubview:self.closeFullButton];
}
- (void)reloadKlineViews {
    [self.viewModel getGroupModelSuccess:^(Y_KLineGroupModel * _Nonnull groupModel) {
        [self.customKLineView updateKLineData:groupModel];
        [self.customKLineView updateAccessoryData:[groupModel.models lastObject]];
    }];
}
#pragma delegate - Y_ChartViewDelegate
- (void)longPressWithModel:(Y_KLineModel *)kLineModel {
    self.infoWindow.model = kLineModel;
    [UIView animateWithDuration:0.2 animations:^{
        self.infoWindow.alpha = 1;
    }];
    [self infoWindowShowInLeft:self.firstTapedPoint.x>self.customKLineView.frame.size.width/2.0];
}
- (void)infoWindowShowInLeft:(BOOL)showInLeft {
    if (showInLeft!=_showInLeftWindow) {
        if (showInLeft) {
            [self.infoWindow mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_customKLineView);
                make.left.equalTo(_customKLineView).offset(KSTATU_HEIGHT);
                make.width.mas_equalTo(120);
                make.height.mas_equalTo(160);
            }];
        } else {
            [self.infoWindow mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(_customKLineView);
                make.right.equalTo(_customKLineView).offset(-10);
                make.width.mas_equalTo(120);
                make.height.mas_equalTo(160);
            }];
        }
        _showInLeftWindow = showInLeft;
    }
}

- (void)cancelLongPress {
    [UIView animateWithDuration:0.2 animations:^{
        self.infoWindow.alpha = 0;
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
- (SQHomeTopInfosView *)topInfoView {
    if (!_topInfoView) {
        _topInfoView = [[SQHomeTopInfosView alloc] init];
        _topInfoView.isFullScreen = YES;
    }
    return _topInfoView;
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
        _infoWindow.alpha = 0;
        [self.view addSubview:_infoWindow];
    }
    return _infoWindow;
}

- (UIButton *)closeFullButton {
    if (!_closeFullButton) {
        _closeFullButton = [[UIButton alloc] init];
        _closeFullButton.layer.cornerRadius = 11;
        _closeFullButton.layer.masksToBounds = YES;
        _closeFullButton.backgroundColor = KCOLOR_MAIN;
        [_closeFullButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeFullButton;
}
- (void)closeAction {
    [self hiddenStatusBar:NO];
    self.navigationController.navigationBar.hidden = NO;
    [self dismiss];
}

@end
