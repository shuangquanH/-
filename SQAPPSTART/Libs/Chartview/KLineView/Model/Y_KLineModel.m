//
//  Y-KlineModel.m
//  BTC-Kline
//
//  Created by yate1996 on 16/4/28.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import "Y_KLineModel.h"
#import "Y_KLineGroupModel.h"
#import "NSString+Y_StockChart.h"

@implementation Y_KLineModel

- (NSNumber *)RSV_9
{
    if (!_RSV_9) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        NSInteger count = MIN(index + 1, 9);
        
        CGFloat max = [self.ParentGroupModel.models objectAtIndex:index].High.floatValue;
        CGFloat min = [self.ParentGroupModel.models objectAtIndex:index].Low.floatValue;
        for (NSInteger i = index - count + 1;i <= index; i++) {
            Y_KLineModel *model = [self.ParentGroupModel.models objectAtIndex:i];
            if (model.High.floatValue > max) {
                max = model.High.floatValue;
            }
            if (model.Low.floatValue < min) {
                min = model.Low.floatValue;
            }
        }
        if (max - min == 0) {
            _RSV_9 = @100;
        } else {
            _RSV_9 = @((self.Close.floatValue - min) * 100 / (max - min));
        }
    }
    return _RSV_9;
}

- (NSNumber *)KDJ_K
{
    if (!_KDJ_K) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 3) {
            if (index > 3) {
                _KDJ_K = @((self.RSV_9.floatValue + 2 * (self.PreviousKlineModel.KDJ_K ? self.PreviousKlineModel.KDJ_K.floatValue : 50)) / 3);
            } else {
                CGFloat kValue = [self.ParentGroupModel.models objectAtIndex:0].RSV_9.floatValue;
                for (int i = 1; i < 3; i++) {
                    Y_KLineModel *model = [self.ParentGroupModel.models objectAtIndex:i];
                    kValue = (model.RSV_9.floatValue + 2 * kValue) / 3;
                }
                _KDJ_K = @(kValue);
            }
        }
    }
    return _KDJ_K;
}

- (NSNumber *)KDJ_D
{
    if(!_KDJ_D) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 5) {
            if (index > 5) {
                _KDJ_D = @((self.KDJ_K.floatValue + 2 * (self.PreviousKlineModel.KDJ_D ? self.PreviousKlineModel.KDJ_D.floatValue : 50)) / 3);
            } else {
                CGFloat kValue = [self.ParentGroupModel.models objectAtIndex:3].RSV_9.floatValue;
                for (int i = 4; i < 5; i++) {
                    Y_KLineModel *model = [self.ParentGroupModel.models objectAtIndex:i];
                    kValue = (model.KDJ_K.floatValue + 2 * kValue) / 3;
                }
                _KDJ_D = @(kValue);
            }
        }
    }
    return _KDJ_D;
}

- (NSNumber *)KDJ_J
{
    if(!_KDJ_J) {
        if (self.KDJ_K && self.KDJ_D) {
            _KDJ_J = @(3*self.KDJ_K.floatValue - 2*self.KDJ_D.floatValue);
        }
    }
    return _KDJ_J;
}

- (NSNumber *)MA7
{
    if (!_MA7) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 6) {
            if (index > 6) {
                _MA7 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 7].SumOfLastClose.floatValue) / 7);
            } else {
                _MA7 = @(self.SumOfLastClose.floatValue / 7);
            }
        }
    }
    return _MA7;
}

- (NSNumber *)MA25
{
    if (!_MA25) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 24) {
            if (index > 24) {
                _MA25 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 25].SumOfLastClose.floatValue) / 25);
            } else {
                _MA25 = @(self.SumOfLastClose.floatValue / 25);
            }
        }
    }
    return _MA25;
}

- (NSNumber *)MA99
{
    if (!_MA99) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 98) {
            if (index > 98) {
                _MA99 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 99].SumOfLastClose.floatValue) / 99);
            } else {
                _MA99 = @(self.SumOfLastClose.floatValue / 99);
            }
        }
    }
    return _MA99;
}

- (NSNumber *)MA20
{
    if (!_MA20) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 19) {
            if (index > 19) {
                _MA20 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 20].SumOfLastClose.floatValue) / 20);
            } else {
                _MA20 = @(self.SumOfLastClose.floatValue / 20);
            }
        }
    }
    return _MA20;
}

