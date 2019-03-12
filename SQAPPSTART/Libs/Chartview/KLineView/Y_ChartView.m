//
//  Y_ChartView.m
//  Exchange
//
//  Created by mengfanjun on 2018/4/27.
//  Copyright © 2018年 5th. All rights reserved.
//

#import "Y_ChartView.h"
#import "Y_KLineMainView.h"
#import "Y_StockChartGlobalVariable.h"
#import "Y_KLineModel.h"
#import "Y_KLineGroupModel.h"
#import "Y_YAxisView.h"
#import "Y_AccessoryView.h"
#import "Y_AccessoryInfoView.h"
#import "UIColor+Y_StockChart.h"
#import <Masonry/Masonry.h>

@interface Y_ChartView () <UIScrollViewDelegate, Y_KLineMainViewDelegate, Y_AccessoryViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

/**
 *  主K线图
 */
@property (nonatomic, strong) Y_KLineMainView *kLineMainView;

@property (nonatomic, strong) Y_YAxisView *kLinePriceView;

/**
 *  副图指标
 */
@property (nonatomic, strong) Y_AccessoryInfoView *fullScreenAccessoryInformationView;
/**
 *  副图
 */
@property (nonatomic, strong) Y_AccessoryView *kLineAccessoryView;

@property (nonatomic, strong) Y_YAxisView *kLineAccessoryPriceView;

/**
 *  长按后显示的View
 */
@property (nonatomic, strong) UIView *verticalView;
@property (nonatomic, strong) UIView *horizontalView;

//记录上一次数据的klineType，如果不同就滑动到最后一条数据的位置显示
@property (nonatomic, assign) KLineType kLineType;
@property (nonatomic, assign) CGFloat kLineWidth;
@property (nonatomic, assign) CGFloat kLineGap;
@property (nonatomic, assign) Y_StockChartScreenStyle style;
@property(nonatomic, copy) NSArray<Y_KLineModel *> *kLineModels;

@end

@implementation Y_ChartView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubviews];
        [self addConstraints];
        [self configData];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.kLineMainView];
    [self addSubview:self.kLinePriceView];
    [self addSubview:self.fullScreenAccessoryInformationView];
    [self addSubview:self.kLineAccessoryView];
    [self addSubview:self.kLineAccessoryPriceView];
    [self addSubview:self.verticalView];
    [self addSubview:self.horizontalView];
    [self addSubview:self.scrollView];
}

- (void)addConstraints {
    __weak typeof(self) weakSelf = self;
    [self.kLinePriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.width.equalTo(weakSelf.scrollView);
        make.bottom.equalTo(weakSelf.kLineMainView).offset(-15);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.width.equalTo(weakSelf);
    }];
    
    [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.scrollView);
        make.width.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
        make.height.equalTo(weakSelf.scrollView.mas_height);
        make.left.equalTo(@(-10));
    }];
    
    [self.horizontalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakSelf.scrollView);
        make.height.equalTo(@(Y_StockChartLongPressVerticalViewWidth));
        make.top.equalTo(@(-10));
    }];
    
    [self.kLineMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(weakSelf.scrollView);
        make.width.equalTo(weakSelf.scrollView);
        make.height.equalTo(weakSelf.scrollView).multipliedBy(0.7);
    }];
    /** 技术图形上方信息行  */
    [self.fullScreenAccessoryInformationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.kLineMainView.mas_bottom);
        make.left.equalTo(weakSelf.scrollView);
        make.width.equalTo(weakSelf.kLineMainView);
        make.height.mas_equalTo(20);
    }];
    /** 技术图形  */
    [self.kLineAccessoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.fullScreenAccessoryInformationView.mas_bottom);
        make.left.equalTo(weakSelf.scrollView);
        make.width.equalTo(weakSelf.kLineMainView);
        make.height.equalTo(weakSelf.scrollView).multipliedBy(0.3).offset(-20);
    }];
    [self.kLineAccessoryPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.equalTo(weakSelf.kLineAccessoryView);
    }];
}

- (void)configData {
    [self private_addAllEventListener];
    self.backgroundColor = [UIColor backgroundColor];
}

/**
 *  更新k线样式
 */
- (void)updateKLineStyle:(Y_StockChartScreenStyle)style {
    self.style = style;
    self.kLineWidth = [Y_StockChartGlobalVariable kLineWidthByStyle:style];
    self.kLineGap = [Y_StockChartGlobalVariable kLineGap];
    [self.kLineMainView updateLineWidth:self.kLineWidth lineGap:self.kLineGap];
    [self.kLineAccessoryView updateLineWidth:self.kLineWidth lineGap:self.kLineGap];
}

