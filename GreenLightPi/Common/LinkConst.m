//
//  LinkConst.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>
/****************************** 数据请求code值 *******************************/
/* 请求成功code值 */
int const Success = 1;

/****************************** 数据请求地址 *******************************/
// 通用
/* 基地址 */
//NSString * const BaseLink = @"http://192.168.0.222/api/";       //
//NSString * const BaseLink = @"http://192.168.0.221/api/";       //
//NSString * const BaseLink = @"http://interface.aiteyou.net/api/";        //
NSString * const BaseLink = @"http://release.aiteyou.net/api/";        //
//NSString * const BaseLink = @"http://api.aiteyou.net/api/";        //

/**文件流形式上传图片**/
NSString * const common_uploadFile = @"FileApi/UploadFile";
/** 获取上传到七牛云的token **/
NSString * const common_getUpToken = @"FileApi/GetUpToken";

/** 图文详情相关 **/
NSString * const common_CreateContentComment = @"ContentApi/CreateContentComment";  //评论文章
NSString * const common_TranspondQuestion = @"ContentApi/TranspondQuestion";  //转发文章
NSString * const common_CollectArticle = @"ContentApi/CollectArticle";  //收藏文章
NSString * const common_LikeArticle = @"ContentApi/LikeArticle";  //点赞/取消点赞文章

/***   登录注册   ***/
NSString * const RL_judgePhone = @"UserApi/JudgeUserForPhone";                       // 校验手机号码
NSString * const RL_Login = @"UserApi/LoginUser";                         // 登录
NSString * const RL_SendVerificationCode = @"SmsApi/SmsCodeSend";        // 发送验证码(涉及业务)
NSString * const RL_Register = @"UserApi/RegisterUserForPhone";                    // 注册
NSString * const RL_ResetPassword = @"UserApi/RetrievePassword";               // 忘记密码
NSString * const RL_SaveBabyImage = @"BabyApi/SaveImage";                 //上传宝宝头像
NSString * const RL_CreatBabyInfo = @"BabyApi/CreateBaby";                 //添加宝宝信息
NSString * const RL_BindUser = @"UserApi/BindUser";                 //绑定用户
NSString * const RL_IsBind = @"UserApi/IsBind";                  //判断用户是否绑定
NSString * const RL_GetVersonForName = @"VersionApi/GetVersionForName";
    //根据名称获取版本

/*** 详情 ***/
NSString * const HM_Detail = @"ContentApi/GetDetail";        //问题详情

/***  首页  ***/
NSString * const HM_GetHomeContent = @"HomeApi/GetHomeContent";                // 获取首页模块数据
NSString * const HM_GetAdByType = @"AdApi/GetAdByType";              // 修改首页广告列表
NSString * const HM_GetBabyList = @"DetectionApi/GetBabyList";              // 根据当前登录用户返回用户宝宝列表
NSString * const HM_GetFamilyMember = @"FamilyApi/GetFamilyMember";              // 获取用户所在的家庭组集合
NSString * const HM_GetUserBoxList = @"BoxApi/GetUserBoxList";              // 获取用户所在家庭盒子列表
NSString * const HM_QuitFamily = @"FamilyApi/QuitFamily";              // 退出家庭
NSString * const HM_InviteFamilyMember = @"FamilyApi/InviteFamilyMember";              // 邀请加入家庭
NSString * const HM_GetAlsoPlay = @"FatherStudyApi/GetAlsoPlay";              // 玩吧还要玩更多列表数据


 NSString * const HM_GetHomeAllChannel = @"CategoryApi/GetHomeAllChannel";                // 获取首页所有频道
 NSString * const HM_GetHomeMyChannel = @"CategoryApi/GetHomeMyChannel";                     // 获取首页我的频道
 NSString * const HM_UpdateHomeMyChannel = @"CategoryApi/UpdateHomeMyChannel";      // 修改首页我的频道
 NSString * const HM_GetArticleList = @"ArticleApi/GetArticleList";              // 获取首页文章列表
 NSString * const HM_AddDynamic = @"PersonalCenterApi/AddDynamic";              // 新增动态
 NSString * const HM_GetFollowAndFans = @"UserApi/GetFollowAndFans";              // 我的关注GET


/***  搜索  ***/
 NSString * const HM_MySearchHistory = @"SearchApi/MySearchHistory";              // 我的搜索历史
 NSString * const HM_HotSearch = @"SearchApi/HotSearch";              // 热门搜索
 NSString * const HM_SearchAll = @"SearchApi/SearchAll";              // 搜索全站内容
 NSString * const HM_DeleteSearch = @"SearchApi/DeleteMySerchHistory";              // 删除搜索历史


