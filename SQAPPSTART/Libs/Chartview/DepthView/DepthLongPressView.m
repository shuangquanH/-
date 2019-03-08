//
//  DepthLongPressView.m
//  Exchange
//
//  Created by mengfanjun on 2018/6/5.
//  Copyright © 2018年 5th. All rights reserved.
//

#import "DepthLongPressView.h"
#import "DepthModel.h"
#import "DepthChartView.h"
#import <Masonry/Masonry.h>
#import "UIColor+Y_StockChart.h"
#import "UIFont+Y_StockChart.h"

@implementation DepthLongPressView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addSubviews];
        [self addConstraints];
    }
    return self;
}

- (void)addSubviews {
    [self addSubview:self.verticalView];
    [self addSubview:self.horizontalView];
    [self addSubview:self.verticalLabel];
    [self addSubview:self.horizontalLabel];
}

- (void)addConstraints {
    __weak typeof(self) weakSelf = self;
    [self.verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.width.equalTo(@(0.5));
        make.height.equalTo(weakSelf);
        make.left.equalTo(@(0));
    }];
    
    [self.verticalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf);
        make.height.equalTo(@(24));
        make.centerX.equalTo(self.mas_left).offset(0);
//        make.width.equalTo(@(0));
    }];
    
    [self.horizontalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(weakSelf);
        make.height.equalTo(@(0.5));
        make.top.equalTo(@(0));
    }];
    
    [self.horizontalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_top).offset(0);
        make.left.equalTo(@(0));
        make.height.equalTo(@(24));
//        make.width.equalTo(@(0));
    }];
}

#pragma mark - Getters & Setters
- (UIView *)verticalView {
    if (!_verticalView) {
        _verticalView = [[UIView alloc] init];
        _verticalView.backgroundColor = [UIColor y_colorWithHexString:@"9AADC0"];
    }
    return _verticalView;
}

- (UILabel *)verticalLabel {
    if (!_verticalLabel) {
        _verticalLabel = [[UILabel alloc] init];
        _verticalLabel.font = [UIFont y_customFontWithName:@"DIN-Regular" size:12];
        _verticalLabel.textColor = [UIColor y_colorWithHexString:@"111111" alpha:0.5];
        _verticalLabel.layer.cornerRadius = 3;
        _verticalLabel.layer.borderWidth = 0.5;
        _verticalLabel.layer.borderColor = [UIColor y_colorWithHexString:@"becac8"].CGColor;
        _verticalLabel.textAlignment = NSTextAlignmentCenter;
        _verticalLabel.backgroundColor = [UIColor whiteColor];
    }
    return _verticalLabel;
}

- (UIView *)horizontalView {
    if (!_horizontalView) {
        _horizontalView = [[UIView alloc] init];
        _horizontalView.backgroundColor = [UIColor y_colorWithHexString:@"9AADC0"];
    }
    return _horizontalView;
}

- (UILabel *)horizontalLabel {
    if (!_horizontalLabel) {
        _horizontalLabel = [[UILabel alloc] init];
        _horizontalLabel.font = [UIFont y_customFontWithName:@"DIN-Regular" size:12];
        _horizontalLabel.textColor = [UIColor y_colorWithHexString:@"111111" alpha:0.5];
        _horizontalLabel.layer.cornerRadius = 3;
        _horizontalLabel.layer.borderWidth = 0.5;
        _horizontalLabel.layer.borderColor = [UIColor y_colorWithHexString:@"becac8"].CGColor;
        _horizontalLabel.textAlignment = NSTextAlignmentCenter;
        _horizontalLabel.backgroundColor = [UIColor whiteColor];
    }
    return _horizontalLabel;
}

- (void)setDepthModel:(DepthModel *)depthModel {
    _depthModel = depthModel;

    [self.verticalView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(depthModel.positionPoint.x));
    }];
    
    CGFloat verticalWidth = [[NSString stringWithFormat:@"%@",depthModel.formatPrice] sizeWithAttributes:@{NSFontAttributeName:[UIFont y_customFontWithName:@"Europa-Regular" size:12]}].width + 20;
    
    if (depthModel.positionPoint.x < verticalWidth / 2) {
        [self.verticalLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_left).offset(verticalWidth / 2);
            make.width.equalTo(@(verticalWidth));
        }];
    }
    else if ((self.frame.size.width * PriceScale - depthModel.positionPoint.x) < verticalWidth / 2) {
        [self.verticalLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_left).offset(self.frame.size.width * PriceScale - verticalWidth / 2);
            make.width.equalTo(@(verticalWidth));
        }];
    }
    else {
        [self.verticalLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_left).offset(depthModel.positionPoint.x);
            make.width.equalTo(@(verticalWidth));
        }];
    }

    [self.horizontalView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(depthModel.positionPoint.y + (self.frame.size.height - 16) * (1 - AmountScale)));
    }];
    
    CGFloat horizontalWidth = [[NSString stringWithFormat:@"%@",depthModel.formatDepthAmount] sizeWithAttributes:@{NSFontAttributeName:[UIFont y_customFontWithName:@"Europa-Regular" size:12]}].width + 20;
    
    if (((self.frame.size.height - 16) * AmountScale) < depthModel.positionPoint.y) {
        [self.horizontalLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_top).offset((self.frame.size.height - 16) - self.horizontalLabel.frame.size.height / 2);
            make.width.equalTo(@(horizontalWidth));
        }];
    }
    else {
        [self.horizontalLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_top).offset(depthModel.positionPoint.y + (self.frame.size.height - 16) * (1 - AmountScale));
            make.width.equalTo(@(horizontalWidth));
        }];
    }
    
    self.verticalLabel.text = [NSString stringWithFormat:@"%@",depthModel.formatPrice];
    self.horizontalLabel.text = [NSString stringWithFormat:@"%@",depthModel.formatDepthAmount];
    
    [self layoutIfNeeded];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