static char *observerContext = NULL;
#pragma mark 添加所有事件监听的方法
- (void)private_addAllEventListener{
    //KVO监听scrollview的状态变化
    [self.scrollView addObserver:self forKeyPath:Y_StockChartContentOffsetKey options:NSKeyValueObservingOptionNew context:observerContext];
}

#pragma mark KVO监听实现
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context{
    if([keyPath isEqualToString:Y_StockChartContentOffsetKey])
    {
        [self private_drawKLineMainViewReset];
    }
}

- (void)updateKLineData:(Y_KLineGroupModel *)groupModel {
    //优先强制进行布局
    [self setNeedsLayout];
    [self layoutIfNeeded];
    if (groupModel) {
        //先设置精度
        self.kLinePriceView.ask_fixed = groupModel.ask_fixed;
        self.kLinePriceView.bid_fixed = groupModel.bid_fixed;
        //然后绘制k线
        if (self.kLineModels != nil && self.kLineType != groupModel.defaultKLineType) {
            [self scrollToLastView];
        }
        self.kLineType = groupModel.defaultKLineType;
        if (groupModel.defaultKLineType == KLineTypeTime) {
            self.kLineMainView.MainViewType = Y_StockChartcenterViewTypeTimeLine;
        }
        else {
            self.kLineMainView.MainViewType = Y_StockChartcenterViewTypeKline;
        }
        self.kLineModels = [groupModel.models mutableCopy];
        
        [self.fullScreenAccessoryInformationView setKLineModel:self.kLineModels.lastObject];
    }
}


#pragma mark Y_KLineMainViewDelegate 更新时通知下方的view进行相应内容更新
- (void)kLineMainViewCurrentNeedDrawKLineModels:(NSArray *)needDrawKLineModels {
    self.kLineAccessoryView.needDrawKLineModels = needDrawKLineModels;
}

- (void)kLineMainViewCurrentNeedDrawKLinePositionModels:(NSArray *)needDrawKLinePositionModels {
    self.kLineAccessoryView.needDrawKLinePositionModels = needDrawKLinePositionModels;
}

- (void)kLineMainViewCurrentNeedDrawKLineColors:(NSArray *)kLineColors {
    self.kLineAccessoryView.kLineColors = kLineColors;
    [self private_drawKLineAccessoryView];
}

- (void)kLineMainViewLongPressKLinePositionModel:(Y_KLinePositionModel *)kLinePositionModel kLineModel:(Y_KLineModel *)kLineModel {
    //更新ma信息
    if ([self.delegate respondsToSelector:@selector(longPressWithModel:)]) {
        [self.delegate longPressWithModel:kLineModel];
    }
    //更新位置
    self.verticalView.hidden = NO;
    [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(kLinePositionModel.HighPoint.x));
    }];
    
    self.horizontalView.hidden = NO;
    [self.horizontalView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinePositionModel.ClosePoint.y));
    }];
    
    [self.verticalView layoutIfNeeded];
    [self.horizontalView layoutIfNeeded];
}
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    [self.delegate firstTapedPoint:point];
    return YES;
}

- (void)kLineMainViewCurrentMaxPrice:(CGFloat)maxPrice minPrice:(CGFloat)minPrice {
    [self.kLinePriceView setLineCount:4 maxPrice:maxPrice minPrice:minPrice];
}

#pragma mark Y_KLineAccessoryViewDelegate 更新副图纵坐标
- (void)kLineAccessoryViewCurrentMaxValue:(CGFloat)maxValue minValue:(CGFloat)minValue{
    if (self.kLineAccessoryView.targetLineStatus == Y_StockChartTargetLineStatusVOL) {
        self.kLineAccessoryPriceView.bid_fixed = @"0";
    } else {
        self.kLineAccessoryPriceView.bid_fixed = @"5";
    }
    [self.kLineAccessoryPriceView setLineCount:1 maxPrice:maxValue minPrice:minValue];
}

