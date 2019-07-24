//
//  ATYConst.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 输入框的高度 */
NSInteger const TextFieldHeight = 53;
/* 用户手机号 */
NSString * const PROJECT_USER_ID = @"PROJECT_USER_ID";
NSString * const PROJECT_TOKEN = @"PROJECT_TOKEN";
NSString * const PROJECT_PHONE = @"PROJECT_PHONE";
NSString * const PROJECT_USER = @"PROJECT_USER";
NSString * const PROJECT_PASSWORD = @"PROJECT_PASSWORD";

NSString * const PROJECT_BOXID = @"PROJECT_BOXID";

/* 第三方微信登录信息存储 */
NSString * const WX_ACCESS_TOKEN = @"WX_ACCESS_TOKEN";
NSString * const WX_OPEN_ID = @"WX_OPEN_ID";
NSString * const WX_UNION_ID = @"WX_UNION_ID";
NSString * const WX_REFRESH_TOKEN = @"WX_REFRESH_TOKEN";
NSString * const WX_HEADIMGURL = @"WX_HEADIMGURL";

/* 第三方QQ登录信息存储 */
NSString * const QQ_ACCESS_TOKEN = @"QQ_ACCESS_TOKEN";
NSString * const QQ_OPEN_ID = @"QQ_OPEN_ID";
NSString * const QQ_EXPIRATIONDATE = @"QQ_EXPIRATIONDATE";
NSString * const QQ_HEADIMGURL = @"QQ_HEADIMGURL";

/** 编辑频道的通知 **/
NSString * const EDITECHANLE_CONTENT_NOTIFICATION = @"EDITECHANLE_CONTENT_NOTIFICATION";

/** 个人中心修改头像 **/
NSString * const CHANGEHEADIMAGE_CONTENT_NOTIFICATION = @"CHANGEHEADIMAGE_CONTENT_NOTIFICATION";

/** 移除家庭组成员通知 **/
NSString * const DELETEFAMILYMEMBER_NOTIFICATION = @"DELETEFAMILYMEMBER_NOTIFICATION";

/** 本地搜索历史 **/
NSString * const SEARCHHISTORY = @"SEARCHHISTORY";

/** 权益中心用户所添加的银行卡 **/
NSString * const BANKCARDARR = @"BANKCARDARR";//

/** 转移盒子权限的通知 **/
NSString * const TRANSFORMPARK_NOTIFICATION = @"TRANSFORMPARK_NOTIFICATION";

/**  收到盒子推送消息  **/
NSString * const PUSHMESSAGE_NOTIFICATION = @"PUSHMESSAGE_NOTIFICATION";

/**  收到权益中心银行卡添加成功的通知  **/
NSString * const ADDBANKSUCCESS_NOTIFICATION = @"ADDBANKSUCCESS_NOTIFICATION";

/**  收到权益中心银行卡添加成功的通知（提现）  **/
NSString * const ADDBANKSUCCASHOUT_NOTIFICATION = @"ADDBANKSUCCASHOUT_NOTIFICATION";

/**  收到权益中心提现成功的通知  **/
NSString * const CASHOUTSUCCESS_NOTIFICATION = @"CASHOUTSUCCESS_NOTIFICATION";
