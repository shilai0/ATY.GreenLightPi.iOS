//
//  PCSetCashOutPassWordViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/12.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    PassWordTypeSet,// ,我的银行卡列表添加银行卡进来
    PassWordTypeReset,// ,提现忘记密码重新绑定进来
    PassWordTypeAddReset,//提现忘记密码添加银行卡进来
    PassWordTypeAddSelectCard,//提现选择银行卡列表添加银行卡进来
} PassWordType;

NS_ASSUME_NONNULL_BEGIN

@interface PCSetCashOutPassWordViewController : BaseViewController
@property (nonatomic, copy) NSString *codeStr;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign) PassWordType passWordType;
@end

NS_ASSUME_NONNULL_END
