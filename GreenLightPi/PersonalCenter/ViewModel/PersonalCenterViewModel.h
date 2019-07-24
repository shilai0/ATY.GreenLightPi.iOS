//
//  PersonalCenterViewModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewModel.h"

@interface PersonalCenterViewModel : BaseViewModel
/** 获取个人中心用户资料app用户 */
@property (nonatomic, strong, readonly) RACCommand *GetPersonalCenterUser;

/** 获取个人中心用户资料教练模型 */
@property (nonatomic, strong, readonly) RACCommand *GetCoachUser;

/** 获取个人中心用户资料绘本作者模型 */
@property (nonatomic, strong, readonly) RACCommand *GetBookUser;

/** 获取个人中心用户资料文章作者模型 */
@property (nonatomic, strong, readonly) RACCommand *GetArticleUser;

/** 获取个人中心我的预约 */
@property (nonatomic, strong, readonly) RACCommand *GetPersonalAppointment;

/** 个人中心取消预约 （小池和活动）*/
@property (nonatomic, strong, readonly) RACCommand *CancelAppointment;

/** 个人中心取消预约 (基因检测)*/
@property (nonatomic, strong, readonly) RACCommand *UpdateAppointmentStatus;

/** 获取个人中心我的收藏 */
@property (nonatomic, strong, readonly) RACCommand *GetPersonalCollect;

/** 获取个人中心阅读记录 */
@property (nonatomic, strong, readonly) RACCommand *GetReadRecord;

/** 删除收藏 */
@property (nonatomic, strong, readonly) RACCommand *DeleteCollect;

/** 删除阅读记录 */
@property (nonatomic, strong, readonly) RACCommand *DeleteReadRecord;

/** 根据用户编号获取订单记录(我的账户) */
@property (nonatomic, strong, readonly) RACCommand *GetOrderRecord;

/** 根据用户编号获取已购课程 */
@property (nonatomic, strong, readonly) RACCommand *GetOrderCourses;

/** 根据用户编号，获取关注的人，及粉丝 */
@property (nonatomic, strong, readonly) RACCommand *GetFollowAndFans;

/** 根据用户编号，获取积分流水 */
@property (nonatomic, strong, readonly) RACCommand *GetIntegralForUserId;

/** 修改个人中心资料 */
@property (nonatomic, strong, readonly) RACCommand *UpdatePersonal;

/** 上传头像 */
@property (nonatomic, strong, readonly) RACCommand *UpdateFile;

/** ai识别身份证 */
@property (nonatomic, strong, readonly) RACCommand *AiIdcard;

/** 获取未读消息 */
@property (nonatomic, strong, readonly) RACCommand *GetUserMessage;

/** 修改消息状态 */
@property (nonatomic, strong, readonly) RACCommand *UpdateMessageStatus;

/** 更换手机，旧手机号验证 */
@property (nonatomic, strong, readonly) RACCommand *ReplacePhoneOneCode;

/** 更换手机，新手机号处理 */
@property (nonatomic, strong, readonly) RACCommand *ReplacePhoneNew;

/** 修改密码 */
@property (nonatomic, strong, readonly) RACCommand *ChangePassword;

/** 个人中心反馈留言 */
@property (nonatomic, strong, readonly) RACCommand *FeedbackMessage;

/** 添加或编辑单个宝宝 */
@property (nonatomic, strong, readonly) RACCommand *AddOrEditorBaby;

/** 删除单个宝宝 */
@property (nonatomic, strong, readonly) RACCommand *DeleteBaby;

/** 根据用户编号获取动态（查看普通用户，及查看自己的动 */
@property (nonatomic, strong, readonly) RACCommand *GetDynamicForUserId;

/** 删除动态 */
@property (nonatomic, strong, readonly) RACCommand *DeleteDynamic;

/** 获取推荐用户 */
@property (nonatomic, strong, readonly) RACCommand *GetSearchRedUser;

/** 获取搜索用户 */
@property (nonatomic, strong, readonly) RACCommand *GetSearchUser;

/** 关注用户 */
@property (nonatomic, strong, readonly) RACCommand *ConcernUser;

/** 取消关注 */
@property (nonatomic, strong, readonly) RACCommand *CancelConcern;

/** 添加宝宝成长记录 */
@property (nonatomic, strong, readonly) RACCommand *AddBabyPhysiqueRecord;

/** 根据用户id 分页获取绘本 */
@property (nonatomic, strong, readonly) RACCommand *GetBookPage;

/** 根据用户id分页获取文章列表 */
@property (nonatomic, strong, readonly) RACCommand *GetArticlePage;

/** 根据用户id分页获取教练作品列表 */
@property (nonatomic, strong, readonly) RACCommand *GetUserCourses;

/** 获取签到集合（7天） */
@property (nonatomic, strong, readonly) RACCommand *GetSignInList;

/** 签到 */
@property (nonatomic, strong, readonly) RACCommand *SignIn;

/** 获取盒子使用时间 */
@property (nonatomic, strong, readonly) RACCommand *GetBoxUseTime;

/** 获取盒子提醒时间 */
@property (nonatomic, strong, readonly) RACCommand *GetBoxTimeRemind;

/** 设置盒子使用时间 */
@property (nonatomic, strong, readonly) RACCommand *SetBoxUseTime;

/** 设置盒子提醒时间 */
@property (nonatomic, strong, readonly) RACCommand *SetBoxTimeRemind;

/** 转移盒子权限 */
@property (nonatomic, strong, readonly) RACCommand *TransferBox;

/** App激活盒子 */
@property (nonatomic, strong, readonly) RACCommand *AppActivityBox;

/** 根据用户编号获取权益中心内容 */
@property (nonatomic, strong, readonly) RACCommand *GetIncomeCenter;

/** 根据收益类型分页获取收益列表 */
@property (nonatomic, strong, readonly) RACCommand *GetIncomeList;

/** 根据用户Id分页获取用户团队成员列表 */
@property (nonatomic, strong, readonly) RACCommand *GetMyTeamForApp;

/** H5分销系统--根据用户Id获取用户银行卡列表 */
@property (nonatomic, strong, readonly) RACCommand *GetMyBankCard;

/** 添加银行卡 */
@property (nonatomic, strong, readonly) RACCommand *CreateBankCard;

/** 申请提现到银行卡 */
@property (nonatomic, strong, readonly) RACCommand *DrawMoneyToBank;

/** 分页获取我的申请提现记录 */
@property (nonatomic, strong, readonly) RACCommand *GetDrawMoneyRecord;

/** 忘记提现密码--验证提交信息是否正确 */
@property (nonatomic, strong, readonly) RACCommand *ForgetDrawMoneyPassword;


@end
