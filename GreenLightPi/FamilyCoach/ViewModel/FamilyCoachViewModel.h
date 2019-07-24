//
//  FamilyCoachViewModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/9.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewModel.h"

@interface FamilyCoachViewModel : BaseViewModel
/** 获取课程(亲子沟通三步曲) */
@property (nonatomic, strong, readonly) RACCommand *GetHomeCoursesCommand;

/** 获取课程(从游戏中培养孩子的能力) */
@property (nonatomic, strong, readonly) RACCommand *GetMagicianCoursesCommand;

/** 获取课程(公开课) */
@property (nonatomic, strong, readonly) RACCommand *GetOpenClassCoursesCommand;

/** 获取课程(家园共育八阶段) */
@property (nonatomic, strong, readonly) RACCommand *GeteEightStageCoursesCommand;

/** 获取课程(音频) */
@property (nonatomic, strong, readonly) RACCommand *GetAudioCoursesCommand;

/** 根据内容类型获取分类 */
@property (nonatomic, strong, readonly) RACCommand *GetFcClassifiesCommand;

/** 下单 */
@property (nonatomic, strong, readonly) RACCommand *PlaceAnOrderCommand;

/** 根据编号获取课程详细 */
@property (nonatomic, strong, readonly) RACCommand *GetCoursesForIdCommand;

/** 根据编号获取课程详细游客 */
@property (nonatomic, strong, readonly) RACCommand *GetCoursesForIdCommandyk;

/** 评论 */
@property (nonatomic, strong, readonly) RACCommand *GiveCommentCommand;

/** 通过课程编号获取够买记录 */
@property (nonatomic, strong, readonly) RACCommand *GetOrderForCoursesIdCommand;

/** 收藏课程 */
@property (nonatomic, strong, readonly) RACCommand *CollecCourseCommand;

/** 取消收藏课程 */
@property (nonatomic, strong, readonly) RACCommand *CancelCollecCourseCommand;

/** 获取轮播图 */
@property (nonatomic, strong, readonly) RACCommand *GetAdByTypeCommand;

/** 获取我的收藏 */
@property (nonatomic, strong, readonly) RACCommand *GetMyCollectListCommand;

/** 获取阅读记录 */
@property (nonatomic, strong, readonly) RACCommand *GetWatchRecordListCommand;

/** 添加阅读记录 */
@property (nonatomic, strong, readonly) RACCommand *AddFcWatchRecordCommand;

@end