#pragma mark - Event Response
#pragma mark 缩放执行方法
- (void)event_pichMethod:(UIPinchGestureRecognizer *)pinch
{
    if( pinch.numberOfTouches != 2 ) return;
    CGFloat oldScale = 1.0f;
    CGFloat difValue = pinch.scale - oldScale;
    if(ABS(difValue) > Y_StockChartScaleBound) {
        CGFloat oldKLineWidth = self.kLineWidth;
        //修改柱子宽度
        NSInteger KLineCount = [Y_StockChartGlobalVariable kLineCount];
        CGFloat ratio = (difValue > 0 ? (1 - Y_StockChartScaleFactor) : (1 + Y_StockChartScaleFactor));
        [Y_StockChartGlobalVariable setkLineCount:(NSInteger)KLineCount * ratio];
        [self updateKLineStyle:self.style];
        
        //设置scrollview的偏移量（通过计算放大后的起始Index）
        CGPoint p1 = [pinch locationOfTouch:0 inView:self.scrollView];
        CGPoint p2 = [pinch locationOfTouch:1 inView:self.scrollView];
        CGPoint centerPoint = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
        NSInteger oldLeftArrCount = ABS(centerPoint.x - self.scrollView.contentOffset.x) / (self.kLineGap + oldKLineWidth);
        NSInteger newLeftArrCount = ABS(centerPoint.x - self.scrollView.contentOffset.x) / (self.kLineGap + self.kLineWidth);
        NSInteger targetIndex = MAX(0, self.kLineMainView.needDrawStartIndex + oldLeftArrCount - newLeftArrCount);
        
        CGFloat offset = targetIndex * (self.kLineGap + self.kLineWidth);
        
        //注意：一定要在设置ContentOffset之后再设置scrollview的contentSize
        //注意：一定要在设置ContentOffset之后再设置scrollview的contentSize
        //注意：一定要在设置ContentOffset之后再设置scrollview的contentSize
        CGFloat kLineViewWidth = self.kLineModels.count * self.kLineWidth + (self.kLineModels.count - 1) * self.kLineGap;
        if(kLineViewWidth < self.scrollView.bounds.size.width) {
            kLineViewWidth = self.scrollView.bounds.size.width;
            [self.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        } else {
            [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:NO];
        }
        self.scrollView.contentSize = CGSizeMake(kLineViewWidth, self.scrollView.frame.size.height);
        //更新MainView的宽度
        [self private_drawKLineMainViewReset];
    }
    
}

#pragma mark 长按手势执行方法
- (void)event_longPressMethod:(UILongPressGestureRecognizer *)longPress
{
    static CGFloat oldPositionX = 0;
    if(UIGestureRecognizerStateChanged == longPress.state || UIGestureRecognizerStateBegan == longPress.state)
    {
        CGPoint location = [longPress locationInView:self.kLineMainView];
        if(ABS(oldPositionX - location.x) < (self.kLineGap + self.kLineWidth)/2)
        {
            return;
        }
        [self.kLineMainView getExactXPositionWithOriginXPosition:location.x];
    }
    
    if(longPress.state == UIGestureRecognizerStateEnded)
    {
        //隐藏长按视图
        self.verticalView.hidden = YES;
        self.horizontalView.hidden = YES;
        oldPositionX = 0;
        [self.fullScreenAccessoryInformationView setKLineModel:self.kLineModels.lastObject];
        if ([self.delegate respondsToSelector:@selector(cancelLongPress)]) {
            [self.delegate cancelLongPress];
        }
    }
}

#pragma mark - Getters & Setters
- (UIScrollView *)scrollView {
    if(!_scrollView) {
        _scrollView = [UIScrollView new];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.minimumZoomScale = 1.0f;
        _scrollView.maximumZoomScale = 1.0f;
        //        _scrollView.alwaysBounceHorizontal = YES;
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        //缩放手势
        UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(event_pichMethod:)];
        [_scrollView addGestureRecognizer:pinchGesture];
        
        //长按手势
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(event_longPressMethod:)];
        [_scrollView addGestureRecognizer:longPressGesture];
    }
    return _scrollView;
}

- (Y_KLineMainView *)kLineMainView {
    if (!_kLineMainView) {
        _kLineMainView = [[Y_KLineMainView alloc] init];
        _kLineMainView.delegate = self;
        
    }
    return _kLineMainView;
}

- (Y_YAxisView *)kLinePriceView {
    if (!_kLinePriceView) {
        _kLinePriceView = [[Y_YAxisView alloc] init];
        _kLinePriceView.backgroundColor = [UIColor clearColor];
        _kLinePriceView.userInteractionEnabled = NO;
    }
    return _kLinePriceView;
}

- (Y_YAxisView *)kLineAccessoryPriceView {
    if (!_kLineAccessoryPriceView) {
        _kLineAccessoryPriceView = [[Y_YAxisView alloc] init];
        _kLineAccessoryPriceView.backgroundColor = [UIColor clearColor];
        _kLineAccessoryPriceView.userInteractionEnabled = NO;
    }
    return _kLineAccessoryPriceView;
}

