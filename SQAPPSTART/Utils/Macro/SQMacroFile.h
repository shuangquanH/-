//
//  SQMacroFile.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//


//所有的宏定义 放在该文件

#ifndef SQMacroFile_h
#define SQMacroFile_h
#endif /* SQMacroFile_h */

/** 打印方法（只会在Debug环境下会打印） */
#ifndef __OPTIMIZE__
#define SQLog(...) NSLog(__VA_ARGS__)
#else
# define NSLog(...) {}
#endif
#import "UIColor+Y_StockChart.h"



/**弱引用weakself*/
#define WeakSelf(weakSelf)  __weak __typeof(&*self)weakSelf = self;

/** 屏幕宽度 */
#define KAPP_WIDTH          ([SQIphonePx shareInstance].phoneWidth)
/** 屏幕高度 */
#define KAPP_HEIGHT         ([SQIphonePx shareInstance].phoneHeight)
/** 导航栏高度 */
#define KNAV_HEIGHT         ([SQIphonePx shareInstance].navHeight)
/** Tabbar高度 */
#define KTAB_HEIGHT         ([SQIphonePx shareInstance].tabHeight)
/** 状态栏高度 */
#define KSTATU_HEIGHT       ([SQIphonePx shareInstance].statuHeight)
/** 是否是iPhoneX */
#define KISX                ([SQIphonePx shareInstance].isiPhoneX)
/** ui缩放比例 */
#define KSCAL(a)            ([SQIphonePx shareInstance].uiScaling*a)
#define KMARGIN             15

/** 字体大小 */
#define KFONT(a)            [UIFont systemFontOfSize:KSCAL(a)]
#define KSYSFONT(a)         [UIFont systemFontOfSize:a]


/** app主色调 */
#define KCOLOR_MAIN         [UIColor hexStringToColor:@"43c5ff"]
/** 白色 */
#define KCOLOR_WHIT         [UIColor hexStringToColor:@"ffffff"]
/** 黑色 */
#define KCOLOR_BLACK        [UIColor hexStringToColor:@"333333"]
#define KCOLOR_LINE         [UIColor hexStringToColor:@"999999"]

#define kCOLOR_999          [UIColor hexStringToColor:@"999999"]
/** 浅灰背景颜色  */
#define KCOLOR_LIGHTBACK    [UIColor hexStringToColor:@"F0F0F0"]

/** K线图下跌颜色 */
#define KCOLOR_KLOW         [UIColor decreaseColor]
/** K线图上涨颜色 */
#define KCOLOR_KUP          [UIColor increaseColor]

    
    

/** 颜色(传string格式) */
#define KCOLOR(a)           [UIColor hexStringToColor:a]
/** 颜色和透明度(颜色为string格式，透明度为float格式) */
#define KCOLOR_ALPHA(a,b)   [UIColor hexStringToColor:a andAlpha:b]


/** 系统版本 */
#define KiOS9_1Later        ([UIDevice currentDevice].systemVersion.floatValue >= 9.1f)
#define KiOS11Later         ([UIDevice currentDevice].systemVersion.floatValue >= 11.0f)



