//
//  DepthGroupModel.m
//  Exchange
//
//  Created by mengfanjun on 2018/4/27.
//  Copyright © 2018年 5th. All rights reserved.
//

#import "DepthGroupModel.h"
#import "DepthModel.h"
#import "NSNumber+Y_ChartView.h"
//#import <YYKit/NSNumber+YYAdd.h>

@interface DepthGroupModel ()

@end

@implementation DepthGroupModel

- (instancetype)initWithBidsArray:(NSArray *)bidsArray asksArray:(NSArray *)asksArray {
    self = [super init];
    
    if (self) {
        DepthModel *bidsPreviousKlineModel = [[DepthModel alloc] initWithArray:@[@0,@0]];
        CGFloat maxBuyAmount = 0.0;
        for (int i = 0; i < bidsArray.count; i++) {
            NSArray *depthArray = bidsArray[i];
            DepthModel *depthModel = [[DepthModel alloc] initWithArray:depthArray];
            depthModel.parentGroupModel = self;
            [self.bidsArray addObject:depthModel];
            depthModel.previousDepthModel = bidsPreviousKlineModel;
            bidsPreviousKlineModel = depthModel;
            if (i == 0) {
                maxBuyAmount = depthModel.amount.floatValue;
            }
            else {
                maxBuyAmount = maxBuyAmount > depthModel.amount.floatValue ? maxBuyAmount : depthModel.amount.floatValue;
            }
        }
        self.maxBuyAmount = [NSNumber numberWithFloat:maxBuyAmount];
       
        CGFloat maxSellAmount = 0.0;
        DepthModel *asksPreviousKlineModel = [[DepthModel alloc] initWithArray:@[@0,@0]];
        for (int i = 0; i < asksArray.count; i++) {
            NSArray *depthArray = asksArray[i];
            DepthModel *depthModel = [[DepthModel alloc] initWithArray:depthArray];
            depthModel.parentGroupModel = self;
            [self.asksArray addObject:depthModel];
            depthModel.previousDepthModel = asksPreviousKlineModel;
            asksPreviousKlineModel = depthModel;
            if (i == 0) {
                maxSellAmount = depthModel.amount.floatValue;
            }
            else {
                maxSellAmount = maxSellAmount > depthModel.amount.floatValue ? maxSellAmount : depthModel.amount.floatValue;
            }
        }
        self.maxSellAmount = [NSNumber numberWithFloat:maxSellAmount];
        
        if (self.bidsArray.count > 0) {
            DepthModel *tempModel = [self.bidsArray firstObject];
            self.currentPrice = [NSNumber numberWithFloat:tempModel.price.floatValue];
        } else if (self.asksArray.count > 0) {
            DepthModel *tempModel = [self.asksArray firstObject];
            self.currentPrice = [NSNumber numberWithFloat:tempModel.price.floatValue];
        }
    }
    return self;
}

#pragma mark - Getters & Setters
//买
- (NSMutableArray *)bidsArray {
    if (!_bidsArray) {
        _bidsArray = [NSMutableArray array];
    }
    return _bidsArray;
}

//卖
- (NSMutableArray *)asksArray {
    if (!_asksArray) {
        _asksArray = [NSMutableArray array];
    }
    return _asksArray;
}

- (NSMutableArray *)showBidsArray {
    if (!_showBidsArray) {
        _showBidsArray = [NSMutableArray array];
    }
    return _showBidsArray;
}

- (NSMutableArray *)showAsksArray {
    if (!_showAsksArray) {
        _showAsksArray = [NSMutableArray array];
    }
    return _showAsksArray;
}

- (NSNumber *)maxPrice {
    if (!_maxPrice) {
        DepthModel *lastAsksDepthModel = [self.asksArray lastObject];
        if (!lastAsksDepthModel) {
            return nil;
        }
        else {
            _maxPrice = [NSNumber y_numberWithString:lastAsksDepthModel.price];
        }
    }
    return _maxPrice;
}

- (NSNumber *)minPrice {
    if (!_minPrice) {
        DepthModel *lastBidsDepthModel = [self.bidsArray lastObject];
        if (!lastBidsDepthModel) {
            return nil;
        }
        else {
            _minPrice = [NSNumber y_numberWithString:lastBidsDepthModel.price];
        }
    }
    return _minPrice;
}

- (NSNumber *)maxDepthAmount {
    if (!_maxDepthAmount) {
        DepthModel *lastAsksDepthModel = [self.asksArray lastObject];
        DepthModel *lastBidsDepthModel = [self.bidsArray lastObject];
        NSNumber *lastAsksDepthAmout = @0;
        NSNumber *lastBidsDepthAmount = @0;
        if (lastAsksDepthModel) {
            NSNumber *num = [NSNumber y_numberWithString:lastAsksDepthModel.depthAmount];
            if (num) {
                lastAsksDepthAmout = num;
            }
        }
        if (lastBidsDepthModel) {
            NSNumber *num = [NSNumber y_numberWithString:lastBidsDepthModel.depthAmount];
            if (num) {
                lastBidsDepthAmount = num;
            }
        }
        switch ([lastAsksDepthAmout compare:lastBidsDepthAmount]) {
            case NSOrderedAscending:
                //升序
                _maxDepthAmount = lastBidsDepthAmount;
                break;
            case NSOrderedSame:
                //相等
                _maxDepthAmount = lastAsksDepthAmout;
                break;
            case NSOrderedDescending:
                //降序
                _maxDepthAmount = lastAsksDepthAmout;
                break;
            default:
                break;
        }
    }
    return _maxDepthAmount;
}

