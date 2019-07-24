//
//  HomeModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/21.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 id (integer, optional): 内容Id(文章/绘本/课程id) ,
 title (string, optional): 标题 ,
 content
 imagePath (string, optional): 图片地址 ,
 contentType (integer, optional): 内容类型：音频/视频/图文 = ['1', '2', '3', '4'],
 section (integer, optional): 所属首页模块 = ['1', '2', '3'],
 category (integer, optional): 亲子时光内容分类 = ['1', '2'],
 categoryId (integer, optional): 读吧/玩吧 分类id
 **/

@interface HomeModel : NSObject
@property (nonatomic, assign) NSInteger content_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, assign) NSInteger contentType;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, assign) NSInteger category;
@property (nonatomic, assign) NSInteger categoryId;
@end

