//
//  Y_KLineMainView.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/30.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineMainView.h"
#import "UIColor+Y_StockChart.h"

#import "Y_KLine.h"
#import "Y_MALine.h"
#import "Y_TimeLine.h"
#import "Y_Extreme.h"
#import "Y_BrokenLine.h"
#import "Y_KLinePositionModel.h"
#import "Masonry.h"
@interface Y_KLineMainView()

@property (nonatomic, assign) CGFloat kLineWidth;

@property (nonatomic, assign) CGFloat kLineGap;

/**
 *  需要绘制的model数组
 */
@property (nonatomic, strong) NSMutableArray <Y_KLineModel *> *needDrawKLineModels;

/**
 *  需要绘制的model位置数组
 */
@property (nonatomic, strong) NSMutableArray *needDrawKLinePositionModels;


/**
 *  Index开始X的值
 */
@property (nonatomic, assign) CGFloat startXPosition;

/**
 *  MA7位置数组
 */
@property (nonatomic, strong) NSMutableArray *MA7Positions;

/**
 *  MA25位置数组
 */
@property (nonatomic, strong) NSMutableArray *MA25Positions;


/**
 *  MA99位置数组
 */
@property (nonatomic, strong) NSMutableArray *MA99Positions;

/**
 *  EMA7位置数组
 */
@property (nonatomic, strong) NSMutableArray *EMA7Positions;

/**
 *  EMA25位置数组
 */
@property (nonatomic, strong) NSMutableArray *EMA25Positions;


/**
 *  EMA99位置数组
 */
@property (nonatomic, strong) NSMutableArray *EMA99Positions;

/**
 *  BOLL_MB位置数组
 */
@property (nonatomic, strong) NSMutableArray *BOLL_MBPositions;

/**
 *  BOLL_UP位置数组
 */
@property (nonatomic, strong) NSMutableArray *BOLL_UPPositions;

/**
 *  BOLL_DN位置数组
 */
@property (nonatomic, strong) NSMutableArray *BOLL_DNPositions;

@property (nonatomic, assign) NSInteger maxIndex;
@property (nonatomic, assign) NSInteger minIndex;

@end

@implementation Y_KLineMainView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.needDrawKLineModels = @[].mutableCopy;
        self.needDrawKLinePositionModels = @[].mutableCopy;
        
        self.MA7Positions = @[].mutableCopy;
        self.MA25Positions = @[].mutableCopy;
        self.MA99Positions = @[].mutableCopy;
        
        self.EMA7Positions = @[].mutableCopy;
        self.EMA25Positions = @[].mutableCopy;
        self.EMA99Positions = @[].mutableCopy;
        
        self.BOLL_UPPositions = @[].mutableCopy;
        self.BOLL_DNPositions = @[].mutableCopy;
        self.BOLL_MBPositions = @[].mutableCopy;
        
        _needDrawStartIndex = 0;
        self.maxIndex = 0;
        self.minIndex = 0;
    }
    return self;
}

- (void)updateLineWidth:(CGFloat)width lineGap:(CGFloat)lineGap {
    self.kLineWidth = width;
    self.kLineGap = lineGap;
}

#pragma mark - 绘图相关方法

