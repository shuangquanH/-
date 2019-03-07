//
//  SQDataCache.m
//  SQAPPSTART
//
//  Created by apple on 2018/4/25.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "SQDataCache.h"
#import "YYCache.h"

static YYCache      *cacheDataManager;//存储数据
static YYKVStorage  *cacheFileManager;//存储文件

@implementation SQDataCache

+ (void)initialize {
    cacheDataManager = [YYCache cacheWithName:KCACHEKEY];
    NSString *downloadDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    cacheFileManager  = [[YYKVStorage alloc] initWithPath:downloadDir type: YYKVStorageTypeFile];
}


+ (void)saveTopContentList:(NSArray    *)arr forContentType:(NSString  *)type {
    if (arr.count>0) {
        NSArray  *tempArr = [NSArray array];
        NSArray *cacheArr = [self getContentListWithContentType:type];
        
        tempArr = [arr arrayByAddingObjectsFromArray:cacheArr];
        if (tempArr.count>KCACHMAX) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
            [cacheDataManager setObject:data forKey:type];
        } else {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tempArr];
            [cacheDataManager setObject:data forKey:type];
        }
    }
}

+ (void)saveBottomContentList:(NSArray    *)arr forContentType:(NSString  *)type {
    if (arr.count>0) {
        NSArray  *tempArr = [NSArray array];
        NSArray *cacheArr = [self getContentListWithContentType:type];
        tempArr = [cacheArr arrayByAddingObjectsFromArray:arr];
        if (tempArr.count<KCACHMAX) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tempArr];
            [cacheDataManager setObject:data forKey:type];
        }
    }
}


/** 根据type值获取本地缓存的内容列表数组 */
+ (NSArray  *)getContentListWithContentType:(NSString   *)type {
    NSData  *cacheData = (NSData    *)[cacheDataManager objectForKey:type];
    if (cacheData) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:cacheData];
    } else {
        return nil;
    }
}
/** 根据type值删除本地缓存的内容列表 */
+ (void)deleteContentListWithContentType:(NSString  *)type {
    [cacheDataManager removeObjectForKey:type];
}
/** 删除缓存的所有数据 */
+ (void)deleteAllCache {
    [cacheDataManager removeAllObjects];
}

@end
