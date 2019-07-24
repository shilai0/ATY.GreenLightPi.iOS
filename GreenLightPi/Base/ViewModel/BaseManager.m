//
//  BaseManager.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseManager.h"


@implementation BaseManager

+ (BaseManager *)instance {
    static BaseManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BaseManager alloc] init];
    });
    return instance;
}

#pragma mark -获取登录/注册手机号
+ (NSString *)xs_getLoginOrRegistryTelephone {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:PROJECT_PHONE];
}


@end
