//
//  HomeListModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 article_id (integer, optional): 文章编号 ,
 title (string, optional): 标题 ,
 content (string, optional): 内容 ,
 author (string, optional): 作者 ,
 business_brand_name (string, optional): 商家品牌名称 ,
 reads (integer, optional): 阅读数 ,
 is_top (integer, optional): 是否置顶 0否 1是 ,
 is_hot (integer, optional): 是否热门 0否 1是 ,
 is_discuss (integer, optional): 是否允许评论 0否 1是 ,
 is_red (integer, optional): 是否推荐 0否 1是 ,
 user_id (integer, optional): 用户编号 ,
 user_name (string, optional): 用户名称 ,
 sort_no (integer, optional): 排序 ,
 articletype_id (integer, optional): 文章类别编号 ,
 articletype (ArticleTypeModel, optional): 文章类别对象 ,
 image_id (integer, optional): 封面图片 ,
 image (FileEntityModel, optional): 封面模型 ,
 is_enable (integer, optional): 是否启用 0否 1是 ,
 grade_code (string, optional): 分组代码 ,
 imageList (Array[FileEntityModel], optional): 相册编号 ,
 keydes (string, optional): 标签 ,
 photo (string, optional): 用户头像 ,
 iscollect (integer, optional): 是否已被收藏 ,
 utime (string, optional): 更新时间 ,
 likecount (integer, optional): 文章点赞数 ,
 commentlist (Array[ArticleCommentModel], optional): 评论列表
 statusName (string, optional): 数据状态 ,
 contentType (integer, optional): 内容类型 = ['1', '2', '3','4']1.图文，2.视频，3.音频，4.纯文字
 **/
@class ArticleTypeModel,FileEntityModel,ArticleCommentModel,UserModel,GradeModel,UserDtlModel,AreaModel;
@interface HomeListModel : NSObject
@property (nonatomic, copy) NSNumber *article_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSNumber *reads;
@property (nonatomic, copy) NSNumber *is_top;
@property (nonatomic, copy) NSNumber *is_hot;
@property (nonatomic, copy) NSNumber *is_discuss;
@property (nonatomic, copy) NSNumber *is_red;
@property (nonatomic, copy) NSNumber *user_id;
@property (nonatomic, copy) NSString *user_name;
@property (nonatomic, copy) NSNumber *sort_no;
@property (nonatomic, copy) NSNumber *articletype_id;
@property (nonatomic, strong)ArticleTypeModel  *articletype;
@property (nonatomic, strong) FileEntityModel *image;
@property (nonatomic, copy) NSNumber *image_id;
@property (nonatomic, copy) NSString *grade_code;
@property (nonatomic, copy) NSNumber *is_enable;
@property (nonatomic, strong) NSMutableArray *imageList;
@property (nonatomic, copy) NSString *keydes;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSNumber *iscollect;
@property (nonatomic, copy) NSString *utime;
@property (nonatomic, copy) NSNumber *likecount;
@property (nonatomic, copy) NSArray *commentlist;
@property (nonatomic, copy) NSString *statusName;
@property (nonatomic, copy) NSNumber *contentType;
@property (nonatomic, assign) BOOL isShowType;
@property (nonatomic, assign) BOOL isShowTime;
@end

//articletype_id (integer, optional): 文章类型id ,
//typename (string, optional): 类型名称 ,
//fid (integer, optional): 父id
@interface ArticleTypeModel : NSObject
@property (nonatomic, copy) NSNumber *articletype_id;
@property (nonatomic, copy) NSString *typename;
@property (nonatomic, copy) NSNumber *fid;
@end

/**
 comment_id (integer, optional): 评论id ,
 article_id (integer, optional): 文章id ,
 content (string, optional): 评论内容 ,
 fid (integer, optional): 父id ,
 user (UserModel, optional): 评论用户 ,
 ctime (string, optional): 评论时间 ,
 likecount (integer, optional): 点赞数量 ,
 children (Array[ArticleCommentModel], optional): 子集评论列表
 **/
@interface ArticleCommentModel : NSObject
@property (nonatomic, copy) NSNumber *comment_id;
@property (nonatomic, copy) NSNumber *article_id;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *fid;
@property (nonatomic, strong) UserModel *user;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSNumber *likecount;
@property (nonatomic, strong) NSArray *children;
@end
