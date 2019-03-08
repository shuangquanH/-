//
//  Y-KlineModel.h
//  BTC-Kline
//
//  Created by yate1996 on 16/4/28.
//  Copyright © 2016年 yate1996. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Y_KLineGroupModel;

@interface Y_KLineModel : NSObject

#pragma 外部初始化

/**
 *  前一个Model
 */
@property (nonatomic, weak) Y_KLineModel *PreviousKlineModel;

/**
 *  父ModelArray:用来给当前Model索引到Parent数组
 */

@property (nonatomic, weak) Y_KLineGroupModel *ParentGroupModel;


/**
 *  日期
 */
@property (nonatomic, copy) NSString *Date;

/**
 *  开盘价
 */
@property (nonatomic, copy) NSNumber *Open;


/**
 *  收盘价
 */
//@property (nonatomic, assign) CGFloat Close;
@property (nonatomic, copy) NSNumber *Close;

/**
 *  最高价
 */
//@property (nonatomic, assign) CGFloat High;
@property (nonatomic, copy) NSNumber *High;

/**
 *  最低价
 */
//@property (nonatomic, assign) CGFloat Low;
@property (nonatomic, copy) NSNumber *Low;

/**
 *  成交量
 */
@property (nonatomic, assign) CGFloat Volume;

#pragma 内部自动初始化


/**
 *  该Model及其之前所有收盘价之和
 */
@property (nonatomic, copy) NSNumber *SumOfLastClose;

/**
 *  该Model及其之前所有成交量之和
 */
@property (nonatomic, copy) NSNumber *SumOfLastVolume;

//移动平均数分为MA（简单移动平均数）和EMA（指数移动平均数），其计算公式如下：［C为收盘价，N为周期数］：
//MA（N）=（C1+C2+……CN）/N
@property (nonatomic, copy) NSNumber *MA7;

@property (nonatomic, copy) NSNumber *MA25;

@property (nonatomic, copy) NSNumber *MA99;

@property (nonatomic, copy) NSNumber *MA20;

@property (nonatomic, copy) NSNumber *MA12;

@property (nonatomic, copy) NSNumber *MA26;
#pragma 第一个EMA等于MA;即EMA(n) = MA(n)

// EMA（N）=2/（N+1）*（C-昨日EMA）+昨日EMA；
@property (nonatomic, copy) NSNumber *EMA7;

@property (nonatomic, copy) NSNumber *EMA25;

@property (nonatomic, copy) NSNumber *EMA99;

@property (nonatomic, copy) NSNumber *EMA20;

#pragma BOLL线

// 标准差 二次方根【 下的 (n-1)天的 C-MA二次方 和】
@property (nonatomic, copy) NSNumber *BOLL_MD;

// n-1 天的 MA
@property (nonatomic, copy) NSNumber *BOLL_MB;

// MB + k * MD
@property (nonatomic, copy) NSNumber *BOLL_UP;

// MB - k * MD
@property (nonatomic, copy) NSNumber *BOLL_DN;

//  n 个 ( Cn - MA20)的平方和
@property (nonatomic, copy) NSNumber *BOLL_SUBMD_SUM;

// 当前的 ( Cn - MA20)的平方
@property (nonatomic, copy) NSNumber *BOLL_SUBMD;


//MACD主要是利用长短期的二条平滑平均线，计算两者之间的差离值，作为研判行情买卖之依据。MACD指标是基于均线的构造原理，对价格收盘价进行平滑处 理(求出算术平均值)后的一种趋向类指标。它主要由两部分组成，即正负差(DIF)、异同平均数(DEA)，其中，正负差是核心，DEA是辅助。DIF是 快速平滑移动平均线(EMA1)和慢速平滑移动平均线(EMA2)的差。

//在现有的技术分析软件中，MACD常用参数是快速平滑移动平均线为12，慢速平滑移动平均线参数为26。此外，MACD还有一个辅助指标——柱状线 (BAR)。在大多数技术分析软件中，柱状线是有颜色的，在低于0轴以下是绿色，高于0轴以上是红色，前者代表趋势较弱，后者代表趋势较强。

//MACD(12,26.9),下面以该参数为例说明计算方法。


//12日EMA的算式为
//EMA（12）=昨日EMA（12）*11/13+C*2/13＝(C－昨日的EMA)×0.1538＋昨日的EMA；   即为MACD指标中的快线-快速平滑移动平均线；
//26日EMA的算式为
//EMA（26）=昨日EMA（26）*25/27+C*2/27；   即为MACD指标中的慢线-慢速平滑移动平均线；

