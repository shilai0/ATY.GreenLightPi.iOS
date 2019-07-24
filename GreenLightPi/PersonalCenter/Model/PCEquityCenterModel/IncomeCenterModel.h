//
//  IncomeCenterModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/9.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 nikeName (string, optional): 昵称 ,
 imagePath (string, optional): 头像 ,
 user_id (integer, optional): 用户编号 ,
 Income (number, optional): 分销总收益 ,
 GradeStr (string, optional): 分销用户级别枚举中文名 ,
 DirectSaleIncome (number, optional): 直销奖励 ,
 FissionIncome (number, optional): 裂变奖励 ,
 TeamIncome (number, optional): 团队奖励 ,
 DevelopIncome (number, optional): 发展奖励 ,
 CityIncome (number, optional): 城市奖励 ,
 ExtensionIncome (number, optional): 推广奖励 ,
 TeamMemberCount (integer, optional): 团队人数
 UserGrade (string, optional): 用户分销等级 //A联合创始人 B城市合伙人 C推广合伙人 D消费代言人 E普通用户
 ExtensionQRCode (string, optional),
 ExtensionLink (string, optional),
 DevelopQRCode (string, optional),
 DevelopLink (string, optional)
 **/

@interface IncomeCenterModel : NSObject
@property (nonatomic, copy) NSString *nikeName;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, assign) NSInteger user_id;
@property (nonatomic, copy) NSNumber *Income;
@property (nonatomic, copy) NSString *GradeStr;
@property (nonatomic, assign) NSNumber *DirectSaleIncome;
@property (nonatomic, assign) NSNumber *FissionIncome;
@property (nonatomic, assign) NSNumber *TeamIncome;
@property (nonatomic, assign) NSNumber *DevelopIncome;
@property (nonatomic, assign) NSNumber *CityIncome;
@property (nonatomic, assign) NSNumber *ExtensionIncome;
@property (nonatomic, assign) NSInteger TeamMemberCount;
@property (nonatomic, copy) NSString *UserGrade;
@property (nonatomic, copy) NSString *ExtensionQRCode;
@property (nonatomic, copy) NSString *ExtensionLink;
@property (nonatomic, copy) NSString *DevelopQRCode;
@property (nonatomic, copy) NSString *DevelopLink;
@end

NS_ASSUME_NONNULL_END
