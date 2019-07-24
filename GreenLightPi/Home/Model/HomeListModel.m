//
//  HomeListModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HomeListModel.h"
#import "FileEntityModel.h"

@implementation HomeListModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"imageList" : @"FileEntityModel",
             @"commentlist" : @"ArticleCommentModel",
             };
}

@end

@implementation ArticleTypeModel

@end

@implementation ArticleCommentModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"children" : @"ArticleCommentModel",
             };
}
@end


