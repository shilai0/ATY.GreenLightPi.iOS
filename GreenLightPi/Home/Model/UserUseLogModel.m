//
//  UserUseLogModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/2.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "UserUseLogModel.h"

@implementation UserUseLogModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"useLogModels" : @"UseLogModel",
             };
}
@end

@implementation UseLogModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"useDetails" : @"UseDetailModel",
             };
}
@end

@implementation UseDetailModel

@end
