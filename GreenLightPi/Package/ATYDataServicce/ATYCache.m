//
//  ATYCache.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "ATYCache.h"
#import <YYCache/YYCache.h>

static NSString *const atyCache = @"aty_Cache";
static YYCache *_dataCache;

@implementation ATYCache

+ (void)initialize {
    [super initialize];
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dataCache = [[YYCache alloc]initWithName:atyCache];
    });
}

// 存储
+ (void)saveDataCache:(id)data forKey:(NSString *)key {
    [_dataCache setObject:data forKey:key];
}

// 读取缓存
+ (id)readCache:(NSString *)key {
    return [_dataCache objectForKey:key];
}

// 获取缓存总大小
+ (void)getAllCacheSize {
    unsigned long long diskCache = [_dataCache.diskCache totalCost];
    NSLog(@"%llu", diskCache);
}

// 删除指定缓存
+ (void)removeChache:(NSString *)key {
    [_dataCache removeObjectForKey:key withBlock:nil];
}

// 删除全部缓存
+ (void)removeAllCache {
    [_dataCache removeAllObjects];
}

@end