//DIF=EMA（12）-EMA（26）         DIF的值即为红绿柱；
@property (nonatomic, copy) NSNumber *EMA12;
@property (nonatomic, copy) NSNumber *EMA26;
@property (nonatomic, copy) NSNumber *DIF;

//今日的DEA值（即MACD值）=前一日DEA*8/10+今日DIF*2/10.
@property (nonatomic, copy) NSNumber *DEA;

//EMA（12）=昨日EMA（12）*11/13+C*2/13；   即为MACD指标中的快线；
//EMA（26）=昨日EMA（26）*25/27+C*2/27；   即为MACD指标中的慢线；
@property (nonatomic, copy) NSNumber *MACD;


@property (nonatomic, copy) NSNumber *RSI7;
@property (nonatomic, copy) NSNumber *SumOfUPClosePrice7;
@property (nonatomic, copy) NSNumber *SumOfClosePrice7;
@property (nonatomic, copy) NSNumber *RSI14;
@property (nonatomic, copy) NSNumber *SumOfUPClosePrice14;
@property (nonatomic, copy) NSNumber *SumOfClosePrice14;
@property (nonatomic, copy) NSNumber *RSI28;
@property (nonatomic, copy) NSNumber *SumOfUPClosePrice28;
@property (nonatomic, copy) NSNumber *SumOfClosePrice28;

/**
 *  9Clock内最低价
 */
@property (nonatomic, copy) NSNumber *NineClocksMinPrice;


/**
 *  9Clock内最高价
 */
@property (nonatomic, copy) NSNumber *NineClocksMaxPrice;

/**
 *  上升
 */
@property (nonatomic, copy) NSNumber *UPClosePrice;


/**
 *  下降
 */
@property (nonatomic, copy) NSNumber *DownClosePrice;

//KDJ(9,3.3),下面以该参数为例说明计算方法。
//9，3，3代表指标分析周期为9天，K值D值为3天
//RSV(9)=（今日收盘价－9日内最低价）÷（9日内最高价－9日内最低价）×100
//K(3日)=（当日RSV值+2*前一日K值）÷3
//D(3日)=（当日K值+2*前一日D值）÷3
//J=3K－2D
@property (nonatomic, copy) NSNumber *RSV_9;

@property (nonatomic, copy) NSNumber *KDJ_K;

@property (nonatomic, copy) NSNumber *KDJ_D;

@property (nonatomic, copy) NSNumber *KDJ_J;

#pragma 外部使用的format数据

/**
 根据K线图类型返回的日期
 */
@property (nonatomic, copy) NSString *kLineTypeFormatDate;

/**
 yy-MM-dd HH:mm格式日期
 */
@property (nonatomic, copy) NSString *yearFormatDate;

/**
 K线图精度
 */
@property (nonatomic, copy) NSString *ask_fixed;
@property (nonatomic, copy) NSString *bid_fixed;
@property (nonatomic, copy) NSString *formatOpenString;
@property (nonatomic, copy) NSString *formatCloseString;
@property (nonatomic, copy) NSString *formatHighString;
@property (nonatomic, copy) NSString *formatLowString;
@property (nonatomic, copy) NSString *formatVolumeString;
@property (nonatomic, copy) NSString *priceChangeAmountString;
@property (nonatomic, copy) NSString *priceChangeRatioString;

@property (nonatomic, copy) NSString *formatMA7String;
@property (nonatomic, copy) NSString *formatMA25String;
@property (nonatomic, copy) NSString *formatMA99String;
@property (nonatomic, copy) NSString *formatEMA7String;
@property (nonatomic, copy) NSString *formatEMA25String;
@property (nonatomic, copy) NSString *formatEMA99String;
@property (nonatomic, copy) NSString *formatBOOL_MBString;
@property (nonatomic, copy) NSString *formatBOOL_UPString;
@property (nonatomic, copy) NSString *formatBOOL_DNString;

@property (nonatomic, copy) NSString *formatMACDString;
@property (nonatomic, copy) NSString *formatDIFString;
@property (nonatomic, copy) NSString *formatDEAString;
@property (nonatomic, copy) NSString *formatKDJ_KString;
@property (nonatomic, copy) NSString *formatKDJ_DString;
@property (nonatomic, copy) NSString *formatKDJ_JString;
@property (nonatomic, copy) NSString *formatRSI7String;
@property (nonatomic, copy) NSString *formatRSI14String;
@property (nonatomic, copy) NSString *formatRSI28String;


//初始化Model
- (void)initWithArray:(NSArray *)arr;

- (void)initWithDict:(NSDictionary *)dict;

//初始化其他数据
- (void)initData ;

@end