- (NSNumber *)MA12
{
    if (!_MA12) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 11) {
            if (index > 11) {
                _MA12 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 12].SumOfLastClose.floatValue) / 12);
            } else {
                _MA12 = @(self.SumOfLastClose.floatValue / 12);
            }
        }
    }
    return _MA12;
}

- (NSNumber *)MA26
{
    if (!_MA26) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 25) {
            if (index > 25) {
                _MA26 = @((self.SumOfLastClose.floatValue - self.ParentGroupModel.models[index - 26].SumOfLastClose.floatValue) / 26);
            } else {
                _MA26 = @(self.SumOfLastClose.floatValue / 26);
            }
        }
    }
    return _MA26;
}

//// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
- (NSNumber *)EMA7
{
    if(!_EMA7) {
        if (self.PreviousKlineModel.EMA7) {
            _EMA7 = @((2 * self.Close.floatValue + 6 * self.PreviousKlineModel.EMA7.floatValue)/8);
        } else {
            _EMA7 = self.MA7;
        }
    }
    return _EMA7;
}

- (NSNumber *)EMA25
{
    if(!_EMA25) {
        if (self.PreviousKlineModel.EMA25) {
            _EMA25 = @((2 * self.Close.floatValue + 24 * self.PreviousKlineModel.EMA25.floatValue)/26);
        } else {
            _EMA25 = self.MA25;
        }
    }
    return _EMA25;
}

- (NSNumber *)EMA99
{
    if(!_EMA99) {
        if (self.PreviousKlineModel.EMA99) {
            _EMA99 = @((2 * self.Close.floatValue + 98 * self.PreviousKlineModel.EMA99.floatValue)/100);
        } else {
            _EMA99 = self.MA99;
        }
    }
    return _EMA99;
}

- (NSNumber *)EMA20
{
    if(!_EMA20) {
        if (self.PreviousKlineModel.EMA20) {
            _EMA20 = @((2 * self.Close.floatValue + 19 * self.PreviousKlineModel.EMA20.floatValue)/21);
        } else {
            _EMA20 = self.MA20;
        }
    }
    return _EMA20;
}

- (NSNumber *)SumOfLastClose
{
    if(!_SumOfLastClose) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index > 0) {
            _SumOfLastClose = @(self.PreviousKlineModel.SumOfLastClose.floatValue + _Close.floatValue);
        } else {
            _SumOfLastClose = @0;
        }
    }
    return _SumOfLastClose;
}

- (NSNumber *)SumOfLastVolume
{
    if(!_SumOfLastVolume) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index > 0) {
            _SumOfLastVolume = @(self.PreviousKlineModel.SumOfLastVolume.floatValue + _Volume);
        } else {
            _SumOfLastVolume = @0;
        }
    }
    return _SumOfLastVolume;
}

//- (NSNumber *)NineClocksMinPrice
//{
//    if (!_NineClocksMinPrice) {
//        if([self.ParentGroupModel.models indexOfObject:self] >= 8)
//        {
//            [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedDescending];
//        } else {
//            _NineClocksMinPrice = @0;
//        }
//    }
//    return _NineClocksMinPrice;
//}
//
//- (NSNumber *)NineClocksMaxPrice {
//    if (!_NineClocksMaxPrice) {
//        if([self.ParentGroupModel.models indexOfObject:self] >= 8)
//        {
//            [self rangeLastNinePriceByArray:self.ParentGroupModel.models condition:NSOrderedAscending];
//        } else {
//            _NineClocksMaxPrice = @0;
//        }
//    }
//    return _NineClocksMaxPrice;
//}


////DIF=EMA（12）-EMA（26）         DIF的值即为红绿柱；
//
////今日的DEA值=前一日DEA*8/10+今日DIF*2/10.
- (NSNumber *)EMA12
{
    if(!_EMA12) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 11) {
            if (index > 11) {
                _EMA12 = @((2 * self.Close.floatValue + 11 * self.PreviousKlineModel.EMA12.floatValue)/13);
            } else {
                _EMA12 = self.MA12;
            }
        }
    }
    return _EMA12;
}

- (NSNumber *)EMA26
{
    if(!_EMA26) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 25) {
            if (index > 25) {
                _EMA26 = @((2 * self.Close.floatValue + 25 * self.PreviousKlineModel.EMA26.floatValue)/27);
            } else {
                _EMA26 = self.MA26;
            }
        }
    }
    return _EMA26;
}

