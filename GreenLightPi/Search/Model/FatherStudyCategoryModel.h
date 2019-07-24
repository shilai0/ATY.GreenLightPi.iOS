//
//  FatherStudyCategoryModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/3.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 contentCategory_id (integer, optional): 分类id ,
 categoryName (string, optional): 分类名称 ,
 indexes (string, optional): 分类索引 ,
 themeContent (FatherStudyThemeModel, optional): 分类下的主题及主题下的文章列表
 */
@class FatherStudyThemeModel,FatherStudyContentModel,FileEntityModel;
@interface FatherStudyCategoryModel : NSObject
@property (nonatomic, copy) NSNumber *contentCategory_id;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *indexes;
@property (nonatomic, strong) FatherStudyThemeModel *themeContent;
@end

/**
 theme_id (integer, optional): 主题id ,
 themeName (string, optional): 主题名称 ,
 contentList (Array[FatherStudyContentModel], optional): 文章列表
 */
@interface FatherStudyThemeModel : NSObject
@property (nonatomic, copy) NSNumber *theme_id;
@property (nonatomic, copy) NSString *themeName;
@property (nonatomic, strong) NSArray *contentList;
@end

/**
 content_id (integer, optional): 内容id ,
 title (string, optional): 标题 ,
 summarize (string, optional): 摘要 ,
 image (FileEntityModel, optional): 文章封面 ,
 ageGroupStart (integer, optional): 年龄段开始 ,
 ageGroupEnd (integer, optional): 年龄段结束
 */
@interface FatherStudyContentModel : NSObject
@property (nonatomic, copy) NSNumber *content_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *summarize;
@property (nonatomic, strong) FileEntityModel *image;
@property (nonatomic, copy) NSNumber *ageGroupStart;
@property (nonatomic, copy) NSNumber *ageGroupEnd;
@end
