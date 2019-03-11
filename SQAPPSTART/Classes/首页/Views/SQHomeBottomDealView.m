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
    
    upPresent = [self creatLabelWithFont:KSYSFONT(9) color:KCOLOR_WHIT];
    [self addSubview:upPresent];
    
    lowPresent = [self creatLabelWithFont:KSYSFONT(9) color:KCOLOR_WHIT];
    [self addSubview:lowPresent];
    
    buyButton = [self creatButtonWithBackColor:KCOLOR_KUP font:KSYSFONT(18) title:@"买涨"];
    sellButton = [self creatButtonWithBackColor:KCOLOR_KLOW font:KSYSFONT(18) title:@"买跌"];
    [self addSubview:buyButton];
    [self addSubview:sellButton];
    
    canUseMoney = [self creatLabelWithFont:KSYSFONT(18) color:KCOLOR_BLACK];
    [self addSubview:canUseMoney];
    
    
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
        make.width.mas_equalTo(80);
        make.height.equalTo(maiLow);
    }];
    
    [maiUp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.equalTo(maiLow);
        make.right.equalTo(upPresent.mas_left).offset(-KMARGIN);
    }];
    
    [buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(KMARGIN);
        make.right.equalTo(sellButton.mas_left).offset(-KMARGIN);
        make.height.mas_equalTo(40);
    }];
    
    [sellButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-KMARGIN);
        make.top.width.height.equalTo(buyButton);
    }];
    
    [canUseMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(-KMARGIN);
        
    }];
    
    
}

- (void)addDatas {
    todayPan.text = @"今日盘面";
    maiUp.text = @"买涨";
    maiLow.text = @"买跌";
    upPresent.backgroundColor = KCOLOR_KLOW;
    lowPresent.backgroundColor = KCOLOR_KUP;
    upPresent.textAlignment = NSTextAlignmentCenter;
    lowPresent.textAlignment = NSTextAlignmentCenter;
    upPresent.text = @"58.0%";
    lowPresent.text = @"42.0%";
    
    canUseMoney.text = @"可用余额(USDT)：23.32  充值";

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
