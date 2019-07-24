//
//  DetailCommonViewModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewModel.h"

@interface DetailCommonViewModel : BaseViewModel
/** 详情 */
@property (nonatomic, strong, readonly) RACCommand *getDetailCommand;

/** 评论文章 */
@property (nonatomic, strong, readonly) RACCommand *CreateContentCommentCommand;

/** 转发文章 */
@property (nonatomic, strong, readonly) RACCommand *TranspondQuestionCommand;

/** 收藏文章 */
@property (nonatomic, strong, readonly) RACCommand *CollectArticleCommand;

/** 点赞/取消点赞文章 */
 @property (nonatomic, strong, readonly) RACCommand *LikeArticleCommand;

@end
