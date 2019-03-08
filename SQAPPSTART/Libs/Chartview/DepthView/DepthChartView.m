//
//  DepthChartView.m
//  Exchange
//
//  Created by mengfanjun on 2018/4/27.
//  Copyright © 2018年 5th. All rights reserved.
//

#import "DepthChartView.h"
#import "DepthView.h"
#import "DepthAmountView.h"
#import "DepthPriceView.h"
#import "DepthLongPressView.h"
#import "DepthModel.h"
#import "UIColor+Y_StockChart.h"
#import <Masonry/Masonry.h>

@interface DepthChartView () <DepthViewDelegate>

@property (nonatomic, strong) DepthAmountView *depthAmountView;

@property (nonatomic, strong) DepthPriceView *depthPriceView;

/**
 深度图
 */
@property (nonatomic, strong) DepthView *depthView;

@property (nonatomic, strong) DepthLongPressView *depthLongPressView;

@end

@implementation DepthChartView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubviews];
        [self addConstraints];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.depthAmountView];
    [self addSubview:self.depthPriceView];
    [self addSubview:self.depthView];
    [self addSubview:self.depthLongPressView];
}

- (void)addConstraints {
    
    __weak typeof(self) weakSelf = self;
    [self.depthAmountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf);
        make.left.right.mas_equalTo(weakSelf.depthView);
        make.bottom.mas_equalTo(weakSelf.depthPriceView.mas_top);
    }];
    
    [self.depthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.depthPriceView);
        make.bottom.mas_equalTo(weakSelf.depthAmountView);
        make.width.mas_equalTo(weakSelf.depthPriceView).multipliedBy(PriceScale);
        make.height.mas_equalTo(weakSelf.depthAmountView).multipliedBy(AmountScale);
    }];
    
    [self.depthPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf);
        make.height.mas_equalTo(16);
    }];
    
    [self.depthLongPressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(weakSelf);
    }];
}

#pragma mark - DepthViewDelegate
- (void)depthViewLongPressDepthModel:(DepthModel *)depthModel {
    //更新位置
    self.depthLongPressView.hidden = NO;
    self.depthLongPressView.depthModel = depthModel;
}

#pragma mark - Event Response
//长按事件
- (void)event_longPressMethod:(UILongPressGestureRecognizer *)longPress
{
    static CGFloat oldPositionX = 0;
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state)
    {
        CGPoint location = [longPress locationInView:self.depthView];
        [self.depthView getExactXPositionWithOriginXPosition:location.x];
    }
    if(longPress.state == UIGestureRecognizerStateEnded)
    {
        //取消竖线
        oldPositionX = 0;
        self.depthLongPressView.hidden = YES;
    }
    
}

#pragma mark - Getters & Setters
- (DepthAmountView *)depthAmountView {
    if (!_depthAmountView) {
        _depthAmountView = [[DepthAmountView alloc] init];
        _depthAmountView.backgroundColor = [UIColor clearColor];
    }
    return _depthAmountView;
}

- (DepthView *)depthView {
    if (!_depthView) {
        _depthView = [[DepthView alloc] init];
        _depthView.backgroundColor = [UIColor clearColor];
        _depthView.delegate = self;
        
        //长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressMethod:)];
        [_depthView addGestureRecognizer:longPressGesture];
    }
    return _depthView;
}

- (DepthPriceView *)depthPriceView {
    if (!_depthPriceView) {
        _depthPriceView = [[DepthPriceView alloc] init];
    }
    return _depthPriceView;
}

- (DepthLongPressView *)depthLongPressView {
    if (!_depthLongPressView) {
        _depthLongPressView = [[DepthLongPressView alloc] init];
        _depthLongPressView.hidden = YES;
    }
    return _depthLongPressView;
}

- (void)setDepthGroupModel:(DepthGroupModel *)depthGroupModel {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    if (!depthGroupModel) {
        self.depthView.hidden = YES;
        self.depthAmountView.hidden = YES;
        self.depthPriceView.hidden = YES;
        return;
    }
    else {
        self.depthView.hidden = NO;
        self.depthAmountView.hidden = NO;
        self.depthPriceView.hidden = NO;
    }
    _depthGroupModel = depthGroupModel;
    self.depthView.depthGroupModel = depthGroupModel;
    self.depthAmountView.depthGroupModel = depthGroupModel;
    self.depthPriceView.depthGroupModel = depthGroupModel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
