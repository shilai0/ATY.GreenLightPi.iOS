//
//  FcCoursesModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/9.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 courses_id (integer, optional): 课程id ,
 title (string, optional): 课程标题 ,
 content (string, optional): 内容课程介绍 ,
 price (number, optional): 课程价格 ,
 author (string, optional): 作者 ,
 purchaseNotes (string, optional): 购买须知 ,
 is_top (integer, optional): 是否置顶 = ['0', '1'],
 is_hot (integer, optional): 是否热门 = ['0', '1'],
 is_red (integer, optional): 是否推荐 = ['0', '1'],
 is_discuss (integer, optional): 是否允许评论 = ['0', '1'],
 is_enable (integer, optional): 是否启用 = ['0', '1'],
 is_concentration (integer, optional): 是否精选 = ['0', '1'],
 user (UserModel, optional): 用户编号 ,
 image (FileEntityModel, optional): 封面id ,
 imageList (Array[FileEntityModel], optional): 相册 ,
 sort_no (integer, optional): 排序 ,
 ctime (string, optional): 创建时间 ,
 utime (string, optional): 修改时间 ,
 keydes (string, optional): 关键字，标签 ,
 article_source (string, optional): 文章来源 ,
 coursesType (integer, optional): 内容类型 = ['1', '2', '3'],
 classify_id (integer, optional): 课程分类id ,
 classify (FcClassifyModel, optional): 课程分类 ,
 practicalPeople (string, optional): 实用人群 ,
 totalNumber (integer, optional): 视频需要学习的总次数 ,
 studyNumber (integer, optional): 已经学习的人数 ,
 vip_label (integer, optional): VIP是否免费 = ['0', '1'],
 integral (integer, optional): 积分 ,
 discount (number, optional): 折扣（默认为1不打折） ,
 consumptionType (string, optional): 消费方式 ,//1.money,金钱  2.integral,积分
 3.free,免费 4.moneyAndIntegral,积分抵扣
 consumptionDetails (Array[FcCoursesDetailModel], optional): 课程包含的附件 ,
 score (number, optional): 评分 ,
 isPurchase (integer, optional): 是否已购买 ,
 isScore (integer, optional): 是否已评分 ,
 comments (Array[FcCommentModel], optional): 评论集合
 progressShow (string, optional): 进度显示
 */
@class FileEntityModel,FcClassifyModel,FcCoursesDetailModel,FcCommentModel,UserModel,UserDtlModel,FcCoachModel,BusinessUserModel,GradeModel,AreaModel,BusinessDtlModel,StoreModel,BrandModel,StoreActivityModel,DayAppointmentPeriodModel,StoreAppointmentModel,AppointmentPeriodModel,TimeBlockModel;
@interface FcCoursesModel : NSObject
@property (nonatomic, copy) NSNumber *courses_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *purchaseNotes;
@property (nonatomic, copy) NSNumber *is_top;
@property (nonatomic, copy) NSNumber *is_hot;
@property (nonatomic, copy) NSNumber *is_red;
@property (nonatomic, copy) NSNumber *is_discuss;
@property (nonatomic, copy) NSNumber *is_enable;
@property (nonatomic, copy) NSNumber *is_concentration;
@property (nonatomic, strong) UserModel *user;
@property (nonatomic, strong) FileEntityModel *image;
@property (nonatomic, strong) NSArray *imageList;
@property (nonatomic, copy) NSNumber *sort_no;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *utime;
@property (nonatomic, copy) NSString *keydes;
@property (nonatomic, copy) NSString *article_source;
@property (nonatomic, copy) NSNumber *coursesType;
@property (nonatomic, copy) NSNumber *classify_id;
@property (nonatomic, strong) FcClassifyModel *classify;
@property (nonatomic, copy) NSString *practicalPeople;
@property (nonatomic, copy) NSNumber *totalNumber;
@property (nonatomic, copy) NSNumber *studyNumber;
@property (nonatomic, copy) NSNumber *vip_label;
@property (nonatomic, copy) NSNumber *integral;
@property (nonatomic, copy) NSNumber *discount;
@property (nonatomic, copy) NSString *consumptionType;
@property (nonatomic, strong) NSArray *consumptionDetails;
@property (nonatomic, copy) NSNumber *score;
@property (nonatomic, copy) NSNumber *isPurchase;
@property (nonatomic, copy) NSNumber *isScore;
@property (nonatomic, strong) NSArray *comments;
@property (nonatomic, copy) NSString *progressShow;
@property (nonatomic, copy) NSNumber *progress;
@end

/**
 classify_id (integer, optional): 课程分类id ,
 fid (integer, optional): 一级分类（育儿、启蒙教育、家庭教育） ,
 classifys (Array[FcClassifyModel], optional): 下级分类 ,
 classifyName (string, optional): 分类名称 ,
 ctime (string, optional): 创建时间 ,
 sort_no (integer, optional): 排序 ,
 classifyType (integer, optional): 分类类型 = ['1', '2', '3']
 */
@interface FcClassifyModel : NSObject
@property (nonatomic, copy) NSNumber *classify_id;
@property (nonatomic, copy) NSNumber *fid;
@property (nonatomic, strong) NSArray *classifys;
@property (nonatomic, copy) NSString *classifyName;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSNumber *sort_no;
@property (nonatomic, copy) NSNumber *classifyType;
@property (nonatomic, assign) BOOL isSelected;//(自定义，用于标记该分类是否选中)
@end

/**
 coursesDetail_id (integer, optional): 主键课件表id ,
 courses_id (integer, optional): 课程id ,
 file (FileEntityModel, optional): 文件外键 ,
 title (string, optional): 标题 ,
 content (string, optional): 内容 ,
 sort_no (integer, optional): 排序 ,
 ctime (string, optional): 创建时间 ,
 duration (integer, optional): 课程时长（秒）
 progressShow (string, optional): 进度显示 ,
 progress (number, optional): 进度0.25==25%
 fcModuleType (integer, optional): 模块类型 ,
 isLock (integer, optional): 课程是否加锁
 **/
@interface FcCoursesDetailModel : NSObject
@property (nonatomic, copy) NSNumber *coursesDetail_id;
@property (nonatomic, copy) NSNumber *courses_id;
@property (nonatomic, strong) FileEntityModel *file;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSNumber *sort_no;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSNumber *duration;
@property (nonatomic, copy) NSString *itemNum;//第几课
@property (nonatomic, copy) NSString *progressShow;
@property (nonatomic, copy) NSNumber *progress;
@property (nonatomic, assign) NSInteger fcModuleType;
@property (nonatomic, assign) NSInteger isLock;
@property (nonatomic, assign) BOOL isCurrentPlay;
@end

/**
 comment_id (integer, optional): 课程评论Id ,
 fid (integer, optional): 评论父id ,
 content (string, optional): 评论以及回复内容 ,
 user (UserModel, optional): 评论的用户 ,
 ctime (string, optional): 回复时间 ,
 fewStars (integer, optional): 评论评分(只针对第一级别评论评分1星，2星，3星，4星，5星) ,
 comments (Array[FcCommentModel], optional): 回复
 **/
@interface FcCommentModel : NSObject
@property (nonatomic, copy) NSNumber *comment_id;
@property (nonatomic, copy) NSNumber *fid;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) UserModel *user;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSNumber *fewStars;
@property (nonatomic, copy) NSArray *comments;
@end


