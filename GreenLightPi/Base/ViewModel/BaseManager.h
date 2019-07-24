//
//  BaseManager.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BaseTabBarViewController;

@interface BaseManager : NSObject

@property (nonatomic, strong) BaseTabBarViewController *rootViewController;

/** 单例初始化 */
+ (BaseManager *)instance;


@end
