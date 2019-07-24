//
//  UserModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/17.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 userdtl (UserDtlModel, optional): 用户详情 ,
 coachUser (FcCoachModel, optional): 教练模型 ,
 businessUser (BusinessUserModel, optional),
 user_id (integer, optional): 用户编号 ,
 phone (string, optional): 手机号码 ,
 name (string, optional): 姓名 ,
 token (string, optional): 用户令牌 ,
 is_enable (integer, optional): 是否启用 1为启用 0为禁用 ,
 ctime (string, optional): 创建时间 ,
 utime (string, optional): 修改时间 ,
 grade (GradeModel, optional): 组别 ,
 userType (string, optional): 用户类型 ,
 isFollow (integer, optional): 是否关注
 image (FileEntityModel, optional): 头像 ,
 resume (string, optional): 简介 ,
 nikeName (string, optional): 昵称 ,
 label (string, optional): 标签：自填（绘本、教具）
 **/
@class GradeModel,UserDtlModel,AreaModel,FileEntityModel,FcCoachModel,BusinessUserModel,BusinessDtlModel,StoreModel,FcAlbumModel,FcCoursesModel;
@interface UserModel : NSObject
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSNumber *is_enable;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *utime;
@property (nonatomic, strong) GradeModel *grade;
@property (nonatomic, strong) UserDtlModel *userdtl;
@property (nonatomic, strong) FcCoachModel *coachUser;
@property (nonatomic, strong) BusinessUserModel *businessUser;
@property (nonatomic, copy) NSNumber *user_id;
@property (nonatomic, copy) NSNumber *isFollow;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, strong) FileEntityModel *image;
@property (nonatomic, copy) NSString *resume;
@property (nonatomic, copy) NSString *nikeName;
@property (nonatomic, copy) NSString *label;
@end


/**
 grade_id (integer, optional): 组别id ,
 grade_name (string, optional): 组别名 ,
 sort_no (integer, optional): 排序 ,
 ctime (string, optional): 创建时间 ,
 utime (string, optional): 修改时间,
 description (string, optional): 用户组描述信息 ,
 userRole (Array[string], optional): 用户角色 对应数据库里的组别名字段alias 作用：商家前端判断权限用,已数组形式返回和前端匹配 ,
 userType (string): 组类型 ,
 alias (string, optional): 组别名 ,
 perssions (string, optional): 用户组权限 ,
 isUsed (boolean, optional): 分组是否被使用
 **/
@interface GradeModel : NSObject
@property (nonatomic, copy) NSNumber *grade_id;
@property (nonatomic, copy) NSString *grade_name;
@property (nonatomic, copy) NSNumber *sort_no;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *utime;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSArray *userRole;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSString *alias;
@property (nonatomic, copy) NSString *perssions;
@property (nonatomic, copy) NSNumber *boolean;
@end

/**
 userdtl_id (integer, optional): 详情编号 ,
 image (FileEntityModel, optional): 用户头像 ,
 resume (string, optional): 个人简介 ,
 birthday (string, optional): 出生日期 ,
 sex (integer, optional): 性别 = ['0', '1'],
 profession (string, optional): 职业 ,
 area (AreaModel, optional): 所在地区 ,
 ctime (string, optional): 创建时间 ,
 utime (string, optional): 修改时间 ,
 referee (string, optional): 推荐人
 **/
@interface UserDtlModel : NSObject
@property (nonatomic, copy) NSNumber *userdtl_id;
@property (nonatomic, strong) FileEntityModel *image;
@property (nonatomic, copy) NSString *resume;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSNumber *sex;
@property (nonatomic, copy) NSString *profession;
@property (nonatomic, strong) AreaModel *area;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *utime;
@property (nonatomic, copy) NSString *referee;
@end

