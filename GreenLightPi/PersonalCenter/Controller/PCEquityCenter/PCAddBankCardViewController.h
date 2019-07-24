//
//  PCAddBankCardViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/11.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    AddBankCardTypeDefault,// ,我的银行卡列表添加银行卡
    AddBankCardTypeForRessetPassword,// ,提现忘记密码添加银行卡以找回密码
    AddBankCardTypeSelectBankCard,//提现添加银行卡
} AddBankCardType;

NS_ASSUME_NONNULL_BEGIN

@interface PCAddBankCardViewController : BaseViewController
@property (nonatomic, assign) AddBankCardType addBankCardType;
@end

NS_ASSUME_NONNULL_END