- (NSNumber *)DIF
{
    if(!_DIF) {
        if (self.EMA12 && self.EMA26) {
            _DIF = @(self.EMA12.floatValue - self.EMA26.floatValue);
        }
    }
    return _DIF;
}

//已验证
- (NSNumber *)DEA
{
    if(!_DEA) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= (25 + 8)) {
            if (index > (25 + 8)) {
                _DEA = @((2 * self.DIF.floatValue + (9 - 1) * self.PreviousKlineModel.DEA.floatValue) / (9 + 1));
            } else {
                CGFloat sumDiff = 0;
                for (NSInteger i = 25; i <= (25 + 8); i++) {
                    Y_KLineModel *temp = [self.ParentGroupModel.models objectAtIndex:i];
                    sumDiff += temp.DIF.floatValue;
                }
                _DEA = @(sumDiff / 9);
            }
        }
    }
    return _DEA;
}

//已验证
- (NSNumber *)MACD
{
    if(!_MACD) {
        if (self.DIF && self.DEA) {
            _MACD = @(2*(self.DIF.floatValue - self.DEA.floatValue));
        }
    }
    return _MACD;
}

#pragma mark RSI线
- (NSNumber *)UPClosePrice {
    if (_UPClosePrice == nil) {
        if (_Close && _Open) {
            _UPClosePrice = @(_Close.floatValue - _Open.floatValue);
        } else {
            _UPClosePrice = @0;
        }
    }
    return _UPClosePrice;
}

- (NSNumber *)RSI7 {
    if (!_RSI7) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 6) {
            if (self.SumOfClosePrice7.floatValue == 0) {
                _RSI7 = @0;
            } else {
                _RSI7 = @(100 * (self.SumOfUPClosePrice7.floatValue / self.SumOfClosePrice7.floatValue));
            }
        }
    }
    return _RSI7;
}

- (NSNumber *)SumOfUPClosePrice7 {
    if (!_SumOfUPClosePrice7) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index > 0) {
            if (self.UPClosePrice.floatValue > 0) {
                _SumOfUPClosePrice7 = @(self.UPClosePrice.floatValue + (7 - 1) * self.PreviousKlineModel.SumOfUPClosePrice7.floatValue / 7);
            } else {
                _SumOfUPClosePrice7 = @((7 - 1) * self.PreviousKlineModel.SumOfUPClosePrice7.floatValue / 7);
            }
        } else {
            if (self.UPClosePrice.floatValue > 0) {
                _SumOfUPClosePrice7 = @(self.UPClosePrice.floatValue);
            } else {
                _SumOfUPClosePrice7 = @0;
            }
        }
    }
    return _SumOfUPClosePrice7;
}

- (NSNumber *)SumOfClosePrice7 {
    if (!_SumOfClosePrice7) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index > 0) {
            _SumOfClosePrice7 = @(ABS(self.UPClosePrice.floatValue) + (7 - 1) * self.PreviousKlineModel.SumOfClosePrice7.floatValue / 7);
        } else {
            _SumOfClosePrice7 = @(ABS(self.UPClosePrice.floatValue));
        }
    }
    return _SumOfClosePrice7;
}

- (NSNumber *)RSI14 {
    if (!_RSI14) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 13) {
            _RSI14 = @(100 * (self.SumOfUPClosePrice14.floatValue / self.SumOfClosePrice14.floatValue));
        }
    }
    return _RSI14;
}

- (NSNumber *)SumOfUPClosePrice14 {
    if (!_SumOfUPClosePrice14) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index > 0) {
            if (self.UPClosePrice.floatValue > 0) {;
                _SumOfUPClosePrice14 = @(self.UPClosePrice.floatValue + (14 - 1) * self.PreviousKlineModel.SumOfUPClosePrice14.floatValue / 14);
            } else {
                _SumOfUPClosePrice14 = @((14 - 1) * self.PreviousKlineModel.SumOfUPClosePrice14.floatValue / 14);
            }
        } else {
            if (self.UPClosePrice.floatValue > 0) {
                _SumOfUPClosePrice14 = @(self.UPClosePrice.floatValue);
            } else {
                _SumOfUPClosePrice14 = @0;
            }
        }
    }
    return _SumOfUPClosePrice14;
}

