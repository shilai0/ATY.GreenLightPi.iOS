//
//  RLFirstOpenAppViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/22.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "RLFirstOpenAppViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "BaseNavigationViewController.h"
#import "HMParkUsageViewController.h"
#import <WechatOpenSDK/WXApiObject.h>
#import <WechatOpenSDK/WXApi.h>
#import "MainTabBarViewController.h"
#import "RLLoginRegisterViewModel.h"
#import "RLBindOneViewController.h"
#import "RLFindPswViewController.h"
#import "ATYAlertViewController.h"
#import "RLRegistAgreementView.h"
#import "RLFirstOpenAppView.h"
#import "RLSingleTextView.h"
#import "RLRegistView.h"
#import "RLLoginView.h"
#import "UserModel.h"
#import "ATYCache.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#import <UserNotifications/UserNotifications.h>


@interface RLFirstOpenAppViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) RLFirstOpenAppView *firstOpenView;
@property (nonatomic, strong) RLRegistView *registView;
@property (nonatomic, strong) RLLoginView *loginView;
@property (nonatomic, strong) UIView *shadowBackView;
@property (nonatomic, assign) BOOL keyboardIsVisible;
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegistVM;
@property (nonatomic, assign) NSInteger status;//0当前为登录状态，1当前为注册状态，2当前为注册成功状态
@property (nonatomic, strong) RLRegistAgreementView *registerAgreementView;
@end

@implementation RLFirstOpenAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatFirstOpenAppViews];
}

- (void)creatFirstOpenAppViews {
    [self.view addSubview:self.firstOpenView];
    [self.firstOpenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    @weakify(self);
    self.firstOpenView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0://注册
            {
                [self registAction];
            }
                break;
            case 1://登录
            {
                [self loginAction];
            }
                break;
            case 2://随便看看
            {
                [self lookAroundAction];
            }
                break;
            default:
                break;
        }
    };
}

#pragma mark -- 添加弹框视图
- (void)addAlertViews {
    self.shadowBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT)];
    self.shadowBackView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
    self.shadowBackView.userInteractionEnabled = YES;
    [self.view addSubview:self.shadowBackView];
    self.registView = [[RLRegistView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame), KSCREEN_WIDTH, KSCREENH_HEIGHT - 61)];
    //绘制圆角 要设置的圆角 使用“|”来组合
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.registView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(16, 16)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer.frame = self.registView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.registView.layer.mask = maskLayer;
    [self.shadowBackView addSubview:self.registView];
    self.registView.hidden = YES;
    
    self.loginView = [[RLLoginView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.view.frame), KSCREEN_WIDTH, KSCREENH_HEIGHT - 61)];
    //绘制圆角 要设置的圆角 使用“|”来组合
    UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:self.loginView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(16, 16)];
    CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
    //设置大小
    maskLayer2.frame = self.loginView.bounds;
    //设置图形样子
    maskLayer2.path = maskPath2.CGPath;
    self.loginView.layer.mask = maskLayer2;
    [self.shadowBackView addSubview:self.loginView];
    self.loginView.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShadowViewClick:)];
    tap.delegate = self;
    [self.shadowBackView addGestureRecognizer:tap];
    
    @weakify(self);
    self.registView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0:
            {
                [self hideShadowViewStatus:0];
            }
                break;
            case 1://获取注册验证码
            {
                [self getCodeAction:2 phone:content1];
            }
                break;
            case 2://注册
            {
                [self newUserRegist];
            }
                break;
            case 3://手机号登录
            {
                self.registView.hidden = YES;
                self.loginView.hidden = NO;
                self.status = 1;
            }
                break;
            case 4://用户协议
            {
                self.registerAgreementView = [[RLRegistAgreementView alloc] initWithFrame:CGRectMake(0, 61, KSCREEN_WIDTH, KSCREENH_HEIGHT - 61)];
                //绘制圆角 要设置的圆角 使用“|”来组合
                UIBezierPath *maskPath2 = [UIBezierPath bezierPathWithRoundedRect:self.registerAgreementView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(16, 16)];
                CAShapeLayer *maskLayer2 = [[CAShapeLayer alloc] init];
                //设置大小
                maskLayer2.frame = self.registerAgreementView.bounds;
                //设置图形样子
                maskLayer2.path = maskPath2.CGPath;
                self.registerAgreementView.layer.mask = maskLayer2;
                [self.view addSubview:self.registerAgreementView];
                @weakify(self);
                self.registerAgreementView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
                    @strongify(self);
                    if (index == 0) {
                        [self.registerAgreementView removeFromSuperview];
                        self.registerAgreementView = nil;
                    }
                };
            }
                break;
            default:
                break;
        }
    };
    
    self.loginView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 10://隐藏
            {
                [self hideShadowViewStatus:1];
            }
                break;
            case 11://获取登录验证码
            {
                [self getCodeAction:1 phone:content1];
            }
                break;
            case 12://忘记密码
            {
                RLFindPswViewController *findPswVC = [[RLFindPswViewController alloc] init];
                [self.navigationController pushViewController:findPswVC animated:YES];
            }
                break;
            case 13://验证码登录
            {
                [self userLogin:2];
            }
                break;
            case 14://密码登录
            {
                [self userLogin:1];
            }
                break;
            case 15://新用户注册
            {
                self.registView.hidden = NO;
                self.loginView.hidden = YES;
                self.status = 0;
            }
                break;
            case 16://微信登录
            {
                [self wx_login];
            }
                break;
            default:
                break;
        }
    };
    
}

