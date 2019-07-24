//
//  CardTypeBaseApiModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/12/26.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 cardTypeId (integer, optional): 店铺会员卡分类Id ,
 typeName (string, optional): 店铺会员卡分类名称 ,
 imagePath (string, optional): 会员卡分类图片 ,
 cardList (Array[StoreCardApiModel], optional): 店铺卡分类下的会员卡集合
 **/
@interface CardTypeBaseApiModel : NSObject
@property (nonatomic, strong) NSArray *cardList;
@property (nonatomic, copy) NSString *typeName;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *cardTypeId;
@end

/**
 isBuy (integer, optional): 是否已购买，1为已购买，0为未购买 ,
 cardId (integer, optional): 会员卡编号 ,
 cardName (string, optional): 会员卡名称 ,
 cardPrice (number, optional): 会员卡价格 ,
 cardExpire (string, optional): 会员卡有效期 ,
 cardRights (string, optional): 会员卡权益 ,
 imagePath (string, optional): 会员卡图片
 **/
@interface StoreCardApiModel : NSObject
@property (nonatomic, copy) NSNumber *isBuy;
@property (nonatomic, copy) NSNumber *cardId;
@property (nonatomic, copy) NSString *cardName;
@property (nonatomic, copy) NSNumber *cardPrice;
@property (nonatomic, copy) NSString *cardExpire;
@property (nonatomic, copy) NSString *cardRights;
@property (nonatomic, copy) NSString *imagePath;
@end

