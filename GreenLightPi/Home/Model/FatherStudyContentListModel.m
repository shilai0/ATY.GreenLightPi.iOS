//
//  FatherStudyContentListModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FatherStudyContentListModel.h"
#import "FatherStudyCategoryModel.h"

@implementation FatherStudyContentListModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"contentList" : [FatherStudyContentModel class],
             @"ageGroupList" : [AgeGroupModel class],
             };
}
@end

//@implementation FatherStudyContentModel
//
//@end

@implementation AgeGroupModel

@end
