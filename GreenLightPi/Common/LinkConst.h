//
//  LinkConst.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/*****   *****/


/****************************** 数据请求code值 *******************************/
/* 请求成功code值 */
extern int const Success;

/****************************** 数据请求地址 *******************************/
// 通用
/* 基地址 */
extern NSString * const BaseLink;

/**文件流形式上传图片**/
extern NSString * const common_uploadFile;
/** 获取上传到七牛云的token **/
extern NSString * const common_getUpToken;

/** 图文详情相关 **/
extern NSString * const common_CreateContentComment;  //评论文章
extern NSString * const common_TranspondQuestion;  //转发文章
extern NSString * const common_CollectArticle;  //收藏文章
extern NSString * const common_LikeArticle;  //点赞/取消点赞文章

// 登录注册
extern NSString * const RL_judgePhone;                // 校验手机号码
extern NSString * const RL_Login;                     // 登录
extern NSString * const RL_SendVerificationCode;      // 发送验证码(涉及业务)
extern NSString * const RL_Register;                  // 注册
extern NSString * const RL_ResetPassword;             // 忘记密码
extern NSString * const RL_SaveBabyImage;             //上传宝宝头像
extern NSString * const RL_SaveBabyImage;             //上传宝宝头像
extern NSString * const RL_CreatBabyInfo;             //添加宝宝信息
extern NSString * const RL_BindUser;                  //绑定用户
extern NSString * const RL_IsBind;                  //判断用户是否绑定
extern NSString * const RL_GetVersonForName;                  //根据名称获取版本


/*** 详情 ***/
extern NSString * const HM_Detail;        //问题详情

/*** 首页 ***/
extern NSString * const HM_GetHomeContent;                // 获取首页模块数据
extern NSString * const HM_GetAdByType;              // 获取首页广告列表
extern NSString * const HM_GetBabyList;              // 根据当前登录用户返回用户宝宝列表
extern NSString * const HM_GetFamilyMember;            // 获取用户所在的家庭组集合
extern NSString * const HM_GetUserBoxList;              // 获取用户所在家庭盒子列表
extern NSString * const HM_QuitFamily;              // 退出家庭
extern NSString * const HM_InviteFamilyMember;              // 邀请加入家庭
extern NSString * const HM_GetAlsoPlay;              // 玩吧还要玩更多列表数据


extern NSString * const HM_GetHomeAllChannel;                // 获取首页所有频道
extern NSString * const HM_GetHomeMyChannel;                 // 获取首页我的频道
extern NSString * const HM_UpdateHomeMyChannel;              // 修改首页我的频道
extern NSString * const HM_GetArticleList;              // 获取首页文章列表
extern NSString * const HM_AddDynamic;              // 新增动态
extern NSString * const HM_GetFollowAndFans;              // 我的关注


/***  搜索  ***/
extern NSString * const HM_MySearchHistory;              // 我的搜索历史
extern NSString * const HM_HotSearch;              // 热门搜索
extern NSString * const HM_SearchAll;              // 搜索全站内容
extern NSString * const HM_DeleteSearch;              // 删除搜索历史


/***   爸爸书房   ***/
extern NSString * const FS_GetCategoryByBabyId;              // 根据宝宝id获取分类及本月主题以及主题下的文章列表
extern NSString * const FS_GetContentList;              // 获取更多阅读列表 themeId传0 某一主题下的所有文章列表 更多阅读 的更多列表
extern NSString * const FS_GetPlayHome;
extern NSString * const FS_GetContentListByAgeGroup;              // 根据年龄段获取文章列表
extern NSString * const FS_CreateBabyImprinting;              // 添加宝宝印迹信息
extern NSString * const FS_CreateBabyImprintingNew;              // 添加宝宝印迹信息(new)
extern NSString * const FS_GetBabyImprintingList;              // 根据房间号获取宝宝印迹时间轴列表
extern NSString * const FS_GetBabyImprintingListNew;              // 根据房间号获取宝宝印迹时间轴列表(new)
extern NSString * const FS_MyCollect;              // 我的收藏
extern NSString * const FS_BindRoom;              // 绑定另一半
extern NSString * const FS_UserBind;              // 绑定用户
extern NSString * const FS_BindConfirmBabys;              // 绑定用户，确定宝宝的选择
extern NSString * const FS_BindConfirmBabys;              // 绑定用户，确定宝宝的选择

/***   好家长   ***/
extern NSString * const FC_GetCourses;              // 获取课程
extern NSString * const FC_GetFcClassifies;              // 根据内容类型获取分类
extern NSString * const FC_PlaceAnOrder;              // 下单
extern NSString * const FC_GetCoursesForId;              // 根据编号获取课程详细
extern NSString * const FC_GetCoursesForIdyk;              // 根据编号获取课程详细游客
extern NSString * const FC_GiveComment;              // 评论
extern NSString * const FC_GetOrderForCoursesId;              // 通过课程编号获取够买记录
extern NSString * const FC_CollectCourses;              // 收藏课程
extern NSString * const FC_CancelCollectCourses;              // 取消收藏课程
extern NSString * const FC_GetMyCollectList;              // 获取我的收藏
extern NSString * const FC_GetWatchRecordList;              // 获取阅读记录
extern NSString * const FC_AddFcWatchRecord;              // 添加阅读记录


