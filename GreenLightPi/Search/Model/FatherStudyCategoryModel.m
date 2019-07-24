//
//  FatherStudyCategoryModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/3.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FatherStudyCategoryModel.h"

@implementation FatherStudyCategoryModel

@end

@implementation FatherStudyThemeModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"contentList" : [FatherStudyContentModel class],
             };
}
@end

@implementation FatherStudyContentModel

@end
