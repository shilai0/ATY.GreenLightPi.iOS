//
//  UserBaseModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 user_id (integer, optional): 用户编号 ,
 phone (string, optional): 手机号码 ,
 name (string, optional): 姓名 ,
 token (string, optional): 用户令牌 ,
 is_enable (integer, optional): 是否启用 1为启用 0为禁用 ,
 ctime (string, optional): 创建时间 ,
 utime (string, optional): 修改时间 ,
 grade (GradeModel, optional): 组别 ,
 userType (string, optional): 用户类型 ,
 isFollow (integer, optional): 是否关注 ,
 image (FileEntityModel, optional): 头像 ,
 resume (string, optional): 简介 ,
 nikeName (string, optional): 昵称 ,
 label (string, optional): 标签：自填（绘本、教具）
 */
@class GradeModel,FileEntityModel;
@interface UserBaseModel : NSObject
@property (nonatomic, copy) NSNumber *user_id;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSNumber *is_enable;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *utime;
@property (nonatomic, strong) GradeModel *grade;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSNumber *isFollow;
@property (nonatomic, strong) FileEntityModel *image;
@property (nonatomic, copy) NSString *resume;
@property (nonatomic, copy) NSString *nikeName;
@property (nonatomic, copy) NSString *label;
@end