#pragma mark -- 隐藏
- (void)tapShadowViewClick:(UITapGestureRecognizer *)tap
{
    [self hideShadowViewStatus:self.status];
}

- (void)hideShadowViewStatus:(NSInteger)status {
    
    if (self.registerAgreementView) {
        [self.registerAgreementView removeFromSuperview];
        self.registerAgreementView = nil;
    } else {
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.shadowBackView.alpha = 0;
                         } completion:^(BOOL finished) {
                         }];
        [self.loginView endEditing:YES];
        [self.registView endEditing:YES];
        [self.shadowBackView removeFromSuperview];
        self.shadowBackView = nil;
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    if ([touch.view isDescendantOfView:self.loginView] || [touch.view isDescendantOfView:self.registView]) {
        if (self.keyboardIsVisible) {
            [self.loginView endEditing:YES];
            [self.registView endEditing:YES];
        }
        return NO;
    }
    return YES;
}

#pragma mark -- 加载注册视图
- (void)registAction {
    [self addAlertViews];
    self.registView.hidden = NO;
    [self.registView.telephoneTextfield.contentTextfield becomeFirstResponder];
    self.status = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.shadowBackView.alpha = 1;
                         self.registView.center = CGPointMake(self.view.center.x, self.view.center.y + 30);
                         self.loginView.center = CGPointMake(self.view.center.x, self.view.center.y + 30);
                     }];
}

#pragma mark -- 加载登录视图
- (void)loginAction {
    [self addAlertViews];
    self.loginView.hidden = NO;
    [self.loginView.telephoneTextfield.contentTextfield becomeFirstResponder];
    self.status = 1;
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.shadowBackView.alpha = 1;
                         self.loginView.center = CGPointMake(self.view.center.x, self.view.center.y + 30);
                         self.registView.center = CGPointMake(self.view.center.x, self.view.center.y + 30);
                     }];
}

#pragma mark -- 随便看看
- (void)lookAroundAction {
    MainTabBarViewController *mainTabBarVC = [[MainTabBarViewController alloc] init];
    mainTabBarVC.isFirstRegister = NO;
    // 添加动画效果
    mainTabBarVC.view.layer.transform = CATransform3DMakeScale(1.3, 1.3, 0);
    [UIView animateWithDuration:0.35 animations:^{
        mainTabBarVC.view.layer.transform = CATransform3DIdentity;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        window.rootViewController = mainTabBarVC;
    }];
}

#pragma mark -- 键盘
- (void)keyboardDidShow
{
    self.keyboardIsVisible = YES;
}

- (void)keyboardDidHide
{
    self.keyboardIsVisible = NO;
}

#pragma mark -- 获取验证码
- (void)getCodeAction:(NSInteger)codeIndex phone:(NSString *)telephone {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"smsType"] = [NSNumber numberWithInteger:codeIndex];
    params[@"phone"] = telephone;
    [[self.loginRegistVM.getVerificationCodeCommand execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            [ATYToast aty_bottomMessageToast:@"验证码发送成功"];
        }
    }];
}