/***   个人中心   ***/
extern NSString * const PC_GetPersonalCenterUser;              // 获取个人中心用户资料
extern NSString * const PC_GetCoachUser;// 获取个人中心用户资料教练模型
extern NSString * const PC_GetBookUser;             // 获取个人中心用户资料绘本作者
extern NSString * const PC_GetArticleUser;             // 获取个人中心用户资料首页文章作者
extern NSString * const PC_GetPersonalAppointment;              // 获取个人中心我的预约
extern NSString * const PC_GetOrderCourses;              // 根据用户编号获取已购课程
extern NSString * const PC_GetPersonalCollect;              // 获取个人中心我的收藏
extern NSString * const PC_GetReadRecord;              // 获取个人中心阅读记录
extern NSString * const PC_DeleteCollect;              // 删除收藏
extern NSString * const PC_DeleteReadRecord;           // 删除阅读记录
extern NSString * const PC_GetOrderRecord;             // 根据用户编号获取订单记录
extern NSString * const PC_GetFollowAndFans;             // 根据用户编号，获取关注的人，及粉丝
extern NSString * const PC_GetIntegralForUserId;             // 根据用户编号，获取积分流水
extern NSString * const PC_UpdatePersonal;              // 修改个人中心资料
extern NSString * const PC_AiIdcard;              // ai识别身份证
extern NSString * const PC_GetUserMessage;              // 获取未读消息POST
extern NSString * const PC_UpdateMessageStatus;              // 修改消息状态
extern NSString * const PC_ReplacePhoneOneCode;              // 更换手机，旧手机号验证
extern NSString * const PC_ReplacePhoneNew;              // 更换手机，新手机号处理
extern NSString * const PC_ChangePassword;              // 修改密码
extern NSString * const PC_FeedbackMessage;              // 个人中心反馈留言
extern NSString * const PC_AddOrEditBaby;              // 添加或者编辑单个宝宝操作
extern NSString * const PC_DeleteBaby;              // 删除单个宝宝操作
extern NSString * const PC_GetDynamicForUserId;              //根据用户编号获取动态（查看普通用户，及查看自己的动态
extern NSString * const PC_GetFollowDynamic;              //根据用户编号获取关注者动态（首页关注)
extern NSString * const PC_DeleteDynamic;              //删除动态
extern NSString * const PC_GetSearchRedUser;              //获取推荐用户
extern NSString * const PC_GetSearchUser;              //获取搜索用户
extern NSString * const PC_ConcernUser;              //关注用户
extern NSString * const PC_CancelConcern;              //取消关注
extern NSString * const PC_AddBabyPhysiqueRecord;              //添加宝宝成长记录
extern NSString * const PC_GetArticlePage;              //根据用户id 分页获取绘本
extern NSString * const PC_GetBookPage;              //根据用户id分页获取文章列表
extern NSString * const PC_GetUserCourses;              //根据用户id分页获取教练作品列表
extern NSString * const PC_CancelAppointment;              //取消预约（小池和活动）
extern NSString * const PC_UpdateAppointmentStatus;              //取消预约（基因检测）
extern NSString * const PC_GetSignInList;              //获取签到集合（7天）
extern NSString * const PC_SignIn;              //签到
extern NSString * const PC_GetDetectionReport;              //获取检测报告

/***  会员相关  ***/
extern NSString * const PC_GetBoxUseTime;              //获取盒子使用时间
extern NSString * const PC_GetBoxTimeRemind;              //获取盒子提醒时间
extern NSString * const PC_SetBoxUseTime;              //设置盒子使用时间
extern NSString * const PC_SetBoxTimeRemind;              //设置盒子提醒时间
extern NSString * const PC_TransferBox;              //转移盒子权限
extern NSString * const PC_AppActivityBox;              //APP激活盒子POST

/***   权益中心  ***/
extern NSString * const PC_GetIncomeCenter;              //根据用户编号获取权益中心内容
extern NSString * const PC_GetIncomeList;              //根据收益类型分页获取收益列表
extern NSString * const PC_GetMyTeamForApp;              //根据用户Id分页获取用户团队成员列表
extern NSString * const PC_GetMyBankCard;              //H5分销系统--根据用户Id获取用户银行卡列表
extern NSString * const PC_CreateBankCard;              //添加银行卡
extern NSString * const PC_DrawMoneyToBank;              //申请提现到银行卡
extern NSString * const PC_GetDrawMoneyRecord;              //分页获取我的申请提现记录
extern NSString * const PC_ForgetDrawMoneyPassword;              //忘记提现密码--验证提交信息是否正确


