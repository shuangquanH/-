//
//  Y_YAxisView.h
//  Exchange
//
//  Created by mengfanjun on 2018/5/29.
//  Copyright © 2018年 5th. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Y_YAxisView : UIView

- (void)setLineCount:(NSInteger)verticalCount maxPrice:(CGFloat )maxPrice minPrice:(CGFloat )minPrice;

- (void)getStopLossPrice:(CGFloat)lossPrice stopProfitPrice:(CGFloat)profitPrice;

@property (nonatomic, copy) NSString *ask_fixed;
@property (nonatomic, copy) NSString *bid_fixed;

@end
