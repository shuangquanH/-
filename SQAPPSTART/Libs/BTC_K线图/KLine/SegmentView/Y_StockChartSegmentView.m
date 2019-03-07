//
//  Y_StockChartSegmentView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/2.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_StockChartSegmentView.h"
#import "Masonry.h"
#import "UIColor+Y_StockChart.h"

static NSInteger const Y_StockChartSegmentStartTag = 2000;

//static CGFloat const Y_StockChartSegmentIndicatorViewHeight = 2;
//
//static CGFloat const Y_StockChartSegmentIndicatorViewWidth = 40;

@interface Y_StockChartSegmentView()

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) UIView *indicatorView;

@property (nonatomic, strong) UIButton *secondLevelSelectedBtn1;

@property (nonatomic, strong) UIButton *secondLevelSelectedBtn2;

@end

@implementation Y_StockChartSegmentView

- (instancetype)initWithItems:(NSArray *)items
{
    self = [super initWithFrame:CGRectZero];
    if(self) {
        self.items = items;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor assistBackgroundColor];
    }
    return self;
}

- (UIView *)indicatorView
{
    if(!_indicatorView)
    {
        _indicatorView = [UIView new];
        _indicatorView.backgroundColor = [UIColor assistBackgroundColor];
        [self.superview addSubview:_indicatorView];
        
        [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_bottom);
            make.height.mas_equalTo(30);
        }];
        
        
        NSArray *titleArr = @[@"MACD",@"KDJ",@"关闭",@"MA",@"EMA",@"BOLL",@"关闭"];
        NSMutableArray  *buttonArr = [NSMutableArray array];
        WeakSelf(weakSelf);
        [titleArr enumerateObjectsUsingBlock:^(NSString*  _Nonnull title, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:[UIColor mainTextColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor ma30Color] forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            btn.tag = Y_StockChartSegmentStartTag + 100 + idx;
            [btn addTarget:self action:@selector(event_segmentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:title forState:UIControlStateNormal];
            [weakSelf.indicatorView addSubview:btn];
            [buttonArr addObject:btn];
        }];
        
        UIButton *firstBtn = _indicatorView.subviews[0];
        [firstBtn setSelected:YES];
        _secondLevelSelectedBtn1 = firstBtn;
        UIButton *firstBtn2 = _indicatorView.subviews[3];
        [firstBtn2 setSelected:YES];
        _secondLevelSelectedBtn2 = firstBtn2;
        
        [buttonArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
        [buttonArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self).multipliedBy(1.0f/titleArr.count);
            make.height.equalTo(self);
        }];
        
    }
    return _indicatorView;
}

- (void)setItems:(NSArray *)items {
    _items = items;
    if(items.count == 0 || !items) {
        return;
    }
    NSInteger index = 0;
    NSInteger count = items.count;
    NSMutableArray  *buttonsArr = [NSMutableArray array];
    
    for (NSString *title in items) {
        UIButton *btn = [self private_createButtonWithTitle:title tag:Y_StockChartSegmentStartTag+index];
        [self addSubview:btn];
        [buttonsArr addObject:btn];
        index++;
    }
    [buttonsArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [buttonsArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self).multipliedBy(1.0f/count);
        make.height.equalTo(self);
    }];
}

#pragma mark 设置底部按钮index
- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    UIButton *btn = (UIButton *)[self viewWithTag:Y_StockChartSegmentStartTag + selectedIndex];
    NSAssert(btn, @"按钮初始化出错");
    [self event_segmentButtonClicked:btn];
}

- (void)setSelectedBtn:(UIButton *)selectedBtn
{
    if(_selectedBtn == selectedBtn) {
        if(selectedBtn.tag != Y_StockChartSegmentStartTag) {
            return;
        }
    }
    
    if(selectedBtn.tag >= 2100 && selectedBtn.tag < 2103) {
        [_secondLevelSelectedBtn1 setSelected:NO];
        [selectedBtn setSelected:YES];
        _secondLevelSelectedBtn1 = selectedBtn;
        
    } else if(selectedBtn.tag >= 2103) {
        [_secondLevelSelectedBtn2 setSelected:NO];
        [selectedBtn setSelected:YES];
        _secondLevelSelectedBtn2 = selectedBtn;
        
    } else if(selectedBtn.tag < Y_StockChartSegmentStartTag+self.items.count-2){
        [_selectedBtn setSelected:NO];
        [selectedBtn setSelected:YES];
        _selectedBtn = selectedBtn;
    }

    _selectedIndex = selectedBtn.tag - Y_StockChartSegmentStartTag;
    
    /** 点击第一个按钮，弹出更多指标  */
    if(_selectedIndex == self.items.count-2 || _selectedIndex == self.items.count-1) {
        [UIView animateWithDuration:0.2f animations:^{
            self.indicatorView.hidden = NO;
            [self.superview bringSubviewToFront:self.indicatorView];
        }];
    } else {
        [UIView animateWithDuration:0.2f animations:^{
            self.indicatorView.hidden = YES;
        }];
    }
}

#pragma mark - 私有方法
#pragma mark 创建底部按钮
- (UIButton *)private_createButtonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor ma30Color] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.tag = tag;
    [btn addTarget:self action:@selector(event_segmentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

#pragma mark 底部按钮点击事件
- (void)event_segmentButtonClicked:(UIButton *)btn
{
    self.selectedBtn = btn;
    if (btn.tag==Y_StockChartSegmentStartTag+self.items.count-2||
        btn.tag==Y_StockChartSegmentStartTag+self.items.count-1) {
        return;
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(y_StockChartSegmentView:clickSegmentButtonIndex:)])
    {
        [self.delegate y_StockChartSegmentView:self clickSegmentButtonIndex: btn.tag-Y_StockChartSegmentStartTag];
    }
}

@end