- (NSNumber *)SumOfClosePrice14 {
    if (!_SumOfClosePrice14) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index > 0) {
            _SumOfClosePrice14 = @(ABS(self.UPClosePrice.floatValue) + (14 - 1) * self.PreviousKlineModel.SumOfClosePrice14.floatValue / 14);
        } else {
            _SumOfClosePrice14 = @(ABS(self.UPClosePrice.floatValue));
        }
    }
    return _SumOfClosePrice14;
}

- (NSNumber *)RSI28 {
    if (!_RSI28) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 27) {
            _RSI28 = @(100 * (self.SumOfUPClosePrice28.floatValue / self.SumOfClosePrice28.floatValue));
        }
    }
    return _RSI28;
}

- (NSNumber *)SumOfUPClosePrice28 {
    if (!_SumOfUPClosePrice28) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index > 0) {
            if (self.UPClosePrice.floatValue > 0) {;
                _SumOfUPClosePrice28 = @(self.UPClosePrice.floatValue + (28 - 1) * self.PreviousKlineModel.SumOfUPClosePrice28.floatValue / 28);
            } else {
                _SumOfUPClosePrice28 = @((28 - 1) * self.PreviousKlineModel.SumOfUPClosePrice28.floatValue / 28);
            }
        } else {
            if (self.UPClosePrice.floatValue > 0) {
                _SumOfUPClosePrice28 = @(self.UPClosePrice.floatValue);
            } else {
                _SumOfUPClosePrice28 = @0;
            }
        }
    }
    return _SumOfUPClosePrice28;
}

- (NSNumber *)SumOfClosePrice28 {
    if (!_SumOfClosePrice28) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index > 0) {
            _SumOfClosePrice28 = @(ABS(self.UPClosePrice.floatValue) + (28 - 1) * self.PreviousKlineModel.SumOfClosePrice28.floatValue / 28);
        } else {
            _SumOfClosePrice28 = @(ABS(self.UPClosePrice.floatValue));
        }
    }
    return _SumOfClosePrice28;
}

#pragma mark BOLL线

- (NSNumber *)BOLL_MB {
    //第20才有BOLL_MB，BOLL_MB拿的是MA（19）
    if(!_BOLL_MB) {
        if (self.MA20) {
            _BOLL_MB = self.MA20;
        }
    }
    return _BOLL_MB;
}

- (NSNumber *)BOLL_MD {
    
    if (!_BOLL_MD) {
        
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        
        if (index >= 19) {
            CGFloat md = 0;
            for (NSInteger i = index - 20 + 1; i < index; i++) {
                Y_KLineModel *temp = [self.ParentGroupModel.models objectAtIndex:i];
                CGFloat diff = temp.Close.floatValue - self.MA20.floatValue;
                md += diff * diff;
            }
            _BOLL_MD = @(sqrt(md / 20));
        }
        
    }
    
    return _BOLL_MD;
}

- (NSNumber *)BOLL_UP {
    if (!_BOLL_UP) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 19) {
            _BOLL_UP = @(self.BOLL_MB.floatValue + 2 * self.BOLL_MD.floatValue);
        }
    }
    
    // ABCCLog(@"lazy:\n_BOLL_UP:%@ -- BOLL_MD:%@",_BOLL_UP,_BOLL_MD);
    
    return _BOLL_UP;
}

- (NSNumber *)BOLL_DN {
    if (!_BOLL_DN) {
        NSInteger index = [self.ParentGroupModel.models indexOfObject:self];
        if (index >= 19) {
            _BOLL_DN = @(self.BOLL_MB.floatValue - 2 * self.BOLL_MD.floatValue);
        }
    }
    
    return _BOLL_DN;
}

