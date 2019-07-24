//
//  SearchVideoModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/10/24.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "SearchVideoModel.h"
#import "FcCoursesModel.h"

@implementation SearchVideoModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"data" : @"FcCoursesModel",
             };
}
@end
