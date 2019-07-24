//
//  HomeModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/21.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HomeModel.h"

@implementation HomeModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"content_id" : @"id"
             };
}
@end