#pragma mark drawRect方法
- (void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, rect);
    
    //如果数组为空，则不进行绘制，直接设置本view为背景
    if(self.kLineModels.count == 0)
    {
        return;
    }
    
    NSMutableArray *kLineColors = @[].mutableCopy;
    
    if(self.MainViewType == Y_StockChartcenterViewTypeKline)
    {
        Y_KLine *kLine = [[Y_KLine alloc] initWithContext:context];
        kLine.kLineWidth = self.kLineWidth;
        kLine.kLineGap = self.kLineGap;
        kLine.maxY = Y_StockChartKLineMainViewMaxY;
        kLine.timeY = Y_StockChartKLineTimeY;
        kLine.parentWidth = self.frame.size.width;
        kLine.maxCount = self.needDrawKLinePositionModels.count;
        [self.needDrawKLinePositionModels enumerateObjectsUsingBlock:^(Y_KLinePositionModel * _Nonnull kLinePositionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            Y_KLineModel *tempModel = self.needDrawKLineModels[idx];
            kLine.kLinePositionModel = kLinePositionModel;
            kLine.kLineModel = tempModel;
            kLine.index = idx;
            UIColor *color = tempModel.Open.doubleValue > tempModel.Close.floatValue ? [UIColor decreaseColor] : [UIColor increaseColor];
            kLine.strokeColor = color;
            [kLine draw];
            [kLineColors addObject:color];
        }];
        if (self.needDrawKLinePositionModels.count > 0 && self.maxIndex < self.needDrawKLinePositionModels.count && self.minIndex < self.needDrawKLinePositionModels.count) {
            Y_Extreme *extreme = [[Y_Extreme alloc] initWithContext:context];
            extreme.kLineWidth = self.kLineWidth;
            extreme.kLineGap = self.kLineGap;
            extreme.screenWidth = self.frame.size.width;
            Y_KLinePositionModel *maxP = [self.needDrawKLinePositionModels objectAtIndex:self.maxIndex];
            Y_KLinePositionModel *minP = [self.needDrawKLinePositionModels objectAtIndex:self.minIndex];
            Y_KLineModel *maxM = [self.needDrawKLineModels objectAtIndex:self.maxIndex];
            Y_KLineModel *minM = [self.needDrawKLineModels objectAtIndex:self.minIndex];
            extreme.maxModel = maxM;
            extreme.minModel = minM;
            extreme.positionMaxModel = maxP;
            extreme.positionMinModel = minP;
            [extreme draw];
        }
        
    } else {
        Y_TimeLine *MALine = [[Y_TimeLine alloc] initWithContext:context];
        MALine.kLineWidth = self.kLineWidth;
        MALine.kLineGap = self.kLineGap;
        MALine.maxY = Y_StockChartKLineMainViewMaxY;
        MALine.timeY = Y_StockChartKLineTimeY;
        MALine.parentWidth = self.frame.size.width;
        MALine.maxCount = self.needDrawKLinePositionModels.count;
        MALine.timeFillColor = [UIColor y_colorWithHexString:@"D2E8FF"];
        MALine.timeLineColor = [UIColor y_colorWithHexString:@"78BCFF"];
        __block NSMutableArray *positions = @[].mutableCopy;
        __block NSMutableArray *times = @[].mutableCopy;
        [self.needDrawKLinePositionModels enumerateObjectsUsingBlock:^(Y_KLinePositionModel * _Nonnull positionModel, NSUInteger idx, BOOL * _Nonnull stop) {
            Y_KLineModel *kLineModel = self.needDrawKLineModels[idx];
            UIColor *strokeColor = kLineModel.Open.doubleValue > kLineModel.Close.floatValue ? [UIColor decreaseColor] : [UIColor increaseColor];
            [kLineColors addObject:strokeColor];
            [positions addObject:[NSValue valueWithCGPoint:positionModel.ClosePoint]];
            [times addObject:kLineModel.kLineTypeFormatDate];
        }];
        MALine.positions = positions;
        MALine.timeArray = times;
        [MALine draw];
    }
    if (self.needDrawKLinePositionModels.count > 0) {
        Y_KLinePositionModel *model = [self.needDrawKLinePositionModels lastObject];
        CGFloat startX = model.ClosePoint.x + self.kLineWidth / 2;
        if (startX < self.frame.size.width) {
            CGFloat lineWidth = 1;
            CGPoint start = CGPointMake(startX, model.ClosePoint.y - lineWidth);
            CGPoint end = CGPointMake(self.frame.size.width, model.ClosePoint.y - lineWidth);
            Y_BrokenLine *line = [[Y_BrokenLine alloc] initWithContext:context];
            line.kLineWidth = self.kLineWidth;
            line.kLineGap = self.kLineGap;
            line.lineWidth = lineWidth;
            line.dash = 7;
            line.gap = 7;
            line.startPoint = start;
            line.endPoint = end;
            line.timeLineColor = [UIColor y_colorWithHexString:@"d8d8d8"];
            [line draw];
        }
    }
    if(self.delegate && kLineColors.count > 0)
    {
        if([self.delegate respondsToSelector:@selector(kLineMainViewCurrentNeedDrawKLineColors:)])
        {
            [self.delegate kLineMainViewCurrentNeedDrawKLineColors:kLineColors];
        }
    }
    
    if (self.MainViewType == Y_StockChartcenterViewTypeTimeLine) {
        return;
    }
    Y_MALine *MALine = [[Y_MALine alloc] initWithContext:context];
    MALine.kLineWidth = self.kLineWidth;
    MALine.kLineGap = self.kLineGap;
    if (self.targetLineStatus == Y_StockChartTargetLineStatusMA) {
        
        //画MA7线
        MALine.positions = self.MA7Positions;
        MALine.timeLineColor = [UIColor ma7Color];
        [MALine draw];
        
        //画MA25线
        MALine.positions = self.MA25Positions;
        MALine.timeLineColor = [UIColor ma25Color];
        [MALine draw];
        
        //画MA99线
        MALine.positions = self.MA99Positions;
        MALine.timeLineColor = [UIColor ma99Color];
        [MALine draw];
    } else if ( self.targetLineStatus == Y_StockChartTargetLineStatusEMA){
        
        //画MA7线
        MALine.positions = self.EMA7Positions;
        MALine.timeLineColor = [UIColor ema7Color];
        [MALine draw];
        
        //画MA25线
        MALine.positions = self.EMA25Positions;
        MALine.timeLineColor = [UIColor ema25Color];
        [MALine draw];
        
        //画MA99线
        MALine.positions = self.EMA99Positions;
        MALine.timeLineColor = [UIColor ema99Color];
        [MALine draw];
    } else if (self.targetLineStatus == Y_StockChartTargetLineStatusBOLL) {
        // 画BOLL MB线 标准线
        MALine.positions = self.BOLL_MBPositions;
        MALine.timeLineColor = [UIColor BOLL_MBColor];
        [MALine draw];
        
        // 画BOLL UP 上浮线
        MALine.positions = self.BOLL_UPPositions;
        MALine.timeLineColor = [UIColor BOLL_UPColor];
        [MALine draw];
        
        // 画BOLL DN下浮线
        MALine.positions = self.BOLL_DNPositions;
        MALine.timeLineColor = [UIColor BOLL_DNColor];
        [MALine draw];
        
    }
    
}

