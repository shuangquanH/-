//
//  SQHomeTopInfosView.m
//  SQAPPSTART
//
//  Created by Butry on 2019/3/9.
//  Copyright © 2019年 apple. All rights reserved.
//

#import "SQHomeTopInfosView.h"

@implementation SQHomeTopInfosView {
    UILabel *_nowMainPriceLabel;
    UILabel *_wavePrice;
    UILabel *_wavePercent;
    UILabel *_highestPrice;
    UILabel *_lowestPrice;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addViews];
        [self makeConstraints];
        [self loadData];
    }
    return self;
}

- (void)loadData {
    _nowMainPriceLabel.text = @"6700.32";
    _wavePrice.text = @"+123.23";
    _wavePercent.text = @"+3.23%";
    _highestPrice.text = @"高  6832.12";
    _lowestPrice.text = @"低  6283.98";
}


- (void)addViews {
    self.backgroundColor = KCOLOR_BLACK;
    
    _nowMainPriceLabel = [self creatLabelWithFont:KSYSFONT(18) color:KCOLOR_KUP];
    [self addSubview:_nowMainPriceLabel];
    
    _wavePrice = [self creatLabelWithFont:KSYSFONT(14) color:KCOLOR_KUP];
    [self addSubview:_wavePrice];
    
    _wavePercent = [self creatLabelWithFont:KSYSFONT(14) color:KCOLOR_KUP];
    [self addSubview:_wavePercent];
    
    _highestPrice = [self creatLabelWithFont:KSYSFONT(14) color:KCOLOR_MAIN];
    [self addSubview:_highestPrice];
    
    _lowestPrice = [self creatLabelWithFont:KSYSFONT(14) color:KCOLOR_MAIN];
    [self addSubview:_lowestPrice];
    
}

- (void)makeConstraints {
    [_nowMainPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(KMARGIN);
    }];
    [_wavePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nowMainPriceLabel);
        make.bottom.equalTo(self).offset(-KMARGIN);
    }];
    [_wavePercent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_wavePrice.mas_right).offset(KMARGIN);
        make.bottom.equalTo(self).offset(-KMARGIN);
    }];
    [_highestPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nowMainPriceLabel);
        make.right.equalTo(self).offset(-KMARGIN);
    }];
    [_lowestPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_highestPrice);
        make.bottom.equalTo(_wavePercent);
    }];
    
}

- (void)setIsFullScreen:(BOOL)isFullScreen {
    _isFullScreen = isFullScreen;
    if (!isFullScreen) {
        return;
    }
    UILabel *titleLabel = [self creatLabelWithFont:KSYSFONT(30) color:KCOLOR_MAIN];
    titleLabel.text = @"BTC/USDT";
    [self addSubview:titleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KMARGIN);
        make.centerY.equalTo(self);
    }];
    
    
    [_nowMainPriceLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLabel.mas_right).offset(KMARGIN);
        make.centerY.equalTo(self);
    }];
    
    [_wavePrice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nowMainPriceLabel.mas_right).offset(KMARGIN);
        make.centerY.equalTo(self);
    }];
    
    [_wavePercent mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_wavePrice.mas_right).offset(KMARGIN);
        make.centerY.equalTo(self);
    }];
    
    [_lowestPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-80);
        make.centerY.equalTo(self);
    }];
    
    [_highestPrice mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_lowestPrice.mas_left).offset(-KMARGIN);
        make.centerY.equalTo(self);
    }];

    
    
}

- (UILabel  *)creatLabelWithFont:(UIFont *)font color:(UIColor *)color {
    UILabel *label = [[UILabel alloc] init];
    label.font = font;
    label.textColor = color;
    return label;
}
@end
