//
//  HMQuestionCommentModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/21.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HMQuestionCommentModel.h"
#import "FileEntityModel.h"

@implementation HMQuestionCommentModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"imageList" : @"FileEntityModel",
             };
}
@end