#pragma mark - 公有方法

#pragma mark 重新设置相关数据，然后重绘
- (void)drawMainView{
    //提取需要的kLineModel
    [self private_extractNeedDrawModels];
    //转换model为坐标model
    [self private_convertToKLinePositionModelWithKLineModels];
    
    //间接调用drawRect方法
    [self setNeedsDisplay];
}

/**
 *  长按的时候根据原始的x位置获得精确的x的位置
 */
- (CGFloat)getExactXPositionWithOriginXPosition:(CGFloat)originXPosition{
    CGFloat xPositoinInMainView = originXPosition;
    NSInteger startIndex = (NSInteger)((xPositoinInMainView - self.startXPosition) / (self.kLineGap + self.kLineWidth));
    NSInteger arrCount = self.needDrawKLinePositionModels.count;
    for (NSInteger index = startIndex > 0 ? startIndex - 1 : 0; index < arrCount; ++index) {
        Y_KLinePositionModel *kLinePositionModel = self.needDrawKLinePositionModels[index];
        
        CGFloat minX = kLinePositionModel.HighPoint.x - (self.kLineGap + self.kLineWidth/2);
        CGFloat maxX = kLinePositionModel.HighPoint.x + (self.kLineGap + self.kLineWidth/2);
        
        if(xPositoinInMainView > minX && xPositoinInMainView < maxX)
        {
            if(self.delegate && [self.delegate respondsToSelector:@selector(kLineMainViewLongPressKLinePositionModel:kLineModel:)])
            {
                [self.delegate kLineMainViewLongPressKLinePositionModel:self.needDrawKLinePositionModels[index] kLineModel:self.needDrawKLineModels[index]];
            }
            return kLinePositionModel.HighPoint.x;
        }
    }
    return 0.f;
}

