//
//  PCMyCollectModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/28.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 typeName (string, optional): 类别名 ,
 collectList (Array[CollectModel], optional): 收藏列表
 */
@class FileEntityModel;
@interface PCMyCollectModel : NSObject
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, strong) NSArray *collectList;
@end

/**
 time (string, optional): 收藏日期 ,
 ctime (string, optional): 收藏时间 ,
 title (string, optional): 标题 ,
 image (FileEntityModel, optional): 视频音频为地址，其他为图片 ,
 collectContentType (string, optional): 收藏类型 ,
 collectModularType (string, optional): 模块类别名 ,
 collectId (integer, optional): 收藏id
 contactId (integer, optional)收藏的内容的id
 */
@interface CollectModel : NSObject
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) FileEntityModel *image;
@property (nonatomic, copy) NSString *collectContentType;
@property (nonatomic, copy) NSString *collectModularType;
@property (nonatomic, copy) NSNumber *collectId;
@property (nonatomic, copy) NSNumber *contactId;
@end


