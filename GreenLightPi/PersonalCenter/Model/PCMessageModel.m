//
//  PCMessageModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/3.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMessageModel.h"

@implementation PCMessageModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"userMessageList" : @"UserMessageModel",
             @"sysMessageList" : @"SysMessageModel",
             @"businessMessageList" : @"BusinessMessageModel",
             };
}
@end

@implementation UserMessageModel
MJCodingImplementation
@end

@implementation SysMessageModel
MJCodingImplementation
@end

@implementation BusinessMessageModel
MJCodingImplementation
@end