//对Model数组进行排序，初始化每个Model的最新9Clock的最低价和最高价
- (void)rangeLastNinePriceByArray:(NSArray<Y_KLineModel *> *)models condition:(NSComparisonResult)cond
{
    switch (cond) {
            //最高价
        case NSOrderedAscending:
        {
//            第一个循环结束后，ClockFirstValue为最小值
            for (NSInteger j = 7; j >= 1; j--)
            {
                if (j >= models.count) {
                    break;
                }
                NSNumber *emMaxValue = @0;
                
                NSInteger em = j;
                while ( em >= 0 )
                {
                    if([emMaxValue compare:models[em].High] == cond)
                    {
                        emMaxValue = models[em].High;
                    }
                    em--;
                }
//                ABCCLog(@"%f",emMaxValue.floatValue);
                models[j].NineClocksMaxPrice = emMaxValue;
            }
            //第一个循环结束后，ClockFirstValue为最小值
            for (NSInteger i = 0, j = 8; j < models.count; i++,j++)
            {
                NSNumber *emMaxValue = @0;
                
                NSInteger em = j;
                
                while ( em >= i )
                {
                    if([emMaxValue compare:models[em].High] == cond)
                    {
                        emMaxValue = models[em].High;
                    }
                    em--;
                }
//                ABCCLog(@"%f",emMaxValue.floatValue);

                models[j].NineClocksMaxPrice = emMaxValue;
            }
        }
            break;
        case NSOrderedDescending:
        {
            //第一个循环结束后，ClockFirstValue为最小值
            
            for (NSInteger j = 7; j >= 1; j--)
            {
                if (j >= models.count) {
                    break;
                }

                NSNumber *emMinValue = @(10000000000);
                
                NSInteger em = j;
                
                while ( em >= 0 )
                {
                    if([emMinValue compare:models[em].Low] == cond)
                    {
                        emMinValue = models[em].Low;
                    }
                    em--;
                }
                models[j].NineClocksMinPrice = emMinValue;
            }
            
            for (NSInteger i = 0, j = 8; j < models.count; i++,j++)
            {
                NSNumber *emMinValue = @(10000000000);
                
                NSInteger em = j;
                
                while ( em >= i )
                {
                    if([emMinValue compare:models[em].Low] == cond)
                    {
                        emMinValue = models[em].Low;
                    }
                    em--;
                }
                models[j].NineClocksMinPrice = emMinValue;
            }
        }
            break;
        default:
            break;
    }
}

- (void)initWithArray:(NSArray *)arr;
{
    NSAssert(arr.count == 6, @"数组长度不足");

    if (self)
    {
        _Date = arr[0];
        _Open = @([arr[1] floatValue]);
        _High = @([arr[2] floatValue]);
        _Low = @([arr[3] floatValue]);  
        _Close = @([arr[4] floatValue]);

        _Volume = [arr[5] floatValue];
//        self.SumOfLastClose = @(_Close.floatValue + self.PreviousKlineModel.SumOfLastClose.floatValue);
//        self.SumOfLastVolume = @(_Volume + self.PreviousKlineModel.SumOfLastVolume.floatValue);
//        ABCCLog(@"%@======%@======%@------%@",_Close,self.MA7,self.MA30,_SumOfLastClose);
 
    }
}

- (void) initWithDict:(NSDictionary *)dict
{
    
    if (self)
    {
        _Date = dict[@"id"];
        _Open = @([dict[@"open"] floatValue]);
        _High = @([dict[@"high"] floatValue]);
        _Low = @([dict[@"low"] floatValue]);
        _Close = @([dict[@"close"] floatValue]);
        _Volume = [dict[@"vol"] floatValue];
//        self.SumOfLastClose = @(_Close.floatValue + self.PreviousKlineModel.SumOfLastClose.floatValue);
//        self.SumOfLastVolume = @(_Volume + self.PreviousKlineModel.SumOfLastVolume.floatValue);
        //        ABCCLog(@"%@======%@======%@------%@",_Close,self.MA7,self.MA30,_SumOfLastClose);
        
    }
}

- (void)initData {
//    [self MA7];
//    [self MA25];
//    [self MA99];
//    [self MA20];
//    [self EMA7];
//    [self EMA25];
//    [self EMA99];
//    [self EMA20];
//    [self EMA12];
//    [self EMA26];
//
//    [self DIF];
//    [self DEA];
//    [self MACD];
//    [self NineClocksMaxPrice];
//    [self NineClocksMinPrice];
//    [self RSV_9];
//    [self KDJ_K];
//    [self KDJ_D];
//    [self KDJ_J];
//
//    [self BOLL_MD];
//    [self BOLL_MB];
//    [self BOLL_UP];
//    [self BOLL_DN];
//    [self BOLL_SUBMD];
//    [self BOLL_SUBMD_SUM];

}


- (NSString *)kLineTypeFormatDate {
    if (!_kLineTypeFormatDate) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.Date.doubleValue];
        NSDateFormatter *formatter = [NSDateFormatter new];
        if (self.ParentGroupModel.defaultKLineType == KLineTypeDay || self.ParentGroupModel.defaultKLineType == KLineTypeWeek) {
            formatter.dateFormat = @"MM/dd";
        }
        else {
            formatter.dateFormat = @"HH:mm";
        }
        _kLineTypeFormatDate = [formatter stringFromDate:date];
    }
    return _kLineTypeFormatDate;
}

