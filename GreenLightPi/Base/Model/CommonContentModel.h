//
//  CommonContentModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 参数说明：moduleType 0：首页 1：爸爸书房 2：好家长 3：一家老小 4：基因检测 5：首页问答
 **/

/**
 content_id (integer, optional): 文章id ,
 title (string, optional): 标题 ,
 user (UserModel, optional): 作者 ,
 business_brand_name (string, optional): 商家品牌名称 ,
 summarize (string, optional): 摘要 ,
 content (string, optional): 内容 ,
 contentType (integer, optional): 内容类型 1：图文 2：视频 3：音频 = ['1', '2', '3'],
 likeCount (integer, optional): 点赞数 ,
 iscollect (integer, optional): 是否已被收藏 ,
 ctime (string, optional): 创建时间 ,
 commentList (Array[CommonContentCommentModel], optional): 评论列表 ,
 commentCount (integer, optional): 评论数 ,
 ageGroup (string, optional): 文章所属年龄段 例如（3-6岁）
 **/
@class UserModel,CommonContentCommentModel,GradeModel,UserDtlModel,FileEntityModel,AreaModel;
@interface CommonContentModel : NSObject
@property (nonatomic, copy) NSNumber *content_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UserModel *user;
@property (nonatomic, copy) NSString *business_brand_name;
@property (nonatomic, copy) NSString *summarize;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *contentType;
@property (nonatomic, copy) NSNumber *likeCount;
@property (nonatomic, copy) NSNumber *iscollect;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, strong) NSArray *commentList;
@property (nonatomic, copy) NSNumber *commentCount;
@property (nonatomic, copy) NSString *ageGroup;
@property (nonatomic, strong) NSArray *imagelist;
@end

/**
 comment_id (integer, optional): 评论id ,
 content_id (integer, optional): 文章id ,
 content (string, optional): 评论内容 ,
 fid (integer, optional): 父id ,
 user (UserModel, optional): 评论用户 ,
 ctime (string, optional): 评论时间 ,
 likeCount (integer, optional): 点赞数 ,
 children (Array[CommonContentCommentModel], optional): 子评论 ,
 imageList (Array[FileEntityModel], optional): 评论图片集合
 **/
@interface CommonContentCommentModel : NSObject
@property (nonatomic, copy) NSNumber *comment_id;
@property (nonatomic, copy) NSNumber *content_id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *fid;
@property (nonatomic, strong) UserModel *user;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, strong) NSArray *children;
@property (nonatomic, copy) NSNumber *likeCount;
@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, copy) NSNumber *isOpen;//记录评论内容的展开收起
@end
