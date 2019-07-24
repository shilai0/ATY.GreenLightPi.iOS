//
//  PCBrowseTypeModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/23.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 typeName (string, optional): 类别名 ,
 browseList (Array[BrowseModel], optional): 浏览记录列表
 */
@class FileEntityModel;
@interface PCBrowseTypeModel : NSObject
@property (nonatomic, strong) NSArray *browseList;
@property (nonatomic, copy) NSString *typeName;
@end

/**
 time (string, optional): 浏览记录日期 ,
 ctime (string, optional): 浏览记录时间 ,
 title (string, optional): 标题 ,
 image (FileEntityModel, optional): 视频音频为地址，其他为图片 ,
 browseContentType (string, optional): 收藏类型 ,
 browseModularType (string, optional): 模块类别名 ,
 browseId (integer, optional): 收藏id
 contactId (integer, optional)收藏的内容的id
 */
@interface BrowseModel : NSObject
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) FileEntityModel *image;
@property (nonatomic, copy) NSString *browseContentType;
@property (nonatomic, copy) NSString *browseModularType;
@property (nonatomic, copy) NSNumber *browseId;
@property (nonatomic, copy) NSNumber *contactId;
@end
