//
//  CardTypeBaseApiModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/12/26.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "CardTypeBaseApiModel.h"

@implementation CardTypeBaseApiModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"cardList" : @"StoreCardApiModel",
             };
}
@end

@implementation StoreCardApiModel

@end
