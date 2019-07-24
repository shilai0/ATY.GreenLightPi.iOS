//
//  HomeViewModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/7.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewModel.h"

@interface HomeViewModel : BaseViewModel

/** 获取首页模块数据 */
@property (nonatomic, strong, readonly) RACCommand *getHomeContentCommand;

/** 获取首页广告弹窗 */
@property (nonatomic, strong, readonly) RACCommand *getAdByTypeCommand;

/** 根据登录用户id获取宝宝列表 */
@property (nonatomic, strong, readonly) RACCommand *getBabyListCommand;

/** 获取更多阅读列表 themeId传0 某一主题下的所有文章列表 更多阅读 的更多列表 */
@property (nonatomic, strong, readonly) RACCommand *getContentList;

@property (nonatomic, strong, readonly) RACCommand *GetPlayHome;

/** 添加宝宝信息上传宝宝头像 */
@property (nonatomic, strong, readonly) RACCommand *saveBabyImageCommand;

/** 添加或编辑单个宝宝 */
@property (nonatomic, strong, readonly) RACCommand *AddOrEditorBaby;

/** 删除单个宝宝 */
@property (nonatomic, strong, readonly) RACCommand *DeleteBaby;

/**  获取用户所在家庭组集合  */
@property (nonatomic, strong, readonly) RACCommand *GetFamilyMemberCommand;

/**  获取用户所在家庭盒子列表  */
@property (nonatomic, strong, readonly) RACCommand *GetUserBoxListCommand;

/**  退出家庭  */
@property (nonatomic, strong, readonly) RACCommand *QuitCommand;

/**  同意加入家庭组  */
@property (nonatomic, strong, readonly) RACCommand *InviteFamilyMemberCommand;

/**   玩吧还要玩更多数据   */
@property (nonatomic, strong, readonly) RACCommand *GetAlsoPlayCommand;




/** 获取首页所有频道 */
@property (nonatomic, strong, readonly) RACCommand *getHomeAllChannelCommand;

/** 获取首页我的频道 */
@property (nonatomic, strong, readonly) RACCommand *getHomeMyChannelCommand;

/** 修改首页我的频道 */
@property (nonatomic, strong, readonly) RACCommand *updateHomeMyChannelCommand;

/** 获取首页列表 */
@property (nonatomic, strong, readonly) RACCommand *getArticleListCommand;

/** 获取上传到七牛云的token */
@property (nonatomic, strong, readonly) RACCommand *getTokenCommand;

/** 我的搜索历史 */
@property (nonatomic, strong, readonly) RACCommand *getMySearchHistoryCommand;

/** 热门搜索 */
@property (nonatomic, strong, readonly) RACCommand *getHotSearchCommand;

/** 删除我的搜索历史 */
@property (nonatomic, strong, readonly) RACCommand *deleteSearchCommand;

/** 搜索全站内容 */
@property (nonatomic, strong, readonly) RACCommand *getSearchAllCommand;

/** 评论文章 */
@property (nonatomic, strong, readonly) RACCommand *CreateContentCommentCommand;

/** 收藏文章 */
@property (nonatomic, strong, readonly) RACCommand *CollectArticleCommand;

@end
