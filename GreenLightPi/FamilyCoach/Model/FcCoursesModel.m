//
//  FcCoursesModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/9.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FcCoursesModel.h"
#import "FileEntityModel.h"

@implementation FcCoursesModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"imageList" : [FileEntityModel class],
             @"consumptionDetails" : [FcCoursesDetailModel class],
             @"comments" : [FcCommentModel class],
             };
}
@end

@implementation FcClassifyModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"classifys" : [FcClassifyModel class],
             };
}
@end

@implementation FcCoursesDetailModel

@end

@implementation FcCommentModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"comments" : [FcCommentModel class],
             };
}
@end
