//
//  ATYConst.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/* 输入框的高度 */
extern NSInteger const TextFieldHeight;

/* 用户信息 */
extern NSString * const PROJECT_USER_ID;
extern NSString * const PROJECT_TOKEN;
extern NSString * const PROJECT_PHONE;
extern NSString * const PROJECT_USER;
extern NSString * const PROJECT_PASSWORD;

extern NSString * const PROJECT_BOXID;

/* 第三方微信登录信息存储 */
extern NSString * const WX_ACCESS_TOKEN;
extern NSString * const WX_OPEN_ID;
extern NSString * const WX_UNION_ID;
extern NSString * const WX_REFRESH_TOKEN;
extern NSString * const WX_HEADIMGURL;

/* 第三方QQ登录信息存储 */
extern NSString * const QQ_ACCESS_TOKEN;
extern NSString * const QQ_OPEN_ID;
extern NSString * const QQ_EXPIRATIONDATE;
extern NSString * const QQ_HEADIMGURL;

/** 编辑频道的通知 **/
extern NSString * const EDITECHANLE_CONTENT_NOTIFICATION;

/** 个人中心修改头像 **/
extern NSString * const CHANGEHEADIMAGE_CONTENT_NOTIFICATION;

/** 移除家庭组成员通知 **/
extern NSString * const DELETEFAMILYMEMBER_NOTIFICATION;

/** 本地搜索历史 **/
extern NSString * const SEARCHHISTORY;

/** 权益中心用户所添加的银行卡 **/
extern NSString * const BANKCARDARR;//;

/** 转移盒子权限的通知 **/
extern NSString * const TRANSFORMPARK_NOTIFICATION;

/**  收到盒子推送消息  **/
extern NSString * const PUSHMESSAGE_NOTIFICATION;

/**  收到权益中心银行卡添加成功的通知（我的银行卡列表）  **/
extern NSString * const ADDBANKSUCCESS_NOTIFICATION;

/**  收到权益中心银行卡添加成功的通知（提现）  **/
extern NSString * const ADDBANKSUCCASHOUT_NOTIFICATION;

/**  收到权益中心提现成功的通知  **/
extern NSString * const CASHOUTSUCCESS_NOTIFICATION;
