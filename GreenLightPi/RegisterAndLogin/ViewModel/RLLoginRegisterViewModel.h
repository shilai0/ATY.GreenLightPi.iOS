//
//  RLLoginRegisterViewModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewModel.h"

@interface RLLoginRegisterViewModel : BaseViewModel

/** 登录指令 */
@property (nonatomic, strong, readonly) RACCommand *loginCommand;

/** 发送验证码(涉及业务) */
@property (nonatomic, strong, readonly) RACCommand *getVerificationCodeCommand;

/** 注册 */
@property (nonatomic, strong, readonly) RACCommand *registerCommand;

/** 忘记密码 */
@property (nonatomic, strong, readonly) RACCommand *resetPasswordCommand;

/** 绑定用户 */
@property (nonatomic, strong, readonly) RACCommand *BindUserCommand;

/** 绑定宝宝信息上传宝宝头像 */
@property (nonatomic, strong, readonly) RACCommand *saveBabyImageCommand;

/** 添加宝宝信息 */
@property (nonatomic, strong, readonly) RACCommand *creatBabyInfoCommand;

/** 微信登录获取access_token */
@property (nonatomic, strong, readonly) RACCommand *getWXAcessTokenCommand;

/** 微信登录获取refresh_token */
@property (nonatomic, strong, readonly) RACCommand *getWXRefreshTokenCommand;

/** 微信登录获取用户信息 */
@property (nonatomic, strong, readonly) RACCommand *getWXUserInfoCommand;

/** 根据名称获取版本 */
@property (nonatomic, strong, readonly) RACCommand *getVersonForNameCommand;

@end
