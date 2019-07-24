//
//  PCMessageModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/3.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 userMessageList (Array[UserMessageModel], optional): 用户消息 ,
 sysMessageList (Array[SysMessageModel], optional): 系统消息 ,
 businessMessageList (Array[BusinessMessageModel], optional): 商家消息集合
 */
@interface PCMessageModel : NSObject
@property (nonatomic, strong) NSArray *userMessageList;
@property (nonatomic, strong) NSArray *sysMessageList;
@property (nonatomic, strong) NSArray *businessMessageList;
@end

/**
 userMessage_id (string, optional): 用户消息编号 ,
 category (string, optional): 消息分类：点赞，评论，转发，关注。回答 ,
 moduleType (string, optional): 该消息用于什么模块 ,
 publisherPersonId (integer, optional): 发布人编号 ,
 name (string, optional): 发布人昵称 ,
 imagePath (string, optional): 发布人头像地址 ,
 contentImagePath (string, optional): 内容图片编号 ,
 all_id (integer, optional): 内容id
 title (string, optional): 文字标题或内容
 */
@interface UserMessageModel : NSObject
@property (nonatomic, copy) NSString *userMessage_id;
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *moduleType;
@property (nonatomic, copy) NSNumber *publisherPersonId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *contentImagePath;
@property (nonatomic, copy) NSNumber *all_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *time;
@end

/**
 pushMessage_id (integer, optional): 消息编号 ,
 title (string, optional): 标题 ,
 introduction (string, optional): 简介 ,
 messageContent (string, optional): 消息内容 ,
 ctime (string, optional): 创建时间
 */
@interface SysMessageModel : NSObject
@property (nonatomic, copy) NSNumber *pushMessage_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *introduction;
@property (nonatomic, copy) NSString *messageContent;
@property (nonatomic, copy) NSString *ctime;
@end

/**
 pushMessage_id (integer, optional): 消息编号 ,
 title (string, optional): 标题 ,
 remark (string, optional): 备注 ,
 storeName (string, optional): 店铺名 ,
 imagePath (string, optional): 相关图片地址 ,
 ctime (string, optional): 创建时间 ,
 messageType (string, optional): 消息分类 ,
 all_id (integer, optional): 关联内容编号
 */
@interface BusinessMessageModel : NSObject
@property (nonatomic, copy) NSNumber *pushMessage_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *messageType;
@property (nonatomic, copy) NSNumber *all_id;
@end