#pragma mark 私有方法
//提取需要绘制的数组
- (NSArray *)private_extractNeedDrawModels{
    CGFloat lineGap = self.kLineGap;
    CGFloat lineWidth = self.kLineWidth;
    
    //数组个数
    CGFloat mainViewWidth = self.frame.size.width;
    NSInteger needDrawKLineCount = (mainViewWidth + lineWidth) / (lineGap + lineWidth);
    
    //起始位置
    NSInteger needDrawKLineStartIndex  = self.needDrawStartIndex;
    
    //    ABCCLog(@"这是模型开始的index-----------%lu",needDrawKLineStartIndex);
    [self.needDrawKLineModels removeAllObjects];
    
    //赋值数组
    if(needDrawKLineStartIndex < self.kLineModels.count)
    {
        if(needDrawKLineStartIndex + needDrawKLineCount <= self.kLineModels.count)
        {
            [self.needDrawKLineModels addObjectsFromArray:[self.kLineModels subarrayWithRange:NSMakeRange(needDrawKLineStartIndex, needDrawKLineCount)]];
        } else{
            [self.needDrawKLineModels addObjectsFromArray:[self.kLineModels subarrayWithRange:NSMakeRange(needDrawKLineStartIndex, self.kLineModels.count - needDrawKLineStartIndex)]];
        }
    }
    //响应代理
    if(self.delegate && [self.delegate respondsToSelector:@selector(kLineMainViewCurrentNeedDrawKLineModels:)])
    {
        [self.delegate kLineMainViewCurrentNeedDrawKLineModels:self.needDrawKLineModels];
    }
    return self.needDrawKLineModels;
}

