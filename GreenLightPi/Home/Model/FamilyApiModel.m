//
//  FamilyApiModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/2.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "FamilyApiModel.h"

@implementation FamilyApiModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"familyMembers" : @"FamilyMemberApiModel",
             };
}
@end


@implementation FamilyMemberApiModel

@end
