//
//  SearchArticleModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/10/24.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "SearchArticleModel.h"
#import "HomeListModel.h"

@implementation SearchArticleModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"data" : @"HomeListModel",
             };
}
@end
