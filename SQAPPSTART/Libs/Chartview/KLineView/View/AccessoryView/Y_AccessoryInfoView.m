//
//  Y_AccessoryInfoView.m
//  Exchange
//
//  Created by ly on 2018/11/2.
//  Copyright © 2018 5th. All rights reserved.
//

#import "Y_AccessoryInfoView.h"
#import "Y_KLineModel.h"
#import "UIColor+Y_StockChart.h"
#import "UIFont+Y_StockChart.h"
#import <Masonry/Masonry.h>

@implementation Y_AccessoryInfoView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubviews];
        [self addConstraints];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.accessoryLabel0];
    [self addSubview:self.accessoryLabel1];
    [self addSubview:self.accessoryLabel2];
    [self addSubview:self.accessoryLabel3];
}

- (void)addConstraints {
    __weak typeof(self) weakSelf = self;
    [self.accessoryLabel0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.mas_equalTo(5);
        make.height.mas_equalTo(10);
    }];
    
    [self.accessoryLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.accessoryLabel0.mas_right).offset(15);
        make.bottom.height.mas_equalTo(weakSelf.accessoryLabel0);
    }];
    
    [self.accessoryLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.accessoryLabel1.mas_right).offset(15);
        make.bottom.height.mas_equalTo(weakSelf.accessoryLabel0);
    }];
    
    [self.accessoryLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.accessoryLabel2.mas_right).offset(15);
        make.bottom.height.mas_equalTo(weakSelf.accessoryLabel0);
    }];
    
}

- (void)setLineType:(Y_StockChartTargetLineStatus)lineType {
    _lineType = lineType;
    if (lineType == Y_StockChartTargetLineStatusVOL) {
        self.accessoryLabel0.textColor = [UIColor KDJ_KColor];
        
        self.accessoryLabel0.text = @"";
        self.accessoryLabel1.text = @"";
        self.accessoryLabel2.text = @"";
        self.accessoryLabel3.text = @"";
    } else if (lineType == Y_StockChartTargetLineStatusMACD) {
        self.accessoryLabel0.textColor = [UIColor accessoryTitleColor];
        self.accessoryLabel1.textColor = [UIColor accessoryTitleColor];
        self.accessoryLabel2.textColor = [UIColor KDJ_KColor];
        self.accessoryLabel3.textColor = [UIColor KDJ_DColor];
        
        self.accessoryLabel0.text = @"MACD(12.26.9)";
        self.accessoryLabel1.text = @"";
        self.accessoryLabel2.text = @"";
        self.accessoryLabel3.text = @"";
    } else if (lineType == Y_StockChartTargetLineStatusKDJ) {
        self.accessoryLabel0.textColor = [UIColor accessoryTitleColor];
        self.accessoryLabel1.textColor = [UIColor KDJ_KColor];
        self.accessoryLabel2.textColor = [UIColor KDJ_DColor];
        self.accessoryLabel3.textColor = [UIColor KDJ_JColor];
        
        self.accessoryLabel0.text = @"KDJ(9.3.3)";
        self.accessoryLabel1.text = @"";
        self.accessoryLabel2.text = @"";
        self.accessoryLabel3.text = @"";
    }else if (lineType == Y_StockChartTargetLineStatusRSI) {
        self.accessoryLabel0.textColor = [UIColor KDJ_KColor];
        self.accessoryLabel1.textColor = [UIColor KDJ_DColor];
        self.accessoryLabel2.textColor = [UIColor KDJ_JColor];
        
        self.accessoryLabel0.text = @"";
        self.accessoryLabel1.text = @"";
        self.accessoryLabel2.text = @"";
        self.accessoryLabel3.text = @"";
    }
    [self resetData];
}
#pragma mark - Getters & Setters
- (UILabel *)accessoryLabel0 {
    if (!_accessoryLabel0) {
        _accessoryLabel0 = [[UILabel alloc] init];
        _accessoryLabel0.font = [UIFont y_customFontWithName:@"Europa-Regular" size:10];
    }
    return _accessoryLabel0;
}

- (UILabel *)accessoryLabel1 {
    if (!_accessoryLabel1) {
        _accessoryLabel1 = [[UILabel alloc] init];
        _accessoryLabel1.font = [UIFont y_customFontWithName:@"Europa-Regular" size:10];
    }
    return _accessoryLabel1;
}

- (UILabel *)accessoryLabel2 {
    if (!_accessoryLabel2) {
        _accessoryLabel2 = [[UILabel alloc] init];
        _accessoryLabel2.font = [UIFont y_customFontWithName:@"Europa-Regular" size:10];
    }
    return _accessoryLabel2;
}

- (UILabel *)accessoryLabel3 {
    if (!_accessoryLabel3) {
        _accessoryLabel3 = [[UILabel alloc] init];
        _accessoryLabel3.font = [UIFont y_customFontWithName:@"Europa-Regular" size:10];
    }
    return _accessoryLabel3;
}

- (void)setKLineModel:(Y_KLineModel *)kLineModel {
    _kLineModel = kLineModel;
    [self resetData];
}

- (void)resetData {
    if (!_kLineModel) {
        return;
    }
    if (self.lineType == Y_StockChartTargetLineStatusVOL) {
        self.accessoryLabel0.text = [NSString stringWithFormat:@"VOL: %@",_kLineModel.formatVolumeString];
    } else if (self.lineType == Y_StockChartTargetLineStatusMACD) {
        self.accessoryLabel1.text = [NSString stringWithFormat:@"MACD: %@",_kLineModel.formatMACDString];
        self.accessoryLabel2.text = [NSString stringWithFormat:@"DIF: %@",_kLineModel.formatDIFString];
        self.accessoryLabel3.text = [NSString stringWithFormat:@"DEA: %@",_kLineModel.formatDEAString];
    } else if (self.lineType == Y_StockChartTargetLineStatusKDJ) {
        self.accessoryLabel1.text = [NSString stringWithFormat:@"K: %@",_kLineModel.formatKDJ_KString];
        self.accessoryLabel2.text = [NSString stringWithFormat:@"D: %@",_kLineModel.formatKDJ_DString];
        self.accessoryLabel3.text = [NSString stringWithFormat:@"J: %@",_kLineModel.formatKDJ_JString];
    } else if (self.lineType == Y_StockChartTargetLineStatusRSI) {
        self.accessoryLabel0.text = [NSString stringWithFormat:@"RSI(7): %@",_kLineModel.formatRSI7String];
        self.accessoryLabel1.text = [NSString stringWithFormat:@"RSI(14): %@",_kLineModel.formatRSI14String];
        self.accessoryLabel2.text = [NSString stringWithFormat:@"RSI(28): %@",_kLineModel.formatRSI28String];
    }
}

@end
