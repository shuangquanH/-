//
//  SQDataCache.h
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQDataCache : NSObject

/** 缓存列表数据 并设置type值 */
+ (void)saveTopContentList:(NSArray    *)arr forContentType:(NSString  *)type;//存放在头部
+ (void)saveBottomContentList:(NSArray    *)arr forContentType:(NSString  *)type;//存放在尾部


/** 根据type值获取本地缓存的内容列表数组 */
+ (NSArray  *)getContentListWithContentType:(NSString   *)type;
/** 根据type值删除本地缓存的内容列表 */
+ (void)deleteContentListWithContentType:(NSString  *)type;


/** 删除缓存的所有数据 */
+ (void)deleteAllCache;

@end