- (NSNumber *)minDepthAmount {
    if (!_minDepthAmount) {
        DepthModel *firstAsksDepthModel = [self.asksArray firstObject];
        DepthModel *firstBidsDepthModel = [self.bidsArray firstObject];
        NSNumber *firstAsksDepthAmout = @0;
        NSNumber *firstBidsDepthAmount = @0;
        if (firstAsksDepthModel) {
            NSNumber *num = [NSNumber y_numberWithString:firstAsksDepthModel.depthAmount];
            if (num) {
                firstAsksDepthAmout = num;
            }
        }
        if (firstBidsDepthModel) {
            NSNumber *num = [NSNumber y_numberWithString:firstBidsDepthModel.depthAmount];
            if (num) {
                firstBidsDepthAmount = num;
            }
        }
        switch ([firstAsksDepthAmout compare:firstBidsDepthAmount]) {
            case NSOrderedAscending:
                //升序
                _minDepthAmount = firstAsksDepthAmout;
                break;
            case NSOrderedSame:
                //相等
                _minDepthAmount = firstAsksDepthAmout;
                break;
            case NSOrderedDescending:
                //降序
                _minDepthAmount = firstBidsDepthAmount;
                break;
            default:
                break;
        }
    }
    return _minDepthAmount;
}

- (NSNumber *)showMaxPrice {
    if (!_showMaxPrice) {
        DepthModel *lastShowAsksDepthModel = [self.showAsksArray lastObject];
        if (!lastShowAsksDepthModel) {
            return nil;
        }
        else {
            _showMaxPrice = [NSNumber y_numberWithString:lastShowAsksDepthModel.price];
        }
    }
    return _showMaxPrice;
}

- (NSNumber *)showMinPrice {
    if (!_showMinPrice) {
        DepthModel *lastShowBidsDepthModel = [self.showBidsArray lastObject];
        if (!lastShowBidsDepthModel) {
            return nil;
        }
        else {
            _showMinPrice = [NSNumber y_numberWithString:lastShowBidsDepthModel.price];
        }
    }
    return _showMinPrice;
}

- (NSNumber *)showMaxDepthAmount {
    if (!_showMaxDepthAmount) {
        DepthModel *lastShowAsksDepthModel = [self.showAsksArray lastObject];
        DepthModel *lastShowBidsDepthModel = [self.showBidsArray lastObject];
        NSNumber *lastShowAsksDepthAmout = @0;
        NSNumber *lastShowBidsDepthAmount = @0;
        if (lastShowAsksDepthModel) {
            NSNumber *num = [NSNumber y_numberWithString:lastShowAsksDepthModel.depthAmount];
            if (num) {
                lastShowAsksDepthAmout = num;
            }
        }
        if (lastShowBidsDepthModel) {
            NSNumber *num = [NSNumber y_numberWithString:lastShowBidsDepthModel.depthAmount];
            if (num) {
                lastShowBidsDepthAmount = num;
            }
        }
        switch ([lastShowAsksDepthAmout compare:lastShowBidsDepthAmount]) {
            case NSOrderedAscending:
                //升序
                _showMaxDepthAmount = lastShowBidsDepthAmount;
                break;
            case NSOrderedSame:
                //相等
                _showMaxDepthAmount = lastShowAsksDepthAmout;
                break;
            case NSOrderedDescending:
                //降序
                _showMaxDepthAmount = lastShowAsksDepthAmout;
                break;
            default:
                break;
        }
    }
    return _showMaxDepthAmount;
}

- (NSNumber *)showMinDepthAmount {
    if (!_showMinDepthAmount) {
        DepthModel *firstShowAsksDepthModel = [self.showAsksArray firstObject];
        DepthModel *firstShowBidsDepthModel = [self.showBidsArray firstObject];
        NSNumber *firstShowAsksDepthAmout = @0;
        NSNumber *firstShowBidsDepthAmount = @0;
        
        if (firstShowAsksDepthModel && firstShowAsksDepthModel.depthAmount.length) {
            NSNumber *num = [NSNumber y_numberWithString:firstShowAsksDepthModel.depthAmount];
            if (num) {
                firstShowAsksDepthAmout = num;
            }
        }
        if (firstShowBidsDepthModel  && firstShowBidsDepthModel.depthAmount.length) {
            NSNumber *num = [NSNumber y_numberWithString:firstShowBidsDepthModel.depthAmount];
            if (num) {
                firstShowBidsDepthAmount = num;
            }
        }
        switch ([firstShowAsksDepthAmout compare:firstShowBidsDepthAmount]) {
            case NSOrderedAscending:
                //升序
                _showMinDepthAmount = firstShowAsksDepthAmout;
                break;
            case NSOrderedSame:
                //相等
                _showMinDepthAmount = firstShowAsksDepthAmout;
                break;
            case NSOrderedDescending:
                //降序
                _showMinDepthAmount = firstShowBidsDepthAmount;
                break;
            default:
                break;
        }
    }
    return _showMinDepthAmount;
}

