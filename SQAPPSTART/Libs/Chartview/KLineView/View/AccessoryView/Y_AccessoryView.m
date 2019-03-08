//
//  Y_AccessoryView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/5/3.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_AccessoryView.h"
#import "Y_KLineModel.h"

#import "UIColor+Y_StockChart.h"
#import "Y_KLineAccessory.h"
#import "Y_KLineVolumePositionModel.h"
#import "Y_KLinePositionModel.h"
#import "Y_MALine.h"
#import "Y_TimeLine.h"
@interface Y_AccessoryView()

@property (nonatomic, assign) CGFloat kLineWidth;

@property (nonatomic, assign) CGFloat kLineGap;

/**
 *  需要绘制的Volume的位置模型数组
 */
@property (nonatomic, strong) NSArray *needDrawKLineVOLPositionModels;

/**
 *  需要绘制的MACD位置模型数组
 */
@property (nonatomic, strong) NSArray *needDrawKLineMACDPositionModels;

/**
 *  MACD_DIF位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_DIFPositions;

/**
 *  MACD_DEA位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_DEAPositions;

/**
 *  KDJ_K位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_KDJ_KPositions;

/**
 *  KDJ_D位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_KDJ_DPositions;

/**
 *  KDJ_J位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_KDJ_JPositions;

/**
 *  RSI(7)位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_RSI7Positions;

/**
 *  RSI(14)位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_RSI14Positions;

/**
 *  RSI(28)位置数组
 */
@property (nonatomic, strong) NSMutableArray *Accessory_RSI28Positions;

@end

@implementation Y_AccessoryView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.Accessory_DIFPositions = @[].mutableCopy;
        self.Accessory_DEAPositions = @[].mutableCopy;
        self.Accessory_KDJ_KPositions = @[].mutableCopy;
        self.Accessory_KDJ_DPositions = @[].mutableCopy;
        self.Accessory_KDJ_JPositions = @[].mutableCopy;
        self.Accessory_RSI7Positions = @[].mutableCopy;
        self.Accessory_RSI14Positions = @[].mutableCopy;
        self.Accessory_RSI28Positions = @[].mutableCopy;
    }
    return self;
}

- (void)updateLineWidth:(CGFloat)width lineGap:(CGFloat)lineGap {
    self.kLineWidth = width;
    self.kLineGap = lineGap;
}

#pragma mark drawRect方法
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    /**
     *  副图，需要区分是MACD线还是KDJ线，进而选择不同的数据源和绘制方法
     */
    if (self.targetLineStatus == Y_StockChartTargetLineStatusMACD) {
        /**
         MACD
         */
        Y_KLineAccessory *kLineAccessory = [[Y_KLineAccessory alloc] initWithContext:context];
        kLineAccessory.kLineWidth = self.kLineWidth;
        kLineAccessory.kLineGap = self.kLineGap;
        [self.needDrawKLineMACDPositionModels enumerateObjectsUsingBlock:^(Y_KLineVolumePositionModel * _Nonnull volumePositionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            kLineAccessory.positionModel = volumePositionModel;
            kLineAccessory.kLineModel = self.needDrawKLineModels[idx];
            if(kLineAccessory.kLineModel.MACD.floatValue > 0) {
                kLineAccessory.lineColor = [UIColor increaseColor];
            } else {
                kLineAccessory.lineColor = [UIColor decreaseColor];
            }
            [kLineAccessory draw];
        }];
        
        Y_MALine *MALine = [[Y_MALine alloc]initWithContext:context];
        MALine.kLineWidth = self.kLineWidth;
        MALine.kLineGap = self.kLineGap;
        
        //画DIF线
        MALine.positions = self.Accessory_DIFPositions;
        MALine.timeLineColor = [UIColor MACD_DIFColor];
        [MALine draw];
        
        //画DEA线
        MALine.positions = self.Accessory_DEAPositions;
        MALine.timeLineColor = [UIColor MACD_DEAColor];
        [MALine draw];
    } else if (self.targetLineStatus == Y_StockChartTargetLineStatusVOL) {
        /**
         VOL
         */
        Y_KLineAccessory *kLineVolume = [[Y_KLineAccessory alloc] initWithContext:context];
        kLineVolume.kLineWidth = self.kLineWidth;
        kLineVolume.kLineGap = self.kLineGap;
        [self.needDrawKLineVOLPositionModels enumerateObjectsUsingBlock:^(Y_KLineVolumePositionModel * _Nonnull volumePositionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx < self.needDrawKLineModels.count && idx < self.kLineColors.count) {
                kLineVolume.positionModel = volumePositionModel;
                kLineVolume.kLineModel = self.needDrawKLineModels[idx];
                kLineVolume.lineColor = self.kLineColors[idx];
                [kLineVolume draw];
            }
        }];
    }  else if (self.targetLineStatus == Y_StockChartTargetLineStatusKDJ) {
        /**
        KDJ
         */
        Y_MALine *MALine = [[Y_MALine alloc]initWithContext:context];
        MALine.kLineWidth = self.kLineWidth;
        MALine.kLineGap = self.kLineGap;
        
        //画KDJ_K线
        MALine.positions = self.Accessory_KDJ_KPositions;
        MALine.timeLineColor = [UIColor KDJ_KColor];
        [MALine draw];
        
        //画KDJ_D线
        MALine.positions = self.Accessory_KDJ_DPositions;
        MALine.timeLineColor = [UIColor KDJ_DColor];
        [MALine draw];
        
        //画KDJ_J线
        MALine.positions = self.Accessory_KDJ_JPositions;
        MALine.timeLineColor = [UIColor KDJ_JColor];
        [MALine draw];
    } else if (self.targetLineStatus == Y_StockChartTargetLineStatusRSI) {
        /**
         RSI
         */
        Y_MALine *MALine = [[Y_MALine alloc]initWithContext:context];
        MALine.kLineWidth = self.kLineWidth;
        MALine.kLineGap = self.kLineGap;
        
        //画RSI_7线
        MALine.positions = self.Accessory_RSI7Positions;
        MALine.timeLineColor = [UIColor RSI_7Color];
        [MALine draw];
        
        //画RSI_14线
        MALine.positions = self.Accessory_RSI14Positions;
        MALine.timeLineColor = [UIColor RSI_14Color];
        [MALine draw];
        
        //画RSI_28线
        MALine.positions = self.Accessory_RSI28Positions;
        MALine.timeLineColor = [UIColor RSI_28Color];
        [MALine draw];
    }
    
}

