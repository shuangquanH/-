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
    
    
    NSMutableArray  *mainAcessBtnArr;//主图技术图形按钮数组
    NSMutableArray  *subAcessBtnArr;//副图技术图形按钮数组
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
            
            //置灰所有按钮，只显示选中的那一个
            if ([mainAcessBtnArr containsObject:btn]) {
                for (UIButton *temp in mainAcessBtnArr) {
                    temp.selected = NO;
                }
                if (![btn.titleLabel.text containsString:@"隐藏"]) {
                    btn.selected = YES;
                }
            }
            
            if ([subAcessBtnArr containsObject:btn]) {
                for (UIButton *temp in subAcessBtnArr) {
                    temp.selected = NO;
                }
                if (![btn.titleLabel.text containsString:@"隐藏"]) {
                    btn.selected = YES;
                }
            }
            
            [self closePopSegmentView];
        }
        
        
        if ([self.items containsObject:btn.titleLabel.text]) {
            self.selectedBtn = btn;
            [self.delegate y_StockChartSegmentView:self clickSegmentButton:btn];
        } else {
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
            make.bottom.centerX.equalTo(selectedBtn);
            make.width.mas_equalTo(28);
            make.height.mas_equalTo(1);
        }];
        [self layoutIfNeeded];
    }];
    
}
- (void)closePopSegmentView {
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
    }];
    [self.popMoreSegment mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    
    [self.popNormSegment mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(0);
    }];
    [self layoutIfNeeded];
    self.popMoreSegment.hidden = YES;
    self.popNormSegment.hidden = YES;
}


- (void)showPopSegmentWithTitle:(NSString *)title {
    showMoreSegment = YES;
    
    if ([title isEqualToString:@"更多"]) {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(60);
        }];
        [self.popMoreSegment mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
        }];
        self.popMoreSegment.hidden = NO;
        
        self.popNormSegment.hidden = YES;
        [self.popNormSegment mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
        
    } else if ([title isEqualToString:@"指标"]) {
        
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(80);
        }];
        [self.popNormSegment mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(40);
        }];
        self.popNormSegment.hidden = NO;
        
        self.popMoreSegment.hidden = YES;
        [self.popMoreSegment mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        
    }
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




- (UIView *)popMoreSegment {
    if (!_popMoreSegment) {
        _popMoreSegment = [[UIView alloc] init];
        [self addSubview:_popMoreSegment];
        [_popMoreSegment mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
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
        mainAcessBtnArr = [NSMutableArray array];
        subAcessBtnArr = [NSMutableArray array];
        
        [_popNormSegment mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
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
        maBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_popNormSegment addSubview:maBtn];
        
        [maBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(mainBtn.mas_right).offset(KMARGIN);
            make.top.height.width.equalTo(mainBtn);
        }];
        
        UIButton *bollBtn = [self private_createButtonWithTitle:@"BOLL"];
        bollBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_popNormSegment addSubview:bollBtn];
        
        [bollBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(maBtn.mas_right).offset(KMARGIN);;
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
        macdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_popNormSegment addSubview:macdBtn];
        
        [macdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(subBtn.mas_right).offset(KMARGIN);
            make.top.height.width.equalTo(subBtn);
        }];
        
        UIButton *kdjBtn = [self private_createButtonWithTitle:@"KDJ"];
        kdjBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_popNormSegment addSubview:kdjBtn];
        
        [kdjBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(macdBtn.mas_right).offset(KMARGIN);;
            make.top.height.width.equalTo(subBtn);
        }];
        
        
        UIButton *rsiBtn = [self private_createButtonWithTitle:@"RSI"];
        rsiBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_popNormSegment addSubview:rsiBtn];
        
        [rsiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(kdjBtn.mas_right).offset(KMARGIN);;
            make.top.height.width.equalTo(subBtn);
        }];
        
        
        UIButton *wrBtn = [self private_createButtonWithTitle:@"WR"];
        wrBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_popNormSegment addSubview:wrBtn];
        
        [wrBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(rsiBtn.mas_right).offset(KMARGIN);;
            make.top.height.width.equalTo(subBtn);
        }];
        
        
        
        UIButton *hiddenMainBtn = [self private_createButtonWithTitle:@"隐藏"];
        [_popNormSegment addSubview:hiddenMainBtn];
        [hiddenMainBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_popNormSegment).offset(-KMARGIN);
            make.centerY.equalTo(mainBtn);
        }];
        
        
        UIButton *hiddenSubBtn = [self private_createButtonWithTitle:@" 隐藏"];
        [_popNormSegment addSubview:hiddenSubBtn];
        [hiddenSubBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(_popNormSegment).offset(-KMARGIN);
            make.centerY.equalTo(subBtn);
        }];
        
        
        [mainAcessBtnArr addObjectsFromArray:@[maBtn, bollBtn, hiddenMainBtn]];
        [subAcessBtnArr addObjectsFromArray:@[macdBtn, kdjBtn, rsiBtn, wrBtn, hiddenSubBtn]];
        
        
    }
    return _popNormSegment;
}


@end