#pragma mark -- 注册
- (void)newUserRegist {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = self.registView.telephoneTextfield.contentTextfield.text;
    params[@"password"] = self.registView.pswTextfield.contentTextfield.text;
    params[@"code"] = self.registView.codeTextfield.contentTextfield.text;
    if (![self checkRegistParams:params]) {
        return ;
    }
    [[self.loginRegistVM.registerCommand execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            UserModel *userModel = [UserModel mj_objectWithKeyValues:x[@"Data"]];
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults setObject:userModel.phone forKey:PROJECT_PHONE];
            [userDefaults setObject:userModel.token forKey:PROJECT_TOKEN];
            [userDefaults setObject:userModel.user_id forKey:PROJECT_USER_ID];
            [ATYCache saveDataCache:userModel forKey:PROJECT_USER];
            [userDefaults synchronize];

            MainTabBarViewController *mainTabBarVC = [[MainTabBarViewController alloc] init];
            mainTabBarVC.isFirstRegister = YES;
            // 添加动画效果
            mainTabBarVC.view.layer.transform = CATransform3DMakeScale(1.3, 1.3, 0);
            [UIView animateWithDuration:0.35 animations:^{
                mainTabBarVC.view.layer.transform = CATransform3DIdentity;
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = mainTabBarVC;
            }];
        }
    }];
}

#pragma mark -- 微信
- (void)wx_login{
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    // 如果已经请求过微信授权登录，那么考虑用已经得到的access_token
    if (accessToken && openID) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        NSString *refreshToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_REFRESH_TOKEN];
        params[@"refresh_token"] = refreshToken;
        params[@"appid"] = @"wx057396c823ea22ae";
        params[@"grant_type"] = @"refresh_token";
        @weakify(self);
        [[self.loginRegistVM.getWXRefreshTokenCommand execute:params] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if (x != nil) {
                NSDictionary *refreshDict = [NSDictionary dictionaryWithDictionary:x];
                NSString *reAccessToken = [refreshDict objectForKey:@"refresh_token"];
                // 如果reAccessToken为空,说明reAccessToken也过期了,反之则没有过期
                if (reAccessToken) {
                    // 更新access_token、refresh_token、open_id
                    [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:@"access_token"] forKey:WX_ACCESS_TOKEN];
                    [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:@"openid"] forKey:WX_OPEN_ID];
                    [[NSUserDefaults standardUserDefaults] setObject:[refreshDict objectForKey:@"unionid"] forKey:WX_UNION_ID];
                    [[NSUserDefaults standardUserDefaults] setObject:reAccessToken forKey:WX_REFRESH_TOKEN];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    // 当存在reAccessToken不为空时直接执行登录方法
                    [self getWXUserInfo];
                } else {
                    [self sendAuthRequest];
                }
            } else {
                //                    NSLog(@"用refresh_token来更新accessToken时出错 = %@", error);
            }
        }];
    } else {
        [self sendAuthRequest];
    }
}

// 获取用户个人信息（UnionID机制）
- (void)getWXUserInfo {
    NSString *accessToken = [[NSUserDefaults standardUserDefaults] objectForKey:WX_ACCESS_TOKEN];
    NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
    NSMutableDictionary *wxParams = [[NSMutableDictionary alloc] init];
    wxParams[@"access_token"] = accessToken;
    wxParams[@"openid"] = openID;
    @weakify(self);
    [[self.loginRegistVM.getWXUserInfoCommand execute:wxParams] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            @strongify(self);
            [[NSUserDefaults standardUserDefaults] setObject:x[@"headimgurl"] forKey:WX_HEADIMGURL];
            [[NSUserDefaults standardUserDefaults] setObject:x[@"openid"] forKey:WX_OPEN_ID];
            [[NSUserDefaults standardUserDefaults] setObject:x[@"unionid"] forKey:WX_UNION_ID];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [self userLogin:4];
        }
    }];
}

-(void)sendAuthRequest
{
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc] init];
    req.openID = @"wx057396c823ea22ae";
    req.scope = @"snsapi_userinfo";
    req.state = @"aty_greenLightPai";
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