#pragma mark - 公有方法
#pragma mark 绘制volume方法
- (void)draw
{
    NSInteger kLineModelcount = self.needDrawKLineModels.count;
    NSInteger kLinePositionModelCount = self.needDrawKLinePositionModels.count;
    NSInteger kLineColorCount = self.kLineColors.count;
//    NSAssert(self.needDrawKLineModels && self.needDrawKLinePositionModels && self.kLineColors && kLineColorCount == kLineModelcount && kLinePositionModelCount == kLineModelcount, @"数据异常，无法绘制Volume");
    if (self.needDrawKLineModels && self.needDrawKLinePositionModels && self.kLineColors && kLineColorCount == kLineModelcount && kLinePositionModelCount == kLineModelcount) {
        [self private_convertToKLinePositionModelWithKLineModels:self.needDrawKLineModels];
        [self setNeedsDisplay];
    }
}

#pragma mark - 私有方法
#pragma mark 根据KLineModel转换成Position数组
- (void)private_convertToKLinePositionModelWithKLineModels:(NSArray *)kLineModels
{
    CGFloat minY = Y_StockChartKLineAccessoryViewMinY;
    CGFloat maxY = Y_StockChartKLineAccessoryViewMaxY;
    
    __block CGFloat minValue = 0;
    __block CGFloat maxValue = 0;
    
    NSMutableArray *positionModels = @[].mutableCopy;

    if(self.targetLineStatus == Y_StockChartTargetLineStatusMACD) {
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(model.DIF)
            {
                if(model.DIF.floatValue < minValue) {
                    minValue = model.DIF.floatValue;
                }
                if(model.DIF.floatValue > maxValue) {
                    maxValue = model.DIF.floatValue;
                }
            }
            
            if(model.DEA)
            {
                if (minValue > model.DEA.floatValue) {
                    minValue = model.DEA.floatValue;
                }
                if (maxValue < model.DEA.floatValue) {
                    maxValue = model.DEA.floatValue;
                }
            }
            if(model.MACD)
            {
                if (minValue > model.MACD.floatValue) {
                    minValue = model.MACD.floatValue;
                }
                if (maxValue < model.MACD.floatValue) {
                    maxValue = model.MACD.floatValue;
                }
            }
        }];
        
        maxValue *= 1.001;
        minValue *= 0.999;
        CGFloat unitValue = (maxValue - minValue == 0)?0:(maxY - minY) / (maxValue - minValue);
        
        [self.Accessory_DIFPositions removeAllObjects];
        [self.Accessory_DEAPositions removeAllObjects];
        
        CGFloat middleY = maxValue;
        if (maxValue <= 0) {
            middleY = minY;
        } else if (minValue >= 0) {
            middleY = maxValue;
        } else {
            middleY = maxY - ABS(minValue * unitValue);
        }
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[idx];
            CGFloat xPosition = kLinePositionModel.HighPoint.x;
            
            
            CGFloat yPosition = middleY - model.MACD.floatValue * unitValue;
            
            CGPoint startPoint = CGPointMake(xPosition, yPosition);
            
            CGPoint endPoint = CGPointMake(xPosition,middleY);
            Y_KLineVolumePositionModel *volumePositionModel = [Y_KLineVolumePositionModel modelWithStartPoint:startPoint endPoint:endPoint];
            [positionModels addObject:volumePositionModel];
            
            //MA坐标转换
            CGFloat DIFY = maxY;
            CGFloat DEAY = maxY;
            if(unitValue > 0.0000001)
            {
                if(model.DIF)
                {
                    DIFY = middleY - model.DIF.floatValue * unitValue;
                }
                
            }
            if(unitValue > 0.0000001)
            {
                if(model.DEA)
                {
                    DEAY = middleY - model.DEA.floatValue * unitValue;

                }
            }
            
            NSAssert(!isnan(DIFY) && !isnan(DEAY), @"出现NAN值");
            
            CGPoint DIFPoint = CGPointMake(xPosition, DIFY);
            CGPoint DEAPoint = CGPointMake(xPosition, DEAY);
            
            if(model.DIF)
            {
                [self.Accessory_DIFPositions addObject: [NSValue valueWithCGPoint: DIFPoint]];
            }
            if(model.DEA)
            {
                [self.Accessory_DEAPositions addObject: [NSValue valueWithCGPoint: DEAPoint]];
            }
        }];
        self.needDrawKLineMACDPositionModels = positionModels;
    } else if (self.targetLineStatus == Y_StockChartTargetLineStatusVOL) {
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(model.Volume < minValue)
            {
                minValue = model.Volume;
            }
            
            if(model.Volume > maxValue)
            {
                maxValue = model.Volume;
            }
        }];
        
        maxValue *= 1.001;
        minValue *= 0.999;
        CGFloat unitValue = (maxValue - minValue == 0)?0:(maxY - minY) / (maxValue - minValue);
        
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[idx];
            CGFloat xPosition = kLinePositionModel.HighPoint.x;
            CGFloat yPosition = ABS(maxY - (model.Volume - minValue) * unitValue);
            if(ABS(yPosition - maxY) < 0.5)
            {
                yPosition = maxY - 1;
            }
            CGPoint startPoint = CGPointMake(xPosition, yPosition);
            CGPoint endPoint = CGPointMake(xPosition, maxY);
            Y_KLineVolumePositionModel *volumePositionModel = [Y_KLineVolumePositionModel modelWithStartPoint:startPoint endPoint:endPoint];
            [positionModels addObject:volumePositionModel];
        }];
        self.needDrawKLineVOLPositionModels = positionModels;
    }  else if (self.targetLineStatus == Y_StockChartTargetLineStatusKDJ) {
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(model.KDJ_K)
            {
                if (minValue > model.KDJ_K.floatValue) {
                    minValue = model.KDJ_K.floatValue;
                }
                if (maxValue < model.KDJ_K.floatValue) {
                    maxValue = model.KDJ_K.floatValue;
                }
            }
            
            if(model.KDJ_D)
            {
                if (minValue > model.KDJ_D.floatValue) {
                    minValue = model.KDJ_D.floatValue;
                }
                if (maxValue < model.KDJ_D.floatValue) {
                    maxValue = model.KDJ_D.floatValue;
                }
            }
            if(model.KDJ_J)
            {
                if (minValue > model.KDJ_J.floatValue) {
                    minValue = model.KDJ_J.floatValue;
                }
                if (maxValue < model.KDJ_J.floatValue) {
                    maxValue = model.KDJ_J.floatValue;
                }
            }
        }];
        
        maxValue *= 1.001;
        minValue *= 0.999;
        CGFloat unitValue = (maxValue - minValue == 0)?0:(maxY - minY) / (maxValue - minValue);
        
        [self.Accessory_KDJ_KPositions removeAllObjects];
        [self.Accessory_KDJ_DPositions removeAllObjects];
        [self.Accessory_KDJ_JPositions removeAllObjects];
        
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[idx];
            CGFloat xPosition = kLinePositionModel.HighPoint.x;
            
            //MA坐标转换
            CGFloat KDJ_K_Y = maxY;
            CGFloat KDJ_D_Y = maxY;
            CGFloat KDJ_J_Y = maxY;
            if(unitValue > 0.0000001)
            {
                if(model.KDJ_K)
                {
                    KDJ_K_Y = maxY - (model.KDJ_K.floatValue - minValue) * unitValue;
                }
                
            }
            if(unitValue > 0.0000001)
            {
                if(model.KDJ_D)
                {
                    KDJ_D_Y = maxY - (model.KDJ_D.floatValue - minValue) * unitValue;
                }
            }
            if(unitValue > 0.0000001)
            {
                if(model.KDJ_J)
                {
                    KDJ_J_Y = maxY - (model.KDJ_J.floatValue - minValue) * unitValue;
                }
            }
            
            NSAssert(!isnan(KDJ_K_Y) && !isnan(KDJ_D_Y) && !isnan(KDJ_J_Y), @"出现NAN值");
            
            CGPoint KDJ_KPoint = CGPointMake(xPosition, KDJ_K_Y);
            CGPoint KDJ_DPoint = CGPointMake(xPosition, KDJ_D_Y);
            CGPoint KDJ_JPoint = CGPointMake(xPosition, KDJ_J_Y);

            
            if(model.KDJ_K)
            {
                [self.Accessory_KDJ_KPositions addObject: [NSValue valueWithCGPoint: KDJ_KPoint]];
            }
            if(model.KDJ_D)
            {
                [self.Accessory_KDJ_DPositions addObject: [NSValue valueWithCGPoint: KDJ_DPoint]];
            }
            if(model.KDJ_J)
            {
                [self.Accessory_KDJ_JPositions addObject: [NSValue valueWithCGPoint: KDJ_JPoint]];
            }
        }];
    } else if (self.targetLineStatus == Y_StockChartTargetLineStatusRSI) {
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if(model.RSI7)
            {
                if (minValue > model.RSI7.floatValue) {
                    minValue = model.RSI7.floatValue;
                }
                if (maxValue < model.RSI7.floatValue) {
                    maxValue = model.RSI7.floatValue;
                }
            }
            
            if(model.RSI14)
            {
                if (minValue > model.RSI14.floatValue) {
                    minValue = model.RSI14.floatValue;
                }
                if (maxValue < model.RSI14.floatValue) {
                    maxValue = model.RSI14.floatValue;
                }
            }
            if(model.RSI28)
            {
                if (minValue > model.RSI28.floatValue) {
                    minValue = model.RSI28.floatValue;
                }
                if (maxValue < model.RSI28.floatValue) {
                    maxValue = model.RSI28.floatValue;
                }
            }
        }];
        
        maxValue *= 1.001;
        minValue *= 0.999;
        CGFloat unitValue = (maxValue - minValue == 0)?0:(maxY - minY) / (maxValue - minValue);
        
        [self.Accessory_RSI7Positions removeAllObjects];
        [self.Accessory_RSI14Positions removeAllObjects];
        [self.Accessory_RSI28Positions removeAllObjects];
        
        [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel *  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[idx];
            CGFloat xPosition = kLinePositionModel.HighPoint.x;
            
            //MA坐标转换
            CGFloat RSI_7_Y = maxY;
            CGFloat RSI_14_Y = maxY;
            CGFloat RSI_28_Y = maxY;
            if(unitValue > 0.0000001)
            {
                if(model.RSI7)
                {
                    RSI_7_Y = maxY - (model.RSI7.floatValue - minValue) * unitValue;
                }
                
            }
            if(unitValue > 0.0000001)
            {
                if(model.RSI14)
                {
                    RSI_14_Y = maxY - (model.RSI14.floatValue - minValue) * unitValue;
                }
            }
            if(unitValue > 0.0000001)
            {
                if(model.RSI28)
                {
                    RSI_28_Y = maxY - (model.RSI28.floatValue - minValue) * unitValue;
                }
            }
            
            NSAssert(!isnan(RSI_7_Y) && !isnan(RSI_14_Y) && !isnan(RSI_28_Y), @"出现NAN值");
            
            CGPoint RSI_7Point = CGPointMake(xPosition, RSI_7_Y);
            CGPoint RSI_14Point = CGPointMake(xPosition, RSI_14_Y);
            CGPoint RSI_28Point = CGPointMake(xPosition, RSI_28_Y);
            
            
            if(model.RSI7)
            {
                [self.Accessory_RSI7Positions addObject: [NSValue valueWithCGPoint: RSI_7Point]];
            }
            if(model.RSI14)
            {
                [self.Accessory_RSI14Positions addObject: [NSValue valueWithCGPoint: RSI_14Point]];
            }
            if(model.RSI28)
            {
                [self.Accessory_RSI28Positions addObject: [NSValue valueWithCGPoint: RSI_28Point]];
            }
        }];
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(kLineAccessoryViewCurrentMaxValue:minValue:)])
    {
        [self.delegate kLineAccessoryViewCurrentMaxValue:maxValue minValue:minValue];
    }
}
@end
