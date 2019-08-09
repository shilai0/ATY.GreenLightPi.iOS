//
//  WXApiManager.m
//  SDKSample
//
//  Created by Jeason on 16/07/2015.
//
//

#import "WXApiManager.h"
#import <WechatOpenSDK/WXApiObject.h>
#import "RLLoginRegisterViewModel.h"
#import "MainTabBarViewController.h"
#import "RLBindOneViewController.h"
#import "BaseNavigationViewController.h"
#import "UserModel.h"
#import "ATYCache.h"
#import "FCPaySuccesViewController.h"
#import "FCPayFailViewController.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#import <UserNotifications/UserNotifications.h>

static NSInteger seq = 0;

/**
 应用APPID：wx057396c823ea22ae
 APPSecret: 5c95b87b63bb5e35fb88049c22d22372
 **/

@interface WXApiManager()
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegisterVM;
@end

@implementation WXApiManager

- (RLLoginRegisterViewModel *)loginRegisterVM {
    if (!_loginRegisterVM) {
        _loginRegisterVM = [[RLLoginRegisterViewModel alloc] init];
    }
    return _loginRegisterVM;
}

#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiManager alloc] init];
    });
    return instance;
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
        if ([resp isKindOfClass:[SendAuthResp class]]) {
            // 微信登陆的返回信息
            SendAuthResp *sendAuthResp = (SendAuthResp *)resp;
            if (sendAuthResp.errCode == 0) {
                [self getAccess_Token:sendAuthResp.code];
            }
        }else if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
            // 微信分享
            //把返回的类型转换成与发送时相对于的返回类型,这里为SendMessageToWXResp
            SendMessageToWXResp *sendResp = (SendMessageToWXResp *)resp;
            if (sendResp.errCode == 0) {
                // 分享成功
            } else if (sendResp.errCode == -2) {
                // 取消分享
            }
        }else if ([resp isKindOfClass:[PayResp class]]) {
            // 微信支付回调
            //支付返回结果，实际支付结果需要去微信服务器端查询
//            NSString *strMsg,*strTitle = [NSString stringWithFormat:@"支付结果"];
//        switch (resp.errCode) {
//            case WXSuccess:
//                strMsg = @"支付结果：成功！";
//                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
//                break;
//
//            default:
//                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
//                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
//                break;
                [self wxPay:resp];
//        }
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
    }else {
        
    }
}

- (void)onReq:(BaseReq *)req {

}

- (void)getAccess_Token:(NSString *)code {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"appid"] = @"wx057396c823ea22ae";
    params[@"secret"] = @"5c95b87b63bb5e35fb88049c22d22372";
    params[@"code"] = code;
    params[@"grant_type"] = @"authorization_code";

    @weakify(self);
    [[self.loginRegisterVM.getWXAcessTokenCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            NSDictionary *accessDict = [NSDictionary dictionaryWithDictionary:x];
            NSString *accessToken = [accessDict objectForKey:@"access_token"];
            NSString *openID = [accessDict objectForKey:@"openid"];
            NSString *unionID = [accessDict objectForKey:@"unionid"];
            NSString *refreshToken = [accessDict objectForKey:@"refresh_token"];
            // 本地持久化，以便access_token的使用、刷新或者持续
            if (accessToken && ![accessToken isEqualToString:@""] && openID && ![openID isEqualToString:@""]) {
                [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:WX_ACCESS_TOKEN];
                [[NSUserDefaults standardUserDefaults] setObject:openID forKey:WX_OPEN_ID];
                [[NSUserDefaults standardUserDefaults] setObject:unionID forKey:WX_UNION_ID];
                [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:WX_REFRESH_TOKEN];
                [[NSUserDefaults standardUserDefaults] synchronize]; // 命令直接同步到文件里，来避免数据的丢失
            }
            [self wechatLoginByRequestForUserInfo];
        } else {
//            NSLog(@"获取access_token时出错 = %@", error);
        }
    }];
}

/***
 response = {
 city = Shenzhen;
 country = CN;
 headimgurl = "http://thirdwx.qlogo.cn/mmopen/vi_32/Qv6gQX7QRlY0piceb3dIWQ5DFIc8ScCW81wNHmibM6qttPMXzcqlx1P9wk0UxRtZfiaO9Dic663qGvCdkN6jC466Xw/132";
 language = "zh_CN";
 nickname = "\U53ea\U4e0d\U8fc7\U662f\U5219\U5bd3\U8a00";
 openid = "o2PX90090m46o6HiFhRv6PF-3bVo";
 privilege =     (
 );
 province = Guangdong;
 sex = 2;
 unionid = "o0PX60TfituVkhOJJ-7X6ZaUYOxY";
 }
 ***/

// 获取用户个人信息（UnionID机制）
- (void)wechatLoginByRequestForUserInfo {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    NSMutableDictionary *wxParams = [[NSMutableDictionary alloc] init];
    wxParams[@"access_token"] = accessToken;
    wxParams[@"openid"] = openID;
    [[self.loginRegisterVM.getWXUserInfoCommand execute:wxParams] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            [[NSUserDefaults standardUserDefaults] setObject:x[@"headimgurl"] forKey:WX_HEADIMGURL];
            [[NSUserDefaults standardUserDefaults] setObject:x[@"openid"] forKey:WX_OPEN_ID];
            [[NSUserDefaults standardUserDefaults] setObject:x[@"unionid"] forKey:WX_UNION_ID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self loginAction];
        }
    }];
}

- (void)loginAction {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"loginType"] = [NSNumber numberWithInteger:4];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    params[@"openid"] = openID;
    NSString *unionID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_UNION_ID];
    params[@"unionid"] = unionID;
    params[@"image"] = [[NSUserDefaults standardUserDefaults] objectForKey:WX_HEADIMGURL];
    [[self.loginRegisterVM.loginCommand execute:params] subscribeNext:^(id  _Nullable x) {
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

#pragma mark -- 微信支付处理
- (void)wxPay:(BaseResp *)resp {
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    if ([vc isKindOfClass:[BaseNavigationViewController class]]) {
        vc = [(BaseNavigationViewController *)vc visibleViewController];
    } else if ([vc isKindOfClass:[MainTabBarViewController class]]) {
        vc = [(MainTabBarViewController *)vc selectedViewController];
    }
    BaseNavigationViewController *navC = (BaseNavigationViewController *)vc;
    switch (resp.errCode) {
        case WXSuccess:
        {
            FCPaySuccesViewController *paySuccessVC = [[FCPaySuccesViewController alloc] init];
            paySuccessVC.model = self.model;
//            paySuccessVC.cardModel = self.cardModel;
            [navC pushViewController:paySuccessVC animated:YES];
        }
            break;
            
        default:
        {
            FCPayFailViewController *payFailVC = [[FCPayFailViewController alloc] init];
            [navC pushViewController:payFailVC animated:YES];
        }
            break;
    }
    
}

- (NSInteger)seq {
    return ++ seq;
}


@end
