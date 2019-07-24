//
//  BabyModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/21.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 baby_id (integer, optional): 宝宝id ,
 path (string, optional): 头像路径 ,
 nikename (string, optional): 宝宝昵称 ,
 sex (integer, optional): 宝宝性别 0女 1男 = ['0', '1'],
 birthday (string, optional): 宝宝生日 ,
 weight (number, optional): 出生体重 ,
 height (integer, optional): 出生身高
 age (string, optional): 宝宝年龄（1岁1个月）
 userRole (integer, optional): 用户和宝宝的关系 0:妈妈 1:爸爸
 */

@interface BabyModel : NSObject
@property (nonatomic, assign) NSInteger baby_id;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *nikename;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, assign) NSInteger weight;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, assign) NSInteger userRole;
@end