/***   爸爸书房   ***/
NSString * const FS_GetCategoryByBabyId = @"FatherStudyApi/GetCategoryByBabyId";              // 根据宝宝id获取分类及本月主题以及主题下的文章列表
NSString * const FS_GetContentList = @"FatherStudyApi/GetContentList";              // 获取更多阅读列表 themeId传0 某一主题下的所有文章列表 更多阅读 的更多列表
NSString * const FS_GetPlayHome = @"FatherStudyApi/GetPlayHome";
NSString * const FS_GetContentListByAgeGroup = @"FatherStudyApi/GetContentListByAgeGroup";              // 根据年龄段获取文章列表
NSString * const FS_CreateBabyImprinting = @"FatherStudyApi/CreateBabyImprinting";              // 添加宝宝印迹信息
NSString * const FS_CreateBabyImprintingNew = @"FatherStudyApi/CreateBabyImprintingNew";              // 添加宝宝印迹信息(new)
NSString * const FS_GetBabyImprintingList = @"FatherStudyApi/GetBabyImprintingList";              // 根据房间号获取宝宝印迹时间轴列表
NSString * const FS_GetBabyImprintingListNew = @"FatherStudyApi/GetBabyImprintingListNew";              // 根据房间号获取宝宝印迹时间轴列表(new)
NSString * const FS_MyCollect = @"FatherStudyApi/MyCollect";              // 我的收藏
NSString * const FS_BindRoom = @"FatherStudyApi/BindRoom";              // 绑定另一半
NSString * const FS_UserBind = @"PersonalCenterApi/UserBind";              // 绑定用户
NSString * const FS_BindConfirmBabys = @"PersonalCenterApi/BindConfirmBabys";              // 绑定用户，确定宝宝的选择

/***   好家长   ***/
NSString * const FC_GetCourses = @"FamilyCoachApi/GetCourses";              // 获取课程
NSString * const FC_GetFcClassifies = @"FamilyCoachApi/GetFcClassifies";              // 根据内容类型获取分类
NSString * const FC_PlaceAnOrder = @"FamilyCoachApi/PlaceAnOrder";              // 下单
NSString * const FC_GetCoursesForIdyk = @"FamilyCoachApi/GetCoursesForIdyk";              // 根据编号获取课程详细游客
NSString * const FC_GetCoursesForId = @"FamilyCoachApi/GetCoursesForId";              // 根据编号获取课程详细
NSString * const FC_GiveComment = @"FamilyCoachApi/GiveComment";              // 评论
NSString * const FC_GetOrderForCoursesId = @"FamilyCoachApi/GetOrderForCoursesId";              // 通过课程编号获取够买记录C
NSString * const FC_CollectCourses = @"FamilyCoachApi/CollectCourses";              // 收藏课程
NSString * const FC_CancelCollectCourses = @"FamilyCoachApi/CancelCollectCourses";              // 取消收藏课程
NSString * const FC_GetMyCollectList = @"FamilyCoachApi/GetMyCollectList";              // 获取我的收藏
NSString * const FC_GetWatchRecordList = @"FamilyCoachApi/GetWatchRecordList";              // 获取阅读记录
NSString * const FC_AddFcWatchRecord = @"FamilyCoachApi/AddFcWatchRecord";              // 添加阅读记录


