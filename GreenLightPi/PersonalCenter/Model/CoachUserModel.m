//
//  CoachUserModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/27.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "CoachUserModel.h"
#import "FcCoursesModel.h"

@implementation CoachUserModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"coursesList" : @"FcCoursesModel",
             @"albumList" : @"FcCoursesModel",
             };
}
@end
