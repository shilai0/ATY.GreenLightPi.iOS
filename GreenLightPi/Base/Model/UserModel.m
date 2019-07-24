//
//  UserModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/17.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "UserModel.h"
#import "FcCoursesModel.h"

@implementation UserModel
MJCodingImplementation
@end

@implementation GradeModel
MJCodingImplementation
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"Description" : @"description"
             };
}
@end

@implementation UserDtlModel
MJCodingImplementation
@end

@implementation AreaModel
MJCodingImplementation
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"areas" : @"AreaModel",
             };
}
@end

@implementation FcCoachModel
MJCodingImplementation
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"fcAlbums" : [FcAlbumModel class],
             };
}
@end

@implementation BusinessUserModel
MJCodingImplementation
@end

@implementation BusinessDtlModel
MJCodingImplementation
@end

@implementation FcAlbumModel
MJCodingImplementation
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"fcCoursesModels" : [FcCoursesModel class],
             };
}
@end
