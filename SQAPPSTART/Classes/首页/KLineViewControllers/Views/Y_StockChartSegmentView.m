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

@interface Y_StockChartSegmentView()

@property (nonatomic, strong)   UIButton        *selectedBtn;
@property (nonatomic, strong)   UIView          *selectedLine;
@property (nonatomic, strong)   UIView          *bottomLine;
@property (nonatomic, strong)   UIView          *popMoreSegment;
@property (nonatomic, strong)   UIView          *popNormSegment;


@end



@implementation Y_StockChartSegmentView {
    NSMutableArray  *buttonsArr;
    
    BOOL            showMoreSegment;
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
    }
    return self;
}


- (void)setItems:(NSArray *)items {
    if(items.count == 0 || !items) {    return; }
    _items = items;
    buttonsArr = [NSMutableArray array];
    
    for (NSString *title in items) {
        UIButton *btn = [self private_createButtonWithTitle:title];
        [self addSubview:btn];
        [buttonsArr addObject:btn];
    }
    [buttonsArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:KMARGIN tailSpacing:KMARGIN];
    UIButton    *currentButton = buttonsArr[self.selectedIndex];
    _selectedBtn = currentButton;
    currentButton.selected = YES;
    
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(currentButton);
    }];
    
    [self.selectedLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.bottom.equalTo(currentButton);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(1);
    }];
    
}


#pragma mark - 私有方法
#pragma mark 创建底部按钮
- (UIButton *)private_createButtonWithTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [btn addTarget:self action:@selector(event_segmentButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    return btn;
}

#pragma mark 底部按钮点击事件
- (void)event_segmentButtonClicked:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"更多"]||
        [btn.titleLabel.text isEqualToString:@"指标"]) {
        [self showPopSegmentWithTitle:btn.titleLabel.text];
    } else {
        
        if (showMoreSegment) {
            showMoreSegment = NO;
            
            [self.popMoreSegment mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self.selectedBtn.mas_bottom);
                make.height.mas_equalTo(0);
            }];
            [self.popNormSegment mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                make.top.equalTo(self.selectedBtn.mas_bottom);
                make.height.mas_equalTo(0);
            }];
            self.popMoreSegment.hidden = YES;
            self.popNormSegment.hidden = YES;
            
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(self.superview);
                make.height.mas_equalTo(40);
            }];
            
            [self.delegate y_StockChartSegmentView:self clickSegmentButton:btn];
        } else {
            self.selectedBtn = btn;
            [self.delegate y_StockChartSegmentView:self clickSegmentButton:btn];
        }
    }
    
}

- (void)setSelectedBtn:(UIButton *)selectedBtn {
    _selectedBtn = selectedBtn;
    for (UIButton *button in buttonsArr) {
        button.selected = NO;
    }
    selectedBtn.selected = YES;
    [UIView animateWithDuration:0.2 animations:^{
        [self.selectedLine mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.bottom.equalTo(selectedBtn);
            make.width.mas_equalTo(28);
            make.height.mas_equalTo(1);
        }];
        [self layoutIfNeeded];
    }];
    
}

- (UIView *)selectedLine {
    if (!_selectedLine) {
        _selectedLine = [[UIView alloc] init];
        _selectedLine.backgroundColor = self.selectedBtn.titleLabel.textColor;
        [self addSubview:_selectedLine];
    }
    return _selectedLine;
}
- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc] init];
        _bottomLine.backgroundColor = KCOLOR_LINE;
        [self addSubview:_bottomLine];
    }
    return _bottomLine;
}


- (void)showPopSegmentWithTitle:(NSString *)title {
    if (showMoreSegment) {
        return;
    }
    showMoreSegment = YES;
    if ([title isEqualToString:@"更多"]) {
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.superview);
            make.height.mas_equalTo(60);
        }];
        [self.popMoreSegment mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(20);
        }];
        self.popMoreSegment.hidden = NO;
        
        
    } else if ([title isEqualToString:@"指标"]) {
        
        [self mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.superview);
            make.height.mas_equalTo(80);
        }];
        [self.popNormSegment mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.mas_equalTo(40);
        }];
        self.popNormSegment.hidden = NO;
    }
}



- (UIView *)popMoreSegment {
    if (!_popMoreSegment) {
        _popMoreSegment = [[UIView alloc] init];
        [self addSubview:_popMoreSegment];
        [_popMoreSegment mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.selectedBtn.mas_bottom);
            make.height.mas_equalTo(0);
        }];
        
        
        NSArray *buttonTitleArr = @[@"1分", @"5分", @"30分", @"周线", @"1月"];
        NSMutableArray *tempArr = [NSMutableArray array];
        for (NSString *str in buttonTitleArr) {
            UIButton *btn = [self private_createButtonWithTitle:str];
            [_popMoreSegment addSubview:btn];
            [tempArr addObject:btn];
        }
        [tempArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:KMARGIN tailSpacing:KMARGIN];
        [tempArr mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_popMoreSegment);
        }];
        
    }
    return _popMoreSegment;
}

- (UIView *)popNormSegment {
    if (!_popNormSegment) {
        _popNormSegment = [[UIView alloc] init];
        [self addSubview:_popNormSegment];
        
        [_popNormSegment mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.selectedBtn.mas_bottom);
            make.height.mas_equalTo(0);
        }];
        
        
        
        UIButton *mainBtn = [self private_createButtonWithTitle:@"主图  |"];
        [_popNormSegment addSubview:mainBtn];
        
        [mainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_popNormSegment).offset(KMARGIN);
            make.top.equalTo(_popNormSegment);
            make.height.equalTo(_popNormSegment).multipliedBy(0.5);
        }];
        
        UIButton *maBtn = [self private_createButtonWithTitle:@"MA"];
        [_popNormSegment addSubview:maBtn];
        
        [maBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(mainBtn.mas_right);
            make.top.height.width.equalTo(mainBtn);
        }];
        
        UIButton *bollBtn = [self private_createButtonWithTitle:@"BOLL"];
        [_popNormSegment addSubview:bollBtn];
        
        [bollBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(maBtn.mas_right);
            make.top.height.width.equalTo(mainBtn);
        }];
        
        
        
        UIButton *subBtn = [self private_createButtonWithTitle:@"副图  |"];
        [_popNormSegment addSubview:subBtn];
        
        [subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_popNormSegment).offset(KMARGIN);
            make.bottom.equalTo(_popNormSegment);
            make.height.equalTo(_popNormSegment).multipliedBy(0.5);
        }];
        
        UIButton *macdBtn = [self private_createButtonWithTitle:@"MACD"];
        [_popNormSegment addSubview:macdBtn];
        
        [macdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(subBtn.mas_right);
            make.top.height.width.equalTo(subBtn);
        }];
        
        UIButton *kdjBtn = [self private_createButtonWithTitle:@"KDJ"];
        [_popNormSegment addSubview:kdjBtn];
        
        [kdjBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(macdBtn.mas_right);
            make.top.height.width.equalTo(subBtn);
        }];
        
        
        UIButton *rsiBtn = [self private_createButtonWithTitle:@"RSI"];
        [_popNormSegment addSubview:rsiBtn];
        
        [rsiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kdjBtn.mas_right);
            make.top.height.width.equalTo(subBtn);
        }];
        
        
        UIButton *wrBtn = [self private_createButtonWithTitle:@"WR"];
        [_popNormSegment addSubview:wrBtn];
        
        [wrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rsiBtn.mas_right);
            make.top.height.width.equalTo(subBtn);
        }];
        
    }
    return _popNormSegment;
}


@end
