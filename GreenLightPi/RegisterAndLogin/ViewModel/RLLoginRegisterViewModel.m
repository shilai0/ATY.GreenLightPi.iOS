//
//  RLLoginRegisterViewModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "RLLoginRegisterViewModel.h"
#import "BaseRequest.h"

@implementation RLLoginRegisterViewModel

- (void)xs_initializesOperating {
    /*********************** 登录命令 *************************/
    _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *loginSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"登录中..."];
            [BaseRequest POSTRequestDataWithReuestURL:RL_Login params:input success:^(NSDictionary *resultDic) {
//                if ([resultDic[@"Success"] intValue] == Success) {
//                    NSDictionary *dataDic = resultDic[@"Data"];
//                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                    [userDefaults setObject:input[@"telephone"] forKey:PROJECT_PHONE];
//                    [userDefaults setObject:dataDic[@"token"] forKey:PROJECT_TOKEN];
//                    [userDefaults setObject:dataDic[@"user_id"] forKey:PROJECT_USER_ID];
//                    [userDefaults setObject:dataDic forKey:PROJECT_USER];
//                    [userDefaults synchronize];
//                    [subscriber sendNext:resultDic];
//                } else {
                    [subscriber sendNext:resultDic];
//                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return loginSignal;
    }];
    
    /*********************** 发送验证码（涉及业务） *************************/
    _getVerificationCodeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *sendCodeSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:RL_SendVerificationCode params:input success:^(NSDictionary *resultDic) {
                if ([resultDic[@"Success"] intValue] == Success) {
                    [subscriber sendNext:resultDic];
                } else {
                    [subscriber sendNext:nil];
                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return sendCodeSignal;
    }];
    
    /*********************** 注册 *************************/
    _registerCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *registerSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"正在注册..."];
            [BaseRequest POSTRequestDataWithReuestURL:RL_Register params:input success:^(NSDictionary *resultDic) {
                if ([resultDic[@"Success"] intValue] == Success) {
                    [subscriber sendNext:resultDic];
                } else {
                    [subscriber sendNext:nil];
                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return registerSignal;
    }];
    
    /*********************** 找回密码 *************************/
    _resetPasswordCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *resetPasswordSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:RL_ResetPassword params:input success:^(NSDictionary *resultDic) {
                if ([resultDic[@"Success"] intValue] == Success) {
                    [subscriber sendNext:resultDic];
                } else {
                    [subscriber sendNext:nil];
                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return resetPasswordSignal;
    }];
    
    /*********************** 绑定用户 *************************/
    _BindUserCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *bindUserSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:RL_BindUser params:input success:^(NSDictionary *resultDic) {
                if ([resultDic[@"Success"] intValue] == Success) {
                    NSDictionary *dataDic = resultDic[@"Data"];
                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                    [userDefaults setObject:input[@"telephone"] forKey:PROJECT_PHONE];
                    [userDefaults setObject:dataDic[@"token"] forKey:PROJECT_TOKEN];
                    [userDefaults setObject:dataDic[@"user_id"] forKey:PROJECT_USER_ID];
                    [userDefaults synchronize];
                    [subscriber sendNext:resultDic];
                } else {
                    [subscriber sendNext:resultDic];
                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return bindUserSignal;
    }];
    
    /*********************** 绑定宝宝上传宝宝头像 *************************/
    _saveBabyImageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *saveBabyImageSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
//            [BaseRequest POSTRequestDataWithReuestURL:RL_SaveBabyImage params:input success:^(NSDictionary *resultDic) {
//                if ([resultDic[@"Success"] intValue] == Success) {
//                    [subscriber sendNext:resultDic];
//                } else {
//                    [subscriber sendNext:nil];
//                }
//                [subscriber sendCompleted];
//                [MBProgressHUD hideHUD];
//            }];
            [BaseRequest UploadWithURL:common_uploadFile params:input[@"params"] imageArr:input[@"imgArr"] success:^(NSDictionary *resultDic) {
                if ([resultDic[@"Success"] intValue] == Success) {
                    [subscriber sendNext:resultDic];
                } else {
                    [subscriber sendNext:nil];
                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return saveBabyImageSignal;
    }];
    
    /*********************** 创建宝宝信息 *************************/
    _creatBabyInfoCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *creatBabyInfoSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest POSTRequestDataWithReuestURL:RL_CreatBabyInfo params:input success:^(NSDictionary *resultDic) {
                if ([resultDic[@"Success"] intValue] == Success) {
                    [subscriber sendNext:resultDic];
                } else {
                    [subscriber sendNext:nil];
                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return creatBabyInfoSignal;
    }];
    
    /*********************** 微信登录获取access_token *************************/
    _getWXAcessTokenCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *wxAcessTokenSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:@"https://api.weixin.qq.com/sns/oauth2/access_token" params:input success:^(NSDictionary *resultDic) {
//                if ([resultDic[@"Success"] intValue] == Success) {
//                    [subscriber sendNext:resultDic];
//                } else {
//                    [subscriber sendNext:nil];
//                }
                [subscriber sendNext:resultDic];
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return wxAcessTokenSignal;
    }];
    
    /*********************** 微信登录获取refresh_token *************************/
    _getWXRefreshTokenCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *wxRefreshTokenSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:@"https://api.weixin.qq.com/sns/oauth2/refresh_token" params:input success:^(NSDictionary *resultDic) {
//                if ([resultDic[@"Success"] intValue] == Success) {
//                    [subscriber sendNext:resultDic];
//                } else {
//                    [subscriber sendNext:nil];
//                }
                [subscriber sendNext:resultDic];
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return wxRefreshTokenSignal;
    }];
    
    /*********************** 微信登录获取用户信息 *************************/
    _getWXUserInfoCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *wxUserInfoSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:@"https://api.weixin.qq.com/sns/userinfo" params:input success:^(NSDictionary *resultDic) {
                //                if ([resultDic[@"Success"] intValue] == Success) {
                //                    [subscriber sendNext:resultDic];
                //                } else {
                //                    [subscriber sendNext:nil];
                //                }
                [subscriber sendNext:resultDic];
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return wxUserInfoSignal;
    }];
    
    /*********************** 根据名称获取版本 *************************/
    _getVersonForNameCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        RACSignal *getVersonForNameSignal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
            [BaseRequest GETRequestDataWithReuestURL:RL_GetVersonForName params:input success:^(NSDictionary *resultDic) {
                if ([resultDic[@"Success"] intValue] == Success) {
                    [subscriber sendNext:resultDic];
                } else {
                    [subscriber sendNext:nil];
                }
                [subscriber sendCompleted];
                [MBProgressHUD hideHUD];
            }];
            return nil;
        }];
        return getVersonForNameSignal;
    }];
    
}

@end