- (NSString *)yearFormatDate {
    if (!_yearFormatDate) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:self.Date.doubleValue];
        NSDateFormatter *formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yy-MM-dd HH:mm";
        _yearFormatDate = [formatter stringFromDate:date];
    }
    return _yearFormatDate;
}

- (NSString *)ask_fixed {
    if (!_ask_fixed) {
        if (self.ParentGroupModel.ask_fixed) {
            _ask_fixed = self.ParentGroupModel.ask_fixed;
        }
    }
    return _ask_fixed;
}

- (NSString *)bid_fixed {
    if (!_bid_fixed) {
        if (self.ParentGroupModel.bid_fixed) {
            _bid_fixed = self.ParentGroupModel.bid_fixed;
        }
    }
    return _bid_fixed;
}

- (NSString *)formatLowString {
    if (!_formatLowString) {
        if (!self.bid_fixed) {
            return [NSString stringWithFormat:@"%@",self.Low];
        }
        _formatLowString = [NSString y_stringFromValue:[self.Low stringValue] formatterStyle:Y_NumberFormatterDigitRoundHalfUpStyle digitNumber:self.bid_fixed.intValue digitFixedNumber:-1];
    }
    return _formatLowString;
}

- (NSString *)formatHighString {
    if (!_formatHighString) {
        if (!self.bid_fixed) {
            return [NSString stringWithFormat:@"%@",self.High];
        }
        _formatHighString = [NSString y_stringFromValue:[self.High stringValue] formatterStyle:Y_NumberFormatterDigitRoundHalfUpStyle digitNumber:self.bid_fixed.intValue digitFixedNumber:-1];
    }
    return _formatHighString;
}

- (NSString *)formatOpenString {
    if (!_formatOpenString) {
        if (!self.bid_fixed) {
            return [NSString stringWithFormat:@"%@",self.Open];
        }
        _formatOpenString = [NSString y_stringFromValue:[self.Open stringValue] formatterStyle:Y_NumberFormatterDigitRoundHalfUpStyle digitNumber:self.bid_fixed.intValue digitFixedNumber:-1];
    }
    return _formatOpenString;
}

- (NSString *)formatCloseString {
    if (!_formatCloseString) {
        if (!self.bid_fixed) {
            return [NSString stringWithFormat:@"%@",self.Close];
        }
        _formatCloseString = [NSString y_stringFromValue:[self.Close stringValue] formatterStyle:Y_NumberFormatterDigitRoundHalfUpStyle digitNumber:self.bid_fixed.intValue digitFixedNumber:-1];
    }
    return _formatCloseString;
}

- (NSString *)normalFormat:(NSNumber *)number {
    NSString *targetStr = @"";
    if (!number) {
        targetStr = @"--";
    } else if (self.bid_fixed) {
        targetStr = [NSString y_stringFromValue:[number stringValue] formatterStyle:Y_NumberFormatterDigitRoundHalfUpStyle digitNumber:self.bid_fixed.intValue digitFixedNumber:-1];
    } else {
        targetStr = [NSString stringWithFormat:@"%@",number];
    }
    return targetStr;
}

- (NSString *)placesFormat5:(NSNumber *)number {
    NSString *targetStr = @"";
    if (!number) {
        targetStr = @"--";
    } else {
        targetStr = [NSString y_stringFromValue:[number stringValue] formatterStyle:Y_NumberFormatterDigitRoundHalfUpStyle digitNumber:5 digitFixedNumber:-1];
    }
    return targetStr;
}

- (NSString *)formatMA7String {
    if (!_formatMA7String) {
        _formatMA7String = [self normalFormat:self.MA7];
    }
    return _formatMA7String;
}

- (NSString *)formatMA25String {
    if (!_formatMA25String) {
        _formatMA25String = [self normalFormat:self.MA25];
    }
    return _formatMA25String;
}

- (NSString *)formatMA99String {
    if (!_formatMA99String) {
        _formatMA99String = [self normalFormat:self.MA99];
    }
    return _formatMA99String;
}

- (NSString *)formatEMA7String {
    if (!_formatEMA7String) {
        _formatEMA7String = [self normalFormat:self.EMA7];
    }
    return _formatEMA7String;
}

