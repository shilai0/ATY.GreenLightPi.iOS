//
//  AdModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/22.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 adcontent_id (integer, optional): 广告内容id ,
 title (string, optional): 广告标题 ,
 content (string, optional): 广告内容 ,
 filelist (Array[FileEntityModel], optional): 文件类型 例如引导页 存储3张图片
 */
@class FileEntityModel;
@interface AdModel : NSObject
@property (nonatomic, strong)NSArray *filelist;
@property (nonatomic, copy) NSNumber *adcontent_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@end