#pragma mark 将model转化为Position模型
- (NSArray *)private_convertToKLinePositionModelWithKLineModels {
    if(!self.needDrawKLineModels)
    {
        return nil;
    }
    
    NSArray *kLineModels = self.needDrawKLineModels;
    
    //计算最小单位
    Y_KLineModel *firstModel = kLineModels.firstObject;
    __block CGFloat minAssert = firstModel.Low.floatValue;
    __block CGFloat maxAssert = firstModel.High.floatValue;
    __block CGFloat minPrice = firstModel.Low.floatValue;
    __block CGFloat maxPrice = firstModel.High.floatValue;
    self.maxIndex = 0;
    self.minIndex = 0;
    
    [kLineModels enumerateObjectsUsingBlock:^(Y_KLineModel * _Nonnull kLineModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if(kLineModel.High.floatValue > maxAssert)
        {
            maxAssert = kLineModel.High.floatValue;
        }
        if(kLineModel.Low.floatValue < minAssert)
        {
            minAssert = kLineModel.Low.floatValue;
        }
        
        if(kLineModel.High.floatValue > maxPrice)
        {
            maxPrice = kLineModel.High.floatValue;
            self.maxIndex = idx;
        }
        if(kLineModel.Low.floatValue < minPrice)
        {
            minPrice = kLineModel.Low.floatValue;
            self.minIndex = idx;
        }
        if (self->_targetLineStatus == Y_StockChartTargetLineStatusMA) {
            
            if(kLineModel.MA7)
            {
                if (minAssert > kLineModel.MA7.floatValue) {
                    minAssert = kLineModel.MA7.floatValue;
                }
                if (maxAssert < kLineModel.MA7.floatValue) {
                    maxAssert = kLineModel.MA7.floatValue;
                }
            }
            if(kLineModel.MA25)
            {
                if (minAssert > kLineModel.MA25.floatValue) {
                    minAssert = kLineModel.MA25.floatValue;
                }
                if (maxAssert < kLineModel.MA25.floatValue) {
                    maxAssert = kLineModel.MA25.floatValue;
                }
            }
            if(kLineModel.MA99)
            {
                if (minAssert > kLineModel.MA99.floatValue) {
                    minAssert = kLineModel.MA99.floatValue;
                }
                if (maxAssert < kLineModel.MA99.floatValue) {
                    maxAssert = kLineModel.MA99.floatValue;
                }
            }
        } else if (self->_targetLineStatus == Y_StockChartTargetLineStatusEMA) {
            
            if(kLineModel.EMA7)
            {
                if (minAssert > kLineModel.EMA7.floatValue) {
                    minAssert = kLineModel.EMA7.floatValue;
                }
                if (maxAssert < kLineModel.EMA7.floatValue) {
                    maxAssert = kLineModel.EMA7.floatValue;
                }
            }
            if(kLineModel.EMA25)
            {
                if (minAssert > kLineModel.EMA25.floatValue) {
                    minAssert = kLineModel.EMA25.floatValue;
                }
                if (maxAssert < kLineModel.EMA25.floatValue) {
                    maxAssert = kLineModel.EMA25.floatValue;
                }
            }
            if(kLineModel.EMA99)
            {
                if (minAssert > kLineModel.EMA99.floatValue) {
                    minAssert = kLineModel.EMA99.floatValue;
                }
                if (maxAssert < kLineModel.EMA99.floatValue) {
                    maxAssert = kLineModel.EMA99.floatValue;
                }
            }
            
        } else if (self->_targetLineStatus == Y_StockChartTargetLineStatusBOLL) {
            
            if(kLineModel.BOLL_MB)
            {
                if (minAssert > kLineModel.BOLL_MB.floatValue) {
                    minAssert = kLineModel.BOLL_MB.floatValue;
                }
                if (maxAssert < kLineModel.BOLL_MB.floatValue) {
                    maxAssert = kLineModel.BOLL_MB.floatValue;
                }
            }
            if(kLineModel.BOLL_UP)
            {
                if (minAssert > kLineModel.BOLL_UP.floatValue) {
                    minAssert = kLineModel.BOLL_UP.floatValue;
                }
                if (maxAssert < kLineModel.BOLL_UP.floatValue) {
                    maxAssert = kLineModel.BOLL_UP.floatValue;
                }
            }
            
            if(kLineModel.BOLL_DN)
            {
                if (minAssert > kLineModel.BOLL_DN.floatValue) {
                    minAssert = kLineModel.BOLL_DN.floatValue;
                }
                if (maxAssert < kLineModel.BOLL_DN.floatValue) {
                    maxAssert = kLineModel.BOLL_DN.floatValue;
                }
            }
            
        }
        
    }];
    
    //此处防止最大值最小值相同而导致priceView无法区分刻度
    maxAssert *= 1.001;
    minAssert *= 0.999;
    
    CGFloat minY = Y_StockChartKLineMainViewMinY;
    CGFloat maxY = Y_StockChartKLineMainViewMaxY;
    
    //计算得到单位value对应的Y值
    CGFloat unitValue = (maxAssert - minAssert == 0)?0:(maxY - minY) / (maxAssert - minAssert);
    
    [self.needDrawKLinePositionModels removeAllObjects];
    [self.MA7Positions removeAllObjects];
    [self.MA25Positions removeAllObjects];
    [self.MA99Positions removeAllObjects];
    [self.EMA7Positions removeAllObjects];
    [self.EMA25Positions removeAllObjects];
    [self.EMA99Positions removeAllObjects];
    [self.BOLL_MBPositions removeAllObjects];
    [self.BOLL_UPPositions removeAllObjects];
    [self.BOLL_DNPositions removeAllObjects];
    
    NSInteger kLineModelsCount = kLineModels.count;
    for (NSInteger idx = 0 ; idx < kLineModelsCount; ++idx)
    {
        //K线坐标转换
        Y_KLineModel *kLineModel = kLineModels[idx];
        
        CGFloat xPosition = self.startXPosition + idx * (self.kLineGap + self.kLineWidth);
        if (idx == kLineModelsCount - 1) {
            xPosition = self.startXPosition + idx * (self.kLineGap + self.kLineWidth);
        }
        CGPoint openPoint = CGPointMake(xPosition, maxY - ABS((kLineModel.Open.floatValue - minAssert) * unitValue));
        CGFloat closePointY = ABS(maxY - (kLineModel.Close.floatValue - minAssert) * unitValue);
        if(ABS(closePointY - openPoint.y) < Y_StockChartKLineMinHeight)
        {
            if(openPoint.y > closePointY)
            {
                openPoint.y = closePointY + Y_StockChartKLineMinHeight;
            } else if(openPoint.y < closePointY)
            {
                closePointY = openPoint.y + Y_StockChartKLineMinHeight;
            } else {
                if(idx > 0)
                {
                    Y_KLineModel *preKLineModel = kLineModels[idx-1];
                    if(kLineModel.Open.floatValue > preKLineModel.Close.floatValue)
                    {
                        openPoint.y = closePointY + Y_StockChartKLineMinHeight;
                    }
                    else {
                        closePointY = openPoint.y + Y_StockChartKLineMinHeight;
                    }
                }
                else if(idx == 0 && kLineModelsCount > 1){
                    
                    //idx==0即第一个时
                    Y_KLineModel *subKLineModel = kLineModels[idx+1];
                    if(subKLineModel.Open.floatValue > kLineModel.Close.floatValue)
                    {
                        openPoint.y = closePointY + Y_StockChartKLineMinHeight;
                    }
                    else {
                        closePointY = openPoint.y + Y_StockChartKLineMinHeight;
                    }
                }
            }
        }
        
        CGPoint closePoint = CGPointMake(xPosition, closePointY);
        CGPoint highPoint = CGPointMake(xPosition, ABS(maxY - (kLineModel.High.floatValue - minAssert) * unitValue));
        CGPoint lowPoint = CGPointMake(xPosition, ABS(maxY - (kLineModel.Low.floatValue - minAssert) * unitValue));
        
        Y_KLinePositionModel *kLinePositionModel = [Y_KLinePositionModel modelWithOpen:openPoint close:closePoint high:highPoint low:lowPoint];
        [self.needDrawKLinePositionModels addObject:kLinePositionModel];
        
        if (_targetLineStatus == Y_StockChartTargetLineStatusMA) {
            //MA坐标转换
            CGFloat ma7Y = maxY;
            CGFloat ma25Y = maxY;
            CGFloat ma99Y = maxY;
            
            if(kLineModel.MA7)
            {
                ma7Y = maxY - (kLineModel.MA7.floatValue - minAssert) * unitValue;
            }
            if(kLineModel.MA25)
            {
                ma25Y = maxY - (kLineModel.MA25.floatValue - minAssert) * unitValue;
            }
            if(kLineModel.MA99)
            {
                ma99Y = maxY - (kLineModel.MA99.floatValue - minAssert) * unitValue;
            }
            
            NSAssert(!isnan(ma7Y) && !isnan(ma25Y) && !isnan(ma99Y), @"出现NAN值");
            
            CGPoint ma7Point = CGPointMake(xPosition, ma7Y);
            CGPoint ma25Point = CGPointMake(xPosition, ma25Y);
            CGPoint ma99Point = CGPointMake(xPosition, ma99Y);
            
            if(kLineModel.MA7)
            {
                [self.MA7Positions addObject: [NSValue valueWithCGPoint: ma7Point]];
            }
            if(kLineModel.MA25)
            {
                [self.MA25Positions addObject: [NSValue valueWithCGPoint: ma25Point]];
            }
            if(kLineModel.MA99)
            {
                [self.MA99Positions addObject: [NSValue valueWithCGPoint: ma99Point]];
            }
        } else if (_targetLineStatus == Y_StockChartTargetLineStatusEMA) {
            //MA坐标转换
            CGFloat ema7Y = maxY;
            CGFloat ema25Y = maxY;
            CGFloat ema99Y = maxY;
            
            if(kLineModel.EMA7)
            {
                ema7Y = maxY - (kLineModel.EMA7.floatValue - minAssert) * unitValue;
            }
            if(kLineModel.EMA25)
            {
                ema25Y = maxY - (kLineModel.EMA25.floatValue - minAssert) * unitValue;
            }
            if(kLineModel.EMA99)
            {
                ema99Y = maxY - (kLineModel.EMA99.floatValue - minAssert) * unitValue;
            }
            
            NSAssert(!isnan(ema7Y) && !isnan(ema25Y) && !isnan(ema99Y), @"出现NAN值");
            
            CGPoint ema7Point = CGPointMake(xPosition, ema7Y);
            CGPoint ema25Point = CGPointMake(xPosition, ema25Y);
            CGPoint ema99Point = CGPointMake(xPosition, ema99Y);
            
            if(kLineModel.EMA7)
            {
                [self.EMA7Positions addObject: [NSValue valueWithCGPoint: ema7Point]];
            }
            if(kLineModel.EMA25)
            {
                [self.EMA25Positions addObject: [NSValue valueWithCGPoint: ema25Point]];
            }
            if(kLineModel.EMA99)
            {
                [self.EMA99Positions addObject: [NSValue valueWithCGPoint: ema99Point]];
            }
        } else if(_targetLineStatus == Y_StockChartTargetLineStatusBOLL){
            
            
            //BOLL坐标转换
            CGFloat boll_mbY = maxY;
            CGFloat boll_upY = maxY;
            CGFloat boll_dnY = maxY;
            
            //            ABCCLog(@"position：\n上: %@ \n中: %@ \n下: %@",kLineModel.BOLL_UP,kLineModel.BOLL_MB,kLineModel.BOLL_DN);
            
            if(unitValue > 0.000000001)
            {
                
                if(kLineModel.BOLL_MB)
                {
                    boll_mbY = maxY - (kLineModel.BOLL_MB.floatValue - minAssert) * unitValue;
                }
                
            }
            if(unitValue > 0.000000001)
            {
                if(kLineModel.BOLL_DN)
                {
                    boll_dnY = maxY - (kLineModel.BOLL_DN.floatValue - minAssert) * unitValue ;
                }
            }
            
            if(unitValue > 0.000000001)
            {
                if(kLineModel.BOLL_UP)
                {
                    boll_upY = maxY - (kLineModel.BOLL_UP.floatValue - minAssert) * unitValue;
                }
            }
            
            NSAssert(!isnan(boll_mbY) && !isnan(boll_upY) && !isnan(boll_dnY), @"出现BOLL值");
            
            CGPoint boll_mbPoint = CGPointMake(xPosition, boll_mbY);
            CGPoint boll_upPoint = CGPointMake(xPosition, boll_upY);
            CGPoint boll_dnPoint = CGPointMake(xPosition, boll_dnY);
            
            
            if (kLineModel.BOLL_MB) {
                [self.BOLL_MBPositions addObject:[NSValue valueWithCGPoint:boll_mbPoint]];
            }
            
            if (kLineModel.BOLL_UP) {
                [self.BOLL_UPPositions addObject:[NSValue valueWithCGPoint:boll_upPoint]];
            }
            if (kLineModel.BOLL_DN) {
                [self.BOLL_DNPositions addObject:[NSValue valueWithCGPoint:boll_dnPoint]];
            }
            
        }
        
    }
    
    //响应代理方法
    if(self.delegate)
    {
        if([self.delegate respondsToSelector:@selector(kLineMainViewCurrentMaxPrice:minPrice:)])
        {
            [self.delegate kLineMainViewCurrentMaxPrice:maxAssert minPrice:minAssert];
        }
        if([self.delegate respondsToSelector:@selector(kLineMainViewCurrentNeedDrawKLinePositionModels:)])
        {
            [self.delegate kLineMainViewCurrentNeedDrawKLinePositionModels:self.needDrawKLinePositionModels];
        }
    }
    return self.needDrawKLinePositionModels;
}

#pragma mark - setter,getter方法
- (CGFloat)startXPosition{
    return self.kLineWidth / 2.0;
}

- (void)setKLineModels:(NSArray *)kLineModels{
    _kLineModels = kLineModels;
    [self drawMainView];
}

@end