- (NSString *)formatEMA25String {
    if (!_formatEMA25String) {
        _formatEMA25String = [self normalFormat:self.EMA25];
    }
    return _formatEMA25String;
}

- (NSString *)formatEMA99String {
    if (!_formatEMA99String) {
        _formatEMA99String = [self normalFormat:self.EMA99];
    }
    return _formatEMA99String;
}

- (NSString *)formatBOOL_MBString {
    if (!_formatBOOL_MBString) {
        _formatBOOL_MBString = [self placesFormat5:self.BOLL_MB];
    }
    return _formatBOOL_MBString;
}

- (NSString *)formatBOOL_UPString {
    if (!_formatBOOL_UPString) {
        _formatBOOL_UPString = [self placesFormat5:self.BOLL_UP];
    }
    return _formatBOOL_UPString;
}

- (NSString *)formatBOOL_DNString {
    if (!_formatBOOL_DNString) {
        _formatBOOL_DNString = [self placesFormat5:self.BOLL_DN];
    }
    return _formatBOOL_DNString;
}

- (NSString *)formatMACDString {
    if (!_formatMACDString) {
        _formatMACDString = [self placesFormat5:self.MACD];
    }
    return _formatMACDString;
}

- (NSString *)formatDIFString {
    if (!_formatDIFString) {
        _formatDIFString = [self placesFormat5:self.DIF];
    }
    return _formatDIFString;
}

- (NSString *)formatDEAString {
    if (!_formatDEAString) {
        _formatDEAString = [self placesFormat5:self.DEA];
    }
    return _formatDEAString;
}

- (NSString *)formatKDJ_KString {
    if (!_formatKDJ_KString) {
        _formatKDJ_KString = [self placesFormat5:self.KDJ_K];
    }
    return _formatKDJ_KString;
}

- (NSString *)formatKDJ_DString {
    if (!_formatKDJ_DString) {
        _formatKDJ_DString = [self placesFormat5:self.KDJ_D];
    }
    return _formatKDJ_DString;
}

- (NSString *)formatKDJ_JString {
    if (!_formatKDJ_JString) {
        _formatKDJ_JString = [self placesFormat5:self.KDJ_J];
    }
    return _formatKDJ_JString;
}

- (NSString *)formatRSI7String {
    if (!_formatRSI7String) {
        _formatRSI7String = [self placesFormat5:self.RSI7];
    }
    return _formatRSI7String;
}

- (NSString *)formatRSI14String {
    if (!_formatRSI14String) {
        _formatRSI14String = [self placesFormat5:self.RSI14];
    }
    return _formatRSI14String;
}

- (NSString *)formatRSI28String {
    if (!_formatRSI28String) {
        _formatRSI28String = [self placesFormat5:self.RSI28];
    }
    return _formatRSI28String;
}

- (NSString *)formatVolumeString {
    if (!_formatVolumeString) {
        _formatVolumeString = [NSString y_stringFromValue:[[NSNumber numberWithFloat:self.Volume] stringValue] formatterStyle:Y_NumberFormatterDecimalStyle digitNumber:-1 digitFixedNumber:-1];
    }
    return _formatVolumeString;
}

- (NSString *)priceChangeAmountString {
    if (!_priceChangeAmountString) {
        NSNumber *priceChangeAmountNumber = [NSNumber numberWithDouble:(self.Close.doubleValue - self.Open.doubleValue)];
        if (self.bid_fixed) {
            _priceChangeAmountString = [NSString y_stringFromValue:[priceChangeAmountNumber stringValue] formatterStyle:Y_NumberFormatterDigitRoundHalfUpStyle digitNumber:self.bid_fixed.intValue digitFixedNumber:-1];
        }
        else {
            return [NSString y_stringFromValue:[priceChangeAmountNumber stringValue] formatterStyle:Y_NumberFormatterDecimalStyle digitNumber:-1 digitFixedNumber:-1];
        }
    }
    return _priceChangeAmountString;
}

- (NSString *)priceChangeRatioString {
    if (!_priceChangeRatioString) {
        double priceChangeAmount = self.Close.doubleValue - self.Open.doubleValue;
        CGFloat priceChangeRatio = priceChangeAmount / self.Open.doubleValue * 100;
        _priceChangeRatioString = [NSString stringWithFormat:@"%.2f%%", priceChangeRatio];
    }
    return _priceChangeRatioString;
}

@end
