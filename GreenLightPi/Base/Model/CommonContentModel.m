//
//  CommonContentModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "CommonContentModel.h"
#import "FileEntityModel.h"

@implementation CommonContentModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"commentList" : @"CommonContentCommentModel",
             @"imagelist" : @"FileEntityModel",
             };
}
@end


@implementation CommonContentCommentModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"children" : @"CommonContentCommentModel",
             @"imageList" : @"FileEntityModel",
             };
}
@end


