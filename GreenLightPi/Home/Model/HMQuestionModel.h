//
//  HMQuestionModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/1.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMQuestionModel : NSObject
@property (nonatomic, copy) NSNumber *answers_id;//问题id
@property (nonatomic, copy) NSString *title;//问题标题
@property (nonatomic, copy) NSString *content;//问题内容
@property (nonatomic, copy) NSNumber *answer_number;//回答数
@property (nonatomic, copy) NSNumber *collect_number;//收藏数
@property (nonatomic, copy) NSNumber *like_number;//点赞数
@property (nonatomic, copy) NSString *comment;//评论内容
@property (nonatomic, copy) NSNumber *read_count;//阅读数
@property (nonatomic, copy) NSNumber *audit_status;//审核状态
@property (nonatomic, copy) NSNumber *is_collect;//是否已收藏0，未收藏，，已收藏
@property (nonatomic, copy) NSString *c_time;//提问时间
@property (nonatomic, strong) NSArray *imagelist;//问题图片列表
@end
