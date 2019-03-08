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

@interface Y_StockChartSegmentView()

@property (nonatomic, strong)   UIButton        *selectedBtn;

@end



@implementation Y_StockChartSegmentView {
    NSMutableArray  *buttonsArr;
}

- (instancetype)initWithItems:(NSArray *)items {
    self = [super initWithFrame:CGRectZero];
    if(self) {
        self.items = items;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor assistBackgroundColor];
    }
    return self;
}


- (void)setItems:(NSArray *)items {
    _items = items;
    if(items.count == 0 || !items) {
        return;
    }
    NSInteger index = 0;
    NSInteger count = items.count;
    buttonsArr = [NSMutableArray array];
    
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
    ((UIButton *)(buttonsArr[self.selectedIndex])).selected = YES;
}


#pragma mark - 私有方法
#pragma mark 创建底部按钮
- (UIButton *)private_createButtonWithTitle:(NSString *)title tag:(NSInteger)tag
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.tag = tag;
    [btn addTarget:self action:@selector(event_segmentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

#pragma mark 底部按钮点击事件
- (void)event_segmentButtonClicked:(UIButton *)btn {
    self.selectedBtn = btn;
    if(self.delegate && [self.delegate respondsToSelector:@selector(y_StockChartSegmentView:clickSegmentButtonIndex:)]) {
        [self.delegate y_StockChartSegmentView:self clickSegmentButtonIndex: btn.tag-Y_StockChartSegmentStartTag];
    }
}

- (void)setSelectedBtn:(UIButton *)selectedBtn {
    _selectedBtn = selectedBtn;
    for (UIButton *button in buttonsArr) {
        button.selected = NO;
    }
    selectedBtn.selected = YES;
}

@end
