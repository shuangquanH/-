//
//  SQHomeBottomDealView.m
//  SQAPPSTART
//
//  Created by Butry on 2019/3/9.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "SQHomeBottomDealView.h"

@implementation SQHomeBottomDealView {
    
    UILabel *todayPan;
    UILabel *maiUp;
    UILabel *maiLow;
    UILabel *upPresent;
    UILabel *lowPresent;
    UIButton    *buyButton;
    UIButton    *sellButton;
    
    UILabel     *canUseMoney;
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
    todayPan = [self creatLabelWithFont:KSYSFONT(14) color:KCOLOR_BLACK];
    [self addSubview:todayPan];
    
    maiUp = [self creatLabelWithFont:KSYSFONT(14) color:KCOLOR_BLACK];
    [self addSubview:maiUp];
    
    maiLow = [self creatLabelWithFont:KSYSFONT(14) color:KCOLOR_BLACK];
    [self addSubview:maiLow];
    
    upPresent = [self creatLabelWithFont:KSYSFONT(9) color:KCOLOR_LINE];
    [self addSubview:upPresent];
    
    lowPresent = [self creatLabelWithFont:KSYSFONT(9) color:KCOLOR_LINE];
    [self addSubview:lowPresent];
    
    buyButton = [self creatButtonWithBackColor:KCOLOR_KUP font:KSYSFONT(18) title:@"买涨"];
    sellButton = [self creatButtonWithBackColor:KCOLOR_KLOW font:KSYSFONT(18) title:@"买跌"];
    [self addSubview:buyButton];
    [self addSubview:sellButton];
    
    canUseMoney = [self creatLabelWithFont:KSYSFONT(18) color:KCOLOR_BLACK];
    [self addSubview:canUseMoney];
    
    bottomLine = [[UIView alloc] init];
    bottomLine.backgroundColor = KCOLOR_LINE;
    [self addSubview:bottomLine];
    
    unfoldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:unfoldButton];
    unfoldButton.backgroundColor = KCOLOR_LINE;
    [unfoldButton setTitle:@"展开" forState:UIControlStateNormal];
    [unfoldButton setTintColor:KCOLOR_BLACK];
    
    totalWinOrLoss =  [self creatLabelWithFont:KSYSFONT(16) color:KCOLOR_BLACK];
    [self addSubview:totalWinOrLoss];
    
    winOrLossCount = [self creatLabelWithFont:KSYSFONT(13) color:KCOLOR_BLACK];
    [self addSubview:winOrLossCount];
    
    
}
- (void)makeConstraints {
    [todayPan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(KMARGIN);
    }];
    
    [maiLow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(KMARGIN);
        make.right.equalTo(self).offset(-KMARGIN);
    }];
    
    [lowPresent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maiLow);
        make.right.equalTo(maiLow.mas_left).offset(-KMARGIN);
        make.width.mas_equalTo(60);
        make.height.equalTo(maiLow);
    }];
    
    [upPresent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maiLow);
        make.right.equalTo(lowPresent.mas_left);
        make.width.mas_equalTo(60);
        make.height.equalTo(maiLow);
    }];
    
    [maiUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(maiLow);
        make.right.equalTo(upPresent.mas_left).offset(-KMARGIN);
    }];
    
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(maiUp.mas_bottom).offset(KMARGIN*2);
        make.height.mas_equalTo(40);
        make.left.equalTo(self).offset(KMARGIN);
        make.right.equalTo(sellButton.mas_left).offset(-KMARGIN);
    }];
    
    [sellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-KMARGIN);
        make.top.width.height.equalTo(buyButton);
    }];
    
    [canUseMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(buyButton.mas_bottom).offset(KMARGIN);
        
    }];
    
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.mas_equalTo(1);
        make.top.equalTo(canUseMoney.mas_bottom).offset(KMARGIN);
    }];
    
    [unfoldButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(bottomLine);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    
    [totalWinOrLoss mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self).offset(-KMARGIN*2);
        make.left.equalTo(self).offset(KMARGIN);
    }];
    
    [winOrLossCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(totalWinOrLoss);
        make.right.equalTo(self).offset(-KMARGIN);
    }];
}

- (void)addDatas {
//    UILabel *todayPan;
//    UILabel *maiUp;
//    UILabel *maiLow;
//    UILabel *upPresent;
//    UILabel *lowPresent;
//    UIButton    *buyButton;
//    UIButton    *sellButton;
    
    todayPan.text = @"今日盘面";
    maiUp.text = @"买涨";
    maiLow.text = @"买跌";
    upPresent.backgroundColor = KCOLOR_KLOW;
    lowPresent.backgroundColor = KCOLOR_KUP;
    lowPresent.textAlignment = NSTextAlignmentRight;
    upPresent.textAlignment = NSTextAlignmentLeft;
    upPresent.text = @" 50.0%";
    lowPresent.text = @"50.0% ";
    
    canUseMoney.text = @"可用余额(USDT)：23.32  充值";
    totalWinOrLoss.text = @"总盈亏(USDT)";
    winOrLossCount.text = @"+1000.00 (约￥296.32)";
}



- (UILabel  *)creatLabelWithFont:(UIFont *)font color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = color;
    return label;
}


- (UIButton *)creatButtonWithBackColor:(UIColor *)color font:(UIFont *)font title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = color;
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = font;
    return button;
}
@end
