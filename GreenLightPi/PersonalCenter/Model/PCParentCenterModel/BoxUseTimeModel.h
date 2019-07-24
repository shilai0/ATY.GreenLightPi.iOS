//
//  BoxUseTimeModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/14.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 boxId (integer, optional): 盒子id ,
 startTime (string, optional): 开始时间09:10 ,
 endTime (string, optional): 结束时间18:00 ,
 isUse (integer, optional): 是否使用(1为使用，0为不使用)
 */

@interface BoxUseTimeModel : NSObject
@property (nonatomic, assign) NSInteger boxId;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, assign) NSInteger isUse;
@end