- (Y_AccessoryView *)kLineAccessoryView
{
    if(!_kLineAccessoryView)
    {
        _kLineAccessoryView = [[Y_AccessoryView alloc] init];
        _kLineAccessoryView.targetLineStatus = Y_StockChartTargetLineStatusVOL;
        _kLineAccessoryView.delegate = self;
    }
    return _kLineAccessoryView;
}

- (UIView *)horizontalView {
    if (!_horizontalView) {
        _horizontalView = [[UIView alloc] init];
        _horizontalView.backgroundColor = [UIColor y_colorWithHexString:@"9AADC0"];
        _horizontalView.hidden = YES;
    }
    return _horizontalView;
}

- (UIView *)verticalView {
    if (!_verticalView) {
        _verticalView = [[UIView alloc] init];
        _verticalView.backgroundColor = [UIColor y_colorWithHexString:@"9AADC0"];
        _verticalView.hidden = YES;
    }
    return _verticalView;
}

- (Y_AccessoryInfoView *)fullScreenAccessoryInformationView {
    if (!_fullScreenAccessoryInformationView) {
        _fullScreenAccessoryInformationView = [[Y_AccessoryInfoView alloc] init];
        [_fullScreenAccessoryInformationView setLineType:Y_StockChartTargetLineStatusVOL];
    }
    return _fullScreenAccessoryInformationView;
}

- (void)setKLineModels:(NSArray<Y_KLineModel *> *)kLineModels {
    BOOL isNeedUpdateOffset = NO;
    NSInteger indexStart = self.scrollView.contentOffset.x / (self.kLineGap + self.kLineWidth);
    if (_kLineModels == nil || indexStart + [Y_StockChartGlobalVariable kLineCount] > _kLineModels.count - 5) {
        isNeedUpdateOffset = YES;
    }
    _kLineModels = kLineModels;
    if (kLineModels.count == 0) {
        self.scrollView.hidden = YES;
        self.kLineMainView.hidden = YES;
        self.kLineAccessoryView.hidden = YES;
        self.kLinePriceView.hidden = YES;
        return;
    } else {
        self.scrollView.hidden = NO;
        self.kLineMainView.hidden = NO;
        self.kLineAccessoryView.hidden = NO;
        self.kLinePriceView.hidden = NO;
    }
    self.kLineMainView.kLineModels = _kLineModels;
    
    CGFloat kLineViewWidth = _kLineModels.count * self.kLineWidth + (_kLineModels.count - 1) * self.kLineGap;
    kLineViewWidth = MAX(kLineViewWidth, self.scrollView.bounds.size.width);
    self.scrollView.contentSize = CGSizeMake(kLineViewWidth, self.scrollView.frame.size.height);
    
    if (isNeedUpdateOffset) {
        [self scrollToLastView];
    }
    
}

- (void)scrollToLastView {
    CGFloat kLineViewWidth = _kLineModels.count * self.kLineWidth + (_kLineModels.count - 1) * self.kLineGap;
    CGFloat offset = MAX(0, kLineViewWidth - self.scrollView.bounds.size.width);
    [self.scrollView setContentOffset:CGPointMake(offset, 0) animated:NO];
    [self private_drawKLineMainViewReset];
}

- (void)private_drawKLineMainViewReset {
    NSInteger indexStart = self.scrollView.contentOffset.x / (self.kLineGap + self.kLineWidth);
    self.kLineMainView.needDrawStartIndex = indexStart;
    [self.kLineMainView drawMainView];
}

- (void)private_drawKLineAccessoryView
{
    [self.kLineAccessoryView layoutIfNeeded];
    [self.kLineAccessoryView draw];
}

- (void)changeMainChartSegmentType:(Y_StockChartTargetLineStatus )lineType {
    self.kLineMainView.targetLineStatus = lineType;
    [self private_drawKLineMainViewReset];
}

- (void)changeDeputyChartSegmentType:(Y_StockChartTargetLineStatus )lineType {
    self.kLineAccessoryView.targetLineStatus = lineType;
    self.fullScreenAccessoryInformationView.lineType = lineType;
    [self private_drawKLineAccessoryView];
}

- (void)updateAccessoryData:(Y_KLineModel *)model {
    if (model) {
        self.fullScreenAccessoryInformationView.kLineModel = model;
    }
}

#pragma mark - dealloc
- (void)dealloc {
    //移除所有监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (_scrollView) {
        [_scrollView removeObserver:self forKeyPath:Y_StockChartContentOffsetKey context:observerContext];
    }
}


@end
