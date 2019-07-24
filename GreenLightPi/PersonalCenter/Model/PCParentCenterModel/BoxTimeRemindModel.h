//
//  BoxTimeRemindModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/14.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 boxId (integer, optional): 盒子id ,
 defaultTime (integer, optional): 默认提醒时间 ,
 customTime (integer, optional): 自定义提醒时间 ,
 isUseCustom (integer, optional): 是否使用自定义
 */
@interface BoxTimeRemindModel : NSObject
@property (nonatomic, assign) NSInteger boxId;
@property (nonatomic, assign) NSInteger defaultTime;
@property (nonatomic, assign) NSInteger customTime;
@property (nonatomic, assign) NSInteger isUseCustom;
@end


