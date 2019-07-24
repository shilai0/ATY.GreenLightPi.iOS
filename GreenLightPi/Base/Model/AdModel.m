//
//  AdModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/22.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "AdModel.h"
#import "FileEntityModel.h"

@implementation AdModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"filelist" : @"FileEntityModel",
             };
}
@end
