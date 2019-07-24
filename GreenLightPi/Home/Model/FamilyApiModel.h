//
//  FamilyApiModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/2.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 familyId (integer, optional): 家庭群id ,
 familyName (string, optional): 群名称,默认创建者的昵称 ,
 userId (integer, optional): 创建者 ,
 familyMembers (Array[FamilyMemberApiModel], optional): 家庭成员集合
 */

@interface FamilyApiModel : NSObject
@property (nonatomic, assign) NSInteger familyId;
@property (nonatomic, copy) NSString *familyName;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSArray *familyMembers;
@end

/**
 memberId (integer, optional): 成员id ,
 familyId (integer, optional): 所属群id ,
 name (string, optional): 用户名 ,
 imagePath (string, optional): 头像 ,
 ctime (string, optional): 加入时间 ,
 relationRemark (string, optional): 关系说明（宝宝的爸爸，妈妈，爷爷，奶奶，外公，外婆，其他） ,
 relationCode (string, optional): 关系枚举值
 */
@interface FamilyMemberApiModel : NSObject
@property (nonatomic, assign) NSInteger memberId;
@property (nonatomic, assign) NSInteger familyId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *relationRemark;
@property (nonatomic, copy) NSString *relationCode;
@property (nonatomic, assign) NSInteger userId;
@end

