//
//  PersonalCenterUserModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 image (FileEntityModel, optional): 头像 ,
 userId (integer, optional): 用户编号 ,
 resume (string, optional): 简介 ,
 isBind (integer, optional): 是否已经绑定，如果已经绑定，则不允许修改性别 = ['0', '1'],
 bindImagePath (string, optional),已绑定对方的头像
 authenticationStatus (string, optional): 认证状态 ,
 nikename (string, optional): 昵称 ,
 name (string, optional): 姓名 ,
 sex (integer, optional): 性别 = ['0', '1'],
 integral (integer, optional): 积分 ,
 followsCount (integer, optional): 关注数 ,
 fansCount (integer, optional): 粉丝数量 ,
 trendsCount (integer, optional): 动态 ,
 messageCount (integer, optional): 消息列表
 orderCount (integer, optional): 订阅数 ,
 isFollow (integer, optional): 是否关注
 isVip (integer, optional): 是否Vip ,
 cardIntegral (integer, optional): 用户所有会员卡总积分
 isActivation (integer, optional): 是否激活一家老小乐园 ,
 boxVoucher (integer, optional): 代金券余额
 UserGrade (string, optional): 用户分销等级 //A联合创始人 B城市合伙人 C推广合伙人 D消费代言人 E普通用户
 */

@class FileEntityModel;
@interface PersonalCenterUserModel : NSObject
@property (nonatomic, strong) FileEntityModel *image;
@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSString *resume;
@property (nonatomic, copy) NSNumber *isBind;
@property (nonatomic, copy) NSString *bindImagePath;
@property (nonatomic, copy) NSString *authenticationStatus;
@property (nonatomic, copy) NSString *nikename;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *sex;
@property (nonatomic, copy) NSNumber *integral;
@property (nonatomic, copy) NSNumber *followsCount;
@property (nonatomic, copy) NSNumber *fansCount;
@property (nonatomic, copy) NSNumber *trendsCount;
@property (nonatomic, copy) NSNumber *messageCount;
@property (nonatomic, copy) NSNumber *orderCount;
@property (nonatomic, copy) NSNumber *isFollow;
@property (nonatomic, copy) NSNumber *isVip;
@property (nonatomic, copy) NSNumber *cardIntegral;
@property (nonatomic, assign) NSInteger isActivation;
@property (nonatomic, assign) NSInteger boxVoucher;
@property (nonatomic, copy) NSString *UserGrade;
@end
