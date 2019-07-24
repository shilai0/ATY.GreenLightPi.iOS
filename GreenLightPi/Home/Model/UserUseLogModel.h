//
//  UserUseLogModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/2.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 boxName (string, optional): 盒子名称 ,
 boxId (integer, optional): 盒子编号 ,
 userId (integer, optional): 用户编号 ,
 useLogModels (Array[UseLogModel], optional): 使用记录集合
 */

@interface UserUseLogModel : NSObject
@property (nonatomic, copy) NSString *boxName;
@property (nonatomic, assign) NSInteger boxId;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSArray *useLogModels;
@end

/**
 date (string, optional): 日期 ,
 useTime (integer, optional): 使用时间 ,
 remarks (string, optional): 备注 ,
 useDetails (Array[UseDetailModel], optional): 使用详情集合
 */
@interface UseLogModel : NSObject
@property (nonatomic, copy) NSString *date;
@property (nonatomic, assign) NSInteger useTime;
@property (nonatomic, copy) NSString *boxName;
@property (nonatomic, copy) NSString *remarks;
@property (nonatomic, strong) NSArray *useDetails;
@property (nonatomic, assign) BOOL isOpen;
@end

/**
 contentId (integer, optional): 内容id ,
 imagePath (string, optional): 图片地址 ,
 name (string, optional): 内容名称 ,
 duration (integer, optional): 使用时长
 */
@interface UseDetailModel : NSObject
@property (nonatomic, assign) NSInteger contentId;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, assign) NSInteger longDuration;
@end

