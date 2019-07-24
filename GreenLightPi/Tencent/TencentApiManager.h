//
//  TencentApiManager.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface TencentApiManager : NSObject<TencentSessionDelegate>
@property (nonatomic, strong) TencentOAuth *tencentOAuth;
+ (instancetype)sharedManager;
@end
