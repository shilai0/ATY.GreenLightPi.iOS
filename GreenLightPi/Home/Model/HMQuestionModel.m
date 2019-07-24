//
//  HMQuestionModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/1.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HMQuestionModel.h"
#import "FileEntityModel.h"

@implementation HMQuestionModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"imagelist" : @"FileEntityModel",
             };
}
@end