/**
 area_id (integer, optional): 地区编号 ,
 fid (integer, optional): 父id ,
 area_name (string, optional): 地区名 ,
 grade (integer, optional): 级别 ,
 is_enable (integer, optional): 是否启用 1启用 0禁用 ,
 ctime (string, optional): 创建时间 ,
 utime (string, optional): 修改时间 ,
 areas (Array[AreaModel], optional): 所包含的地区的集合
 **/
@interface AreaModel : NSObject
@property (nonatomic, copy) NSNumber *area_id;
@property (nonatomic, copy) NSNumber *fid;
@property (nonatomic, copy) NSString *area_name;
@property (nonatomic, copy) NSNumber *grade;
@property (nonatomic, copy) NSNumber *is_enable;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *utime;
@property (nonatomic, strong) NSArray *areas;
@end

/**
 coachName (string, optional): 教练姓名 ,
 introduce (string, optional): 介绍 ,
 image (FileEntityModel, optional): 用户头像 ,
 category (string, optional): 教练分类 ,
 label (string, optional): 标签：自填（绘本、教具） ,
 fansCount (integer, optional): 粉丝数 ,
 worksCount (integer, optional): 作品数量 ,
 fcAlbums (Array[FcAlbumModel], optional): 专辑
 **/
@interface FcCoachModel : NSObject
@property (nonatomic, copy) NSString *coachName;
@property (nonatomic, copy) NSString *introduce;
@property (nonatomic, strong) FileEntityModel *image;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSNumber *fansCount;
@property (nonatomic, copy) NSNumber *worksCount;
@property (nonatomic, copy) NSArray *fcAlbums;
@end

/**
 userDtl (BusinessDtlModel, optional),
 user_id (integer, optional): 用户编号 ,
 phone (string, optional): 手机号码 ,
 name (string, optional): 姓名 ,
 token (string, optional): 用户令牌 ,
 is_enable (integer, optional): 是否启用 1为启用 0为禁用 ,
 ctime (string, optional): 创建时间 ,
 utime (string, optional): 修改时间 ,
 grade (GradeModel, optional): 组别 ,
 userType (string, optional): 用户类型 ,
 isFollow (integer, optional): 是否关注
 **/
@interface BusinessUserModel : NSObject
@property (nonatomic, strong) BusinessDtlModel *userDtl;
@property (nonatomic, copy) NSNumber *user_id;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSNumber *is_enable;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *utime;
@property (nonatomic, strong) GradeModel *grade;
@property (nonatomic, copy) NSString *userType;
@property (nonatomic, copy) NSNumber *isFollow;
@end

/**
 store (StoreModel, optional): 所属店铺 ,
 userdtl_id (integer, optional): 详情编号 ,
 image (FileEntityModel, optional): 用户头像 ,
 ctime (string, optional): 创建时间 ,
 utime (string, optional): 修改时间
 **/
@interface BusinessDtlModel : NSObject
@property (nonatomic, strong) StoreModel *store;
@property (nonatomic, copy) NSNumber *userdtl_id;
@property (nonatomic, strong) FileEntityModel *image;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *utime;
@end

/**
 album_id (integer, optional): 专辑 ,
 content (string, optional): 内容 ,
 label (string, optional): 标签 ,
 file (FileEntityModel, optional): 封面图 ,
 title (string, optional): 标题 ,
 dt_file (FileEntityModel, optional): 详细图 ,
 fcCoursesModels (Array[FcCoursesModel], optional): 专辑包含的课程集合 ,
 collectCount (integer, optional): 集数 ,
 watchRecord (string, optional): 阅读记录（1千+ 1万+ 12万+）
 **/
@interface FcAlbumModel : NSObject
@property (nonatomic, copy) NSNumber *album_id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *label;
@property (nonatomic, strong) FileEntityModel *file;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) FileEntityModel *dt_file;
@property (nonatomic, strong) NSArray *fcCoursesModels;
@property (nonatomic, copy) NSNumber *collectCount;
@property (nonatomic, copy) NSString *watchRecord;
@end
