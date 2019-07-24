//
//  QuestionResultModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/13.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "QuestionResultModel.h"
#import "FileEntityModel.h"

@implementation QuestionResultModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"imagelist" : @"FileEntityModel",
             };
}
@end
