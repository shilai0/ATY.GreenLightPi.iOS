//
//  FCAddPayModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/12.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 payType (integer, optional): 支付类型 = ['1', '2', '3'],
 itegralModel (IntegralModel, optional): 积分支付返回模型 ,
 zfbSigmStr (ZfbPlaceAnOrderModel, optional): 支付宝下单返回的签名 ,
 wxAddPay (WxAddPayUniOrderResp, optional): 微信下单返回的模型
 **/
@class IntegralModel,ZfbPlaceAnOrderModel,AwakenMos;
@interface FCAddPayModel : NSObject
@property (nonatomic, copy) NSNumber *payType;
@property (nonatomic, strong) IntegralModel *IntegralModel;
@property (nonatomic, strong) ZfbPlaceAnOrderModel *zfbSigmStr;
@property (nonatomic, strong) AwakenMos *wxAddPay;
@end

/**
 payStatus (integer, optional): 支付状态 0为失败，1为成功
 **/
@interface IntegralModel : NSObject
@property (nonatomic, copy) NSNumber *payStatus;
@end

/**
 signStr (string, optional): 签名
 **/
@interface ZfbPlaceAnOrderModel : NSObject
@property (nonatomic, copy) NSString *signStr;
@end

/**
 appid (string, optional),
 partnerid (string, optional),
 prepayid (string, optional),
 package (string, optional),
 noncestr (string, optional),
 timestamp (string, optional),
 sign (string, optional)
 **/
@interface AwakenMos : NSObject
@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *partnerid;
@property (nonatomic, copy) NSString *prepayid;
@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, copy) NSString *timestamp;
@property (nonatomic, copy) NSString *nonce_str;
@property (nonatomic, copy) NSString *sign;
@end

