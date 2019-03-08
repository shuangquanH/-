//
//  DepthModel.m
//  Exchange
//
//  Created by mengfanjun on 2018/4/27.
//  Copyright © 2018年 5th. All rights reserved.
//

#import "DepthModel.h"
#import "DepthGroupModel.h"
#import "NSString+Y_StockChart.h"

@implementation DepthModel

- (instancetype)initWithArray:(NSArray *)array
{
    self = [super init];
    if (self) {
        if (array.count == 2) {
            self.price = [NSString stringWithFormat:@"%@",array[0]];
            self.amount = [NSString stringWithFormat:@"%@",array[1]];
            self.depthAmount = self.amount;
        }
        else {
            NSLog(@"error");
        }
    }
    
    return self;
}

- (void)setPreviousDepthModel:(DepthModel *)previousDepthModel {
    _previousDepthModel = previousDepthModel;
    self.depthAmount = [NSNumber numberWithFloat:previousDepthModel.depthAmount.doubleValue + self.amount.doubleValue].stringValue;
}

#pragma mark - Getters & Setters
- (NSString *)ask_fixed {
    if (!_ask_fixed) {
        if (self.parentGroupModel.ask_fixed) {
            _ask_fixed = self.parentGroupModel.ask_fixed;
        }
    }
    return _ask_fixed;
}

- (NSString *)bid_fixed {
    if (!_bid_fixed) {
        if (self.parentGroupModel.bid_fixed) {
            _bid_fixed = self.parentGroupModel.bid_fixed;
        }
    }
    return _bid_fixed;
}

- (NSString *)formatPrice {
    if (!_formatPrice) {
        if (!self.bid_fixed) {
            return [NSString stringWithFormat:@"%@",self.price];
        }
        else {
            _formatPrice = [NSString y_stringFromValue:self.price formatterStyle:Y_NumberFormatterDigitRoundHalfUpStyle digitNumber:self.bid_fixed.intValue digitFixedNumber:-1];
        }
    }
    return _formatPrice;
}

- (NSString *)formatAmount {
    if (!_formatAmount) {
        if (!self.ask_fixed) {
            return [NSString stringWithFormat:@"%@",self.amount];
        }
        else {
            _formatAmount = [NSString y_stringFromValue:self.amount formatterStyle:Y_NumberFormatterAutoCompleteDigitStyle digitNumber:self.ask_fixed.intValue digitFixedNumber:-1];
        }
    }
    return _formatAmount;
}

- (NSString *)formatDepthAmount {
    if (!_formatDepthAmount) {
        if (!self.ask_fixed) {
            return [NSString stringWithFormat:@"%@",self.depthAmount];
        }
        else {
            _formatDepthAmount = [NSString y_stringFromValue:self.depthAmount formatterStyle:Y_NumberFormatterAutoCompleteDigitStyle digitNumber:self.ask_fixed.intValue digitFixedNumber:-1];
        }
    }
    return _formatDepthAmount;
}

@end