/***   个人中心   ***/
NSString * const PC_GetPersonalCenterUser = @"PersonalCenterApi/GetPersonalCenterUser";              // 获取个人中心用户资料
NSString * const PC_GetCoachUser = @"PersonalCenterApi/GetCoachUser";// 获取个人中心用户资料教练模型
NSString * const PC_GetBookUser = @"PersonalCenterApi/GetBookUser";              // 获取个人中心用户资料绘本作者
NSString * const PC_GetArticleUser = @"PersonalCenterApi/GetArticleUser";             // 获取个人中心用户资料首页文章作者
NSString * const PC_GetPersonalAppointment = @"PersonalCenterApi/GetPersonalAppointment";              // 获取个人中心我的预约
NSString * const PC_GetReadRecord = @"PersonalCenterApi/GetReadRecord";              // 获取个人中心阅读记录
NSString * const PC_GetOrderCourses = @"PersonalCenterApi/GetOrderCourses";              // 根据用户编号获取已购课程
NSString * const PC_GetPersonalCollect = @"PersonalCenterApi/GetPersonalCollect";              // 获取个人中心我的收藏
NSString * const PC_DeleteCollect = @"PersonalCenterApi/DeleteCollect";              // 删除收藏
NSString * const PC_DeleteReadRecord = @"PersonalCenterApi/DeleteReadRecord";              // 删除阅读记录
NSString * const PC_GetOrderRecord = @"PersonalCenterApi/GetOrderRecord";              // 根据用户编号获取订单记录
NSString * const PC_GetFollowAndFans = @"UserApi/GetFollowAndFans";              // 根据用户编号，获取关注的人，及粉丝
NSString * const PC_GetIntegralForUserId = @"UserApi/GetIntegralForUserId";              // 根据用户编号，获取积分流水
NSString * const PC_UpdatePersonal = @"PersonalCenterApi/UpdatePersonal";              // 修改个人中心资料
NSString * const PC_AiIdcard = @"PersonalCenterApi/AiIdcard";              // ai识别身份证
NSString * const PC_GetUserMessage = @"PersonalCenterApi/GetUserMessage";              // 获取未读消息POST
NSString * const PC_UpdateMessageStatus = @"PersonalCenterApi/UpdateMessageStatus";              // 修改消息状态;
NSString * const PC_ReplacePhoneOneCode = @"PersonalCenterApi/ReplacePhoneOneCode";              // 更换手机，旧手机号验证
NSString * const PC_ReplacePhoneNew = @"PersonalCenterApi/ReplacePhoneNew";              // 更换手机，新手机号处理
NSString * const PC_ChangePassword = @"PersonalCenterApi/ChangePassword";              // 修改密码
NSString * const PC_FeedbackMessage = @"PersonalCenterApi/FeedbackMessage";              // 个人中心反馈留言
NSString * const PC_AddOrEditBaby = @"PersonalCenterApi/AddOrEditBaby";              // 添加单个宝宝操作
NSString * const PC_DeleteBaby = @"PersonalCenterApi/DeleteBaby";              // 删除单个宝宝操作
NSString * const PC_GetDynamicForUserId = @"PersonalCenterApi/GetDynamicForUserId";              //根据用户编号获取动态（查看普通用户，及查看自己的动态)
NSString * const PC_GetFollowDynamic = @"PersonalCenterApi/GetFollowDynamic";              //根据用户编号获取关注者动态（首页关注)
NSString * const PC_DeleteDynamic = @"PersonalCenterApi/DeleteDynamic";              //删除动态
NSString * const PC_GetSearchRedUser = @"PersonalCenterApi/GetSearchRedUser";              //获取推荐用户
NSString * const PC_GetSearchUser = @"UserApi/GetSearchUser";              //获取搜索用户GET
NSString * const PC_ConcernUser = @"UserApi/ConcernUser";              //关注用户
NSString * const PC_CancelConcern = @"UserApi/CancelConcern";              //取消关注
NSString * const PC_AddBabyPhysiqueRecord = @"PersonalCenterApi/AddBabyPhysiqueRecord";              //添加宝宝成长记录
NSString * const PC_GetArticlePage = @"PersonalCenterApi/GetArticlePage";              //根据用户id 分页获取绘本
NSString * const PC_GetBookPage = @"PersonalCenterApi/GetBookPage";              //根据用户id分页获取文章列表
NSString * const PC_GetUserCourses = @"PersonalCenterApi/GetUserCourses";              //根据用户id分页获取教练作品列表
NSString * const PC_CancelAppointment = @"BrandApi/CancelAppointment";              //取消预约
NSString * const PC_UpdateAppointmentStatus = @"DetectionApi/UpdateAppointmentStatus";              //取消预约（基因检测）
NSString * const PC_GetSignInList = @"UserApi/GetSignInList";              //获取签到集合（7天）
NSString * const PC_SignIn = @"UserApi/SignIn";              //签到
NSString * const PC_GetDetectionReport = @"PersonalCenterApi/GetDetectionReport";              //获取检测报告


/***   盒子相关   ***/
NSString * const PC_GetBoxUseTime = @"BoxApi/GetBoxUseTime";              //获取盒子使用时间
NSString * const PC_GetBoxTimeRemind = @"BoxApi/GetBoxTimeRemind";              //获取盒子提醒时间
NSString * const PC_SetBoxUseTime = @"BoxApi/setBoxUseTime";              //设置盒子使用时间
NSString * const PC_SetBoxTimeRemind = @"BoxApi/SetBoxTimeRemind";              //设置盒子提醒时间
NSString * const PC_TransferBox = @"BoxApi/TransferBox";              //转移盒子权限
NSString * const PC_AppActivityBox = @"BoxApi/AppActivityBox";              //APP激活盒子POST


NSString * const PC_GetIncomeCenter = @"SaleApi/GetIncomeCenter";              //根据用户编号获取权益中心内容
NSString * const PC_GetIncomeList = @"UserApi/GetIncomeList";              //根据收益类型分页获取收益列表
NSString * const PC_GetMyTeamForApp = @"UserApi/GetMyTeamForApp";              //根据用户Id分页获取用户团队成员列表
NSString * const PC_GetMyBankCard = @"UserApi/GetMyBankCard";              //H5分销系统--根据用户Id获取用户银行卡列表
NSString * const PC_CreateBankCard = @"UserApi/CreateBankCard";              //添加银行卡
NSString * const PC_DrawMoneyToBank = @"DrawMoneyApi/DrawMoneyToBank";              //申请提现到银行卡
NSString * const PC_GetDrawMoneyRecord = @"DrawMoneyApi/GetDrawMoneyRecord";              //分页获取我的申请提现记录
NSString * const PC_ForgetDrawMoneyPassword = @"UserApi/ForgetDrawMoneyPassword";              //忘记提现密码--验证提交信息是否正确


