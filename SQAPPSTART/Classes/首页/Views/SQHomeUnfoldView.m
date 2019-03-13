//
//  SQHomeUnfoldView.m
//  SQAPPSTART
//
//  Created by Butry on 2019/3/11.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "SQHomeUnfoldView.h"

@implementation SQHomeUnfoldView {
    UIView      *bottomLine;
    UIButton    *unfoldButton;
    
    UILabel     *totalWinOrLoss;
    UILabel     *winOrLossCount;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
        [self makeConstraints];
        [self addDatas];
    }
    return self;
}

- (void)addViews {
    self.backgroundColor = KCOLOR_WHIT;
    
    bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = KCOLOR_LINE;
    [self addSubview:bottomLine];
    
    unfoldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:unfoldButton];
    unfoldButton.backgroundColor = KCOLOR_LINE;
    [unfoldButton setTitle:@"展开" forState:UIControlStateNormal];
    [unfoldButton setTitle:@"点击收起" forState:UIControlStateSelected];
    [unfoldButton setTintColor:KCOLOR_BLACK];
    [unfoldButton addTarget:self action:@selector(openUnfoldInfos:) forControlEvents:UIControlEventTouchUpInside];
    
    totalWinOrLoss =  [self creatLabelWithFont:KSYSFONT(16) color:KCOLOR_BLACK];
    [self addSubview:totalWinOrLoss];
    
    winOrLossCount = [self creatLabelWithFont:KSYSFONT(13) color:KCOLOR_BLACK];
    [self addSubview:winOrLossCount];
    
    
}
- (void)makeConstraints {
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(1);
    }];
    
    [unfoldButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(20);
    }];


    [totalWinOrLoss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(KMARGIN);
    }];

    [winOrLossCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(totalWinOrLoss);
        make.right.equalTo(self).offset(-KMARGIN);
    }];
    
}

- (void)addDatas {
    totalWinOrLoss.text = @"总盈亏(USDT)";
    winOrLossCount.text = @"+1000.00 (约￥296.32)";
}

- (void)openUnfoldInfos:(UIButton   *)sender {
    sender.selected = !sender.selected;
    
    [UIView animateWithDuration:0.3 animations:^{
        if (sender.selected) {
            self.frame = CGRectMake(0, KAPP_HEIGHT-kBottomDealViewH-kUnfoldViewH, KAPP_WIDTH, kBottomDealViewH+kUnfoldViewH);
        } else {
            self.frame = CGRectMake(0, KAPP_HEIGHT-kUnfoldViewH, KAPP_WIDTH, kUnfoldViewH);
        }
    }];
}








- (UILabel  *)creatLabelWithFont:(UIFont *)font color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = color;
    return label;
}



@end
