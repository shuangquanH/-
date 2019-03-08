//
//  ABDataSourceManager.m
//  Y_ChartView_Example
//
//  Created by ly on 2019/1/4.
//  Copyright © 2019 iCoobin. All rights reserved.
//

#import "ABDataSourceManager.h"

@interface ABDataSourceManager ()

@property (nonnull, strong) Y_KLineGroupModel *kGroupModel;
@property (nonnull, strong) DepthGroupModel *dGroupModel;

@end

@implementation ABDataSourceManager

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (Y_KLineGroupModel *)getKLineDatasLocal {
    //读取本地data数据
    if (self.kGroupModel) {
        return self.kGroupModel;
    }
    
    NSData *kLineData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ABKLineData" ofType:@"json"]];
    NSArray *kLineDatasArray = [NSJSONSerialization JSONObjectWithData:kLineData options:NSJSONReadingAllowFragments error:nil];
    
    Y_KLineGroupModel *kLineGroupModel = [Y_KLineGroupModel objectWithArray:kLineDatasArray];
    kLineGroupModel.ask_fixed = @"2";
    kLineGroupModel.bid_fixed = @"3";
    kLineGroupModel.defaultKLineType = KLineTypeWeek;
    
    self.kGroupModel = kLineGroupModel;
    return kLineGroupModel;
}

- (DepthGroupModel *)getDepthDatasLocal {
    //读取本地data数据
    if (self.dGroupModel) {
        return self.dGroupModel;
    }
    
    NSData *asksData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ABDepthAsksData" ofType:@"json"]];
    NSArray *asksDatasArray = [NSJSONSerialization JSONObjectWithData:asksData options:NSJSONReadingAllowFragments error:nil];
    NSData *bidsData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"ABDepthBidsData" ofType:@"json"]];
    NSArray *bidsDatasArray = [NSJSONSerialization JSONObjectWithData:bidsData options:NSJSONReadingAllowFragments error:nil];
    
    DepthGroupModel *depthGroupModel = [[DepthGroupModel alloc] initWithBidsArray:bidsDatasArray asksArray:asksDatasArray];
    
    depthGroupModel.ask_fixed = @"2";
    depthGroupModel.bid_fixed = @"3";
    
    self.dGroupModel = depthGroupModel;
    return depthGroupModel;
}

@end
