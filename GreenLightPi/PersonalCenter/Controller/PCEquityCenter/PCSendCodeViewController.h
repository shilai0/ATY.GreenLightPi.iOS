//
//  PCSendCodeViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/12.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    SendMessageTypeSetPasssWord,// ,我的银行卡列表添加银行卡进来
    SendMessageTypeResetPassWord,// ,提现忘记密码重新绑定进来
    SendMessageTypeAddResetPasssWord,//,提现忘记密码添加银行卡进来
    SendMessageTypeSelectBankCard,//提现添加银行卡进来
} SendMessageType;


NS_ASSUME_NONNULL_BEGIN

@interface PCSendCodeViewController : BaseViewController
@property (nonatomic, copy) NSString *phoneStr;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign) SendMessageType sendMessageType;
@end

NS_ASSUME_NONNULL_END