- (void)setCurrentPrice:(NSNumber *)currentPrice {
    _currentPrice = currentPrice;
    
    if (self.minPrice.doubleValue == 0 && self.maxPrice.doubleValue != 0) {
        CGFloat maxDistance = ABS(currentPrice.doubleValue - self.maxPrice.doubleValue);
        self.minPrice = [NSNumber numberWithDouble:currentPrice.doubleValue - maxDistance];
        if (self.minPrice.floatValue < 0) {
            self.minPrice = [NSNumber numberWithInt:0];
        }
        self.showMinPrice = self.minPrice;
    }
    if (self.maxPrice.doubleValue == 0 && self.minPrice.doubleValue != 0) {
        CGFloat minDistance = ABS(currentPrice.doubleValue - self.minPrice.doubleValue);
        self.maxPrice = [NSNumber numberWithDouble:currentPrice.doubleValue + minDistance];
        self.showMaxPrice = self.maxPrice;
    }
    
    CGFloat minPrice = self.minPrice.doubleValue;
    CGFloat maxPrice = self.maxPrice.doubleValue;
    
    CGFloat minDistance = ABS(currentPrice.doubleValue - minPrice);
    CGFloat maxDistance = ABS(currentPrice.doubleValue - maxPrice);
    
    [self.showAsksArray removeAllObjects];
    [self.showBidsArray removeAllObjects];
    if (minDistance < maxDistance) {
        //深度图左边买单价格离中心点更近，取左边买单全部数据，取右边卖单数据对称价格数据
        
        //取左边买单全部数据
        [self.showBidsArray addObjectsFromArray:self.bidsArray];
        
        //对称价格
        CGFloat symmetryMaxPrice = currentPrice.floatValue + minDistance;
        
        //取右边卖单对称价格数据
        for (int i = 0; i < self.asksArray.count; i++) {
            DepthModel *depthModel = self.asksArray[i];
            
            if (depthModel.price.floatValue < symmetryMaxPrice) {
                [self.showAsksArray addObject:depthModel];
            }
            else if (depthModel.price.floatValue == symmetryMaxPrice) {
                [self.showAsksArray addObject:depthModel];
                break;
            }
            else if (depthModel.price.floatValue > symmetryMaxPrice) {
                DepthModel *symmetryDepthModel = [[DepthModel alloc] init];
                symmetryDepthModel.price = [NSString stringWithFormat:@"%lf",symmetryMaxPrice];
                symmetryDepthModel.amount = @"0";
                symmetryDepthModel.previousDepthModel = depthModel.previousDepthModel;
                [self.showAsksArray addObject:symmetryDepthModel];
                break;
            }
        }
    }
    else if (minDistance == maxDistance) {
        //深度图左边买单价格和右边卖单价格离中心点相等，取左边买单全部数据，取右边卖单全部数据
        //取左边买单全部数据
        [self.showBidsArray addObjectsFromArray:self.bidsArray];
        //取右边卖单全部数据
        [self.showAsksArray addObjectsFromArray:self.asksArray];
    }
    else if (minDistance > maxDistance) {
        //深度图右边买单价格离中心点更近，取右边买单全部数据，取左边卖单数据对称价格数据
        
        //取右边买单全部数据
        [self.showAsksArray addObjectsFromArray:self.asksArray];
        
        //对称价格
        CGFloat symmetryMinPrice = currentPrice.floatValue - maxDistance;
        //取左边卖单对称价格数据
        for (int i = 0; i < self.bidsArray.count; i++) {
            DepthModel *depthModel = self.bidsArray[i];
            
            if (depthModel.price.floatValue > symmetryMinPrice) {
                [self.showBidsArray addObject:depthModel];
            }
            else if (depthModel.price.floatValue == symmetryMinPrice) {
                [self.showBidsArray addObject:depthModel];
                break;
            }
            else if (depthModel.price.floatValue < symmetryMinPrice) {
                DepthModel *symmetryDepthModel = [[DepthModel alloc] init];
                symmetryDepthModel.price = [NSString stringWithFormat:@"%lf",symmetryMinPrice];
                symmetryDepthModel.amount = @"0";
                symmetryDepthModel.previousDepthModel = depthModel.previousDepthModel;
                symmetryDepthModel.parentGroupModel = self;
                [self.showBidsArray addObject:symmetryDepthModel];
                break;
            }
        }
    }
}

@end
