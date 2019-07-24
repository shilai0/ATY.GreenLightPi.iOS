//
//  FatherStudyContentListModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 contentList (Array[FatherStudyContentModel], optional): 所有文章列表 ,
 ageGroupList (Array[AgeGroupModel], optional): 年龄段集合 0-3岁 3-6岁
 **/
@class FatherStudyContentModel,AgeGroupModel,FileEntityModel;
@interface FatherStudyContentListModel : NSObject
@property (nonatomic, strong) NSArray *contentList;
@property (nonatomic, strong) NSArray *ageGroupList;
@end

/**
 content_id (integer, optional): 内容id ,
 title (string, optional): 标题 ,
 summarize (string, optional): 摘要 ,
 image (FileEntityModel, optional): 文章封面 ,
 ageGroupStart (integer, optional): 年龄段开始 ,
 ageGroupEnd (integer, optional): 年龄段结束
 **/
//@interface FatherStudyContentModel : NSObject
//@property (nonatomic, copy) NSNumber *content_id;
//@property (nonatomic, copy) NSString *title;
//@property (nonatomic, copy) NSString *summarize;
//@property (nonatomic, strong) FileEntityModel *image;
//@property (nonatomic, copy) NSNumber *ageGroupStart;
//@property (nonatomic, copy) NSNumber *ageGroupEnd;
//@end

/**
 ageGroupStart (integer, optional): 开始年龄段 ,
 ageGroupEnd (integer, optional): 结束年龄段
 **/
@interface AgeGroupModel : NSObject
@property (nonatomic, copy) NSNumber *ageGroupStart;
@property (nonatomic, copy) NSNumber *ageGroupEnd;
@end
