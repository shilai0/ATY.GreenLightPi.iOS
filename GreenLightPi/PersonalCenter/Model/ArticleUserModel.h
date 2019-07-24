//
//  ArticleUserModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/9/6.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 articleList (Array[UserArticleModel], optional): 文章集合 ,
 userId (integer, optional): 用户编号 ,
 imagePath (string, optional): 头像 ,
 name (string, optional): 姓名 ,
 nikeName (string, optional): 昵称 ,
 label (string, optional): 标签：自填（绘本、教具） ,
 fansCount (integer, optional): 粉丝数 ,
 worksCount (integer, optional): 作品数量 ,
 isFollow (integer, optional): 是否关注 ,
 resume (string, optional): 简介 ,
 userType (string, optional): 用户类别
 */

@interface ArticleUserModel : NSObject
@property (nonatomic,strong) NSArray *articleList;
@property (nonatomic,copy) NSNumber *userId;
@property (nonatomic,copy) NSString *imagePath;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *nikeName;
@property (nonatomic,copy) NSString *label;
@property (nonatomic,copy) NSNumber *fansCount;
@property (nonatomic,copy) NSNumber *worksCount;
@property (nonatomic,copy) NSNumber *isFollow;
@property (nonatomic,copy) NSString *resume;
@property (nonatomic,copy) NSNumber *userType;
@end

/**
 article_id (integer, optional): 文章编号 ,
 title (string, optional): 标题 ,
 reads (integer, optional): 阅读数 ,
 typeName (string, optional): 文章类别对象 ,
 imagePath (string, optional): 封面完整地址 ,
 contentType (integer, optional): 内容类型 = ['1', '2', '3']
 */
@interface UserArticleModel : NSObject
@property (nonatomic,copy) NSNumber *article_id;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSNumber *reads;
@property (nonatomic,copy) NSString *typeName;
@property (nonatomic,copy) NSString *imagePath;
@property (nonatomic,copy) NSNumber *contentType;
@property (nonatomic,copy) NSString *summarize;
@end
