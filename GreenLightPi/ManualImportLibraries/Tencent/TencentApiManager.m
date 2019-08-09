//
//  TencentApiManager.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "TencentApiManager.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "RLLoginRegisterViewModel.h"
#import "MainTabBarViewController.h"
#import "RLBindOneViewController.h"
#import "BaseNavigationViewController.h"
#import "UserModel.h"
#import "ATYCache.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#import <UserNotifications/UserNotifications.h>

static NSInteger seq = 0;

@interface TencentApiManager ()
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegisterVM;
@end

@implementation TencentApiManager

- (RLLoginRegisterViewModel *)loginRegisterVM {
    if (!_loginRegisterVM) {
        _loginRegisterVM = [[RLLoginRegisterViewModel alloc] init];
    }
    return _loginRegisterVM;
}

+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static TencentApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[TencentApiManager alloc] init];
    });
    return instance;
}

#pragma mark -- TencentSessionDelegate
//登录成功
- (void)tencentDidLogin
{
    NSLog(@"登录完成");
    
    if (_tencentOAuth.accessToken && 0 != [_tencentOAuth.accessToken length]) {
        // 记录登录用户的OpenID、Token以及过期时间
        NSLog(@"%@",_tencentOAuth.accessToken);
        [[NSUserDefaults standardUserDefaults] setObject:_tencentOAuth.accessToken forKey:QQ_ACCESS_TOKEN];
        [[NSUserDefaults standardUserDefaults] setObject:_tencentOAuth.openId forKey:QQ_OPEN_ID];
        [[NSUserDefaults standardUserDefaults] setObject:_tencentOAuth.expirationDate forKey:QQ_EXPIRATIONDATE];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [_tencentOAuth getUserInfo];
    } else {
        NSLog(@"登录不成功 没有获取accesstoken");
    }
}

//非网络错误导致登录失败
-(void)tencentDidNotLogin:(BOOL)cancelled
{
    if (cancelled) {
        NSLog(@"用户取消登录");
    } else {
        NSLog(@"登录失败");
    }
}

//网络错误导致登录失败
-(void)tencentDidNotNetWork
{
    NSLog(@"无网络连接，请设置网络");
    
}


// 处理来至QQ的请求

- (void)onReq:(QQBaseReq *)req{
    NSLog(@" ----req %@",req);
}


//处理来至QQ的响应
- (void)onResp:(QQBaseResp *)resp{
    NSLog(@" ----resp %@",resp);
}

//处理QQ在线状态的回调

- (void)isOnlineResponse:(NSDictionary *)response{
    
}

-(void)getUserInfoResponse:(APIResponse *)response
{
    NSLog(@"respons:%@",response.jsonResponse);
    if (response && response.retCode == URLREQUEST_SUCCEED) {
        NSDictionary *dic = [response jsonResponse];
            [[NSUserDefaults standardUserDefaults] setObject:dic[@"figureurl_qq_2"] forKey:QQ_HEADIMGURL];
            [[NSUserDefaults standardUserDefaults] synchronize];
        [self loginAction];
    } else {
        NSLog(@"获取用户信息失败");
    }
}

- (void)loginAction {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"loginType"] = [NSNumber numberWithInteger:3];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:QQ_OPEN_ID];
    params[@"openid"] = openID;
    params[@"image"] = [[NSUserDefaults standardUserDefaults] objectForKey:QQ_HEADIMGURL];
    @weakify(self);
    [[self.loginRegisterVM.loginCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSNumber *code = x[@"Msg"][@"code"];
        NSNumber *success = x[@"Success"];
        if (x != nil && [success boolValue] && [code isEqual:@1000]) {
            UserModel *userModel = [UserModel mj_objectWithKeyValues:x[@"Data"]];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:userModel.phone forKey:PROJECT_PHONE];
            [userDefaults setObject:userModel.token forKey:PROJECT_TOKEN];
            [userDefaults setObject:userModel.user_id forKey:PROJECT_USER_ID];
            [ATYCache saveDataCache:userModel forKey:PROJECT_USER];
            [userDefaults synchronize];
            
            [JPUSHService setAlias:[NSString stringWithFormat:@"%@",userModel.user_id] completion:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
            } seq:[self seq]];
            
            MainTabBarViewController *mainTabBarVC = [[MainTabBarViewController alloc] init];
            mainTabBarVC.isFirstRegister = NO;
            // 添加动画效果
            mainTabBarVC.view.layer.transform = CATransform3DMakeScale(1.3, 1.3, 0);
            [UIView animateWithDuration:0.35 animations:^{
                mainTabBarVC.view.layer.transform = CATransform3DIdentity;
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = mainTabBarVC;
            }];
        } else if (x != nil && [code isEqual:@1002]) {//未选择身份
//            NSString *userId = x[@"Data"][@"data"];
//            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//            [userDefaults setObject:userId forKey:PROJECT_USER_ID];
//            SelectIdentityViewController *selectIdentityVC = [[SelectIdentityViewController alloc] init];
//            UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
//            BaseNavigationViewController *vc = (BaseNavigationViewController *)keyWindow.rootViewController;
//            [vc pushViewController:selectIdentityVC animated:YES];
        } else if (x != nil && [code isEqual:@1001]) {//未绑定
            RLBindOneViewController *bindOneVC = [[RLBindOneViewController alloc] init];
            UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
            BaseNavigationViewController *vc = (BaseNavigationViewController *)keyWindow.rootViewController;
            [vc pushViewController:bindOneVC animated:YES];
        }
    }];
}

- (NSInteger)seq {
    return ++ seq;
}

@end