#pragma mark -- 登录
- (void)userLogin:(NSInteger)loginIndex {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = self.loginView.telephoneTextfield.contentTextfield.text;
    params[@"loginType"] = [NSNumber numberWithInteger:loginIndex];
    if (loginIndex == 1) {
        params[@"password"] = self.loginView.psdTextfield.contentTextfield.text;
    } else if (loginIndex == 2) {
        params[@"code"] = self.loginView.codeTextfield.contentTextfield.text;
    } else if (loginIndex == 4) {
        NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
        params[@"openid"] = openID;
        NSString *unionID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_UNION_ID];
        params[@"unionid"] = unionID;
        params[@"image"] = [[NSUserDefaults standardUserDefaults] objectForKey:WX_HEADIMGURL];
    }
    if (![self checkLoginParams:params]) {
        return;
    }
    [[self.loginRegistVM.loginCommand execute:params] subscribeNext:^(id  _Nullable x) {
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
            
            if (self.isJPush) {//直接跳转到盒子详情
                HMParkUsageViewController *vc = [HMParkUsageViewController new];
                vc.pushType = JPush;
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                MainTabBarViewController *mainTabBarVC = [[MainTabBarViewController alloc] init];
                mainTabBarVC.isFirstRegister = NO;
                // 添加动画效果
                mainTabBarVC.view.layer.transform = CATransform3DMakeScale(1.3, 1.3, 0);
                [UIView animateWithDuration:0.35 animations:^{
                    mainTabBarVC.view.layer.transform = CATransform3DIdentity;
                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
                    window.rootViewController = mainTabBarVC;
                }];
            }
            
        } else if (x != nil && [code isEqual:@1002]) {
            
        } else if (x != nil && [code isEqual:@1001]) {//未绑定
//            RLBindOneViewController *bindOneVC = [[RLBindOneViewController alloc] init];
//            UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
//            BaseNavigationViewController *vc = (BaseNavigationViewController *)keyWindow.rootViewController;
//            [vc pushViewController:bindOneVC animated:YES];
            [self.shadowBackView removeFromSuperview];
            self.shadowBackView = nil;
            RLBindOneViewController *bindOneVC = [[RLBindOneViewController alloc] init];
            [self.navigationController pushViewController:bindOneVC animated:YES];
        }
    }];
}

#pragma mark -- 字段校验
- (BOOL)checkRegistParams:(NSMutableDictionary *)params {
    BOOL isTure = YES;
    if (![ATYUtils isNumText:params[@"phone"]]) {
        [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码"];
        return !isTure;
    }
    
    NSString *password = params[@"password"];
    if (StrEmpty(password) || password.length > 16 || password.length < 6) {
        [ATYToast aty_bottomMessageToast:@"密码格式不正确"];
        return !isTure;
    }
    
    NSString *code = params[@"code"];
    if (StrEmpty(code) || code.length > 4) {
        [ATYToast aty_bottomMessageToast:@"请输入正确的验证码！"];
        return !isTure;
    }
    
    return isTure;
}

- (BOOL)checkLoginParams:(NSMutableDictionary *)params {
    BOOL isTure = YES;
    
    NSInteger type = [params[@"loginType"] integerValue];
    
    if ((type == 1 || type == 2) && ![ATYUtils isNumText:params[@"phone"]]) {
        [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码"];
        return !isTure;
    }
    
    NSString *password = params[@"password"];
    if (type == 1 && (StrEmpty(password) || password.length > 16 || password.length < 6)) {
        [ATYToast aty_bottomMessageToast:@"密码格式不正确"];
        return !isTure;
    }
    
    NSString *code = params[@"code"];
    if (type == 2 && (StrEmpty(code) || code.length > 4)) {
        [ATYToast aty_bottomMessageToast:@"请输入正确的验证码"];
        return !isTure;
    }
    
    return isTure;
}

#pragma mark -- 懒加载
- (RLFirstOpenAppView *)firstOpenView {
    if (!_firstOpenView) {
        _firstOpenView = [[RLFirstOpenAppView alloc] init];
        _firstOpenView.backgroundColor = KHEXRGB(0xFFFFFF);
    }
    return _firstOpenView;
}

- (RLLoginRegisterViewModel *)loginRegistVM {
    if (!_loginRegistVM) {
        _loginRegistVM = [[RLLoginRegisterViewModel alloc] init];
    }
    return _loginRegistVM;
}


- (void)dealloc {
    [KNotificationCenter removeObserver:self];
    NSLog(@"RLFirstOpenAppViewController首次打开App控制器被销毁了");
}

@end
