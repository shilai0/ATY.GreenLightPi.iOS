//
//  RLBindTwoViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/15.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "RLBindTwoViewController.h"
#import "RLLoginRegisterViewModel.h"
#import "MainTabBarViewController.h"
#import "UserModel.h"
#import "ATYCache.h"
#import "UIButton+Common.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#import <UserNotifications/UserNotifications.h>

static NSInteger seq = 0;

@interface RLBindTwoViewController ()
@property (nonatomic, strong) UILabel *telephoneLabel;
@property (nonatomic, strong) UITextField *codeTextfield;
@property (nonatomic, strong) UIButton *getCodebtn;
@property (nonatomic, strong) UIButton *bindButton;
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegisterVM;
@end

@implementation RLBindTwoViewController

- (RLLoginRegisterViewModel *)loginRegisterVM {
    if (!_loginRegisterVM) {
        _loginRegisterVM = [[RLLoginRegisterViewModel alloc] init];
    }
    return _loginRegisterVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self rl_creatBindSubViews];
}

- (void)rl_creatBindSubViews {
    self.telephoneLabel = [UILabel new];
    self.telephoneLabel.text = self.telephone;
    self.telephoneLabel.textColor = KHEXRGB(0x333333);
    self.telephoneLabel.font = [UIFont boldSystemFontOfSize:27];
    self.telephoneLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.telephoneLabel];
    
    UILabel *tipLabel = [UILabel new];
    tipLabel.text = @"已发送短信验证码到此号码";
    tipLabel.textColor = KHEXRGB(0x333333);
    tipLabel.font = [UIFont boldSystemFontOfSize:16];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    
    //验证码textfield
    self.codeTextfield = [UITextField new];
    self.codeTextfield.font = [UIFont systemFontOfSize:16];
    self.codeTextfield.borderStyle = UITextBorderStyleNone;
    self.codeTextfield.keyboardType = UIKeyboardTypeNumberPad;
    self.codeTextfield.placeholder = @"输入验证码";
    [self.view addSubview:self.codeTextfield];
    self.getCodebtn = [[UIButton alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 70, 0, 120, 80)];
//    [self.getCodebtn setTitle:@"重新获取" forState:UIControlStateNormal];
    [self.getCodebtn xs_startWithTime:60 title:@"重新获取" countDownTitle:@"s" mainColor:KHEXRGB(0xF9694E) countColor:KHEXRGB(0x44C08C)];
    [self.getCodebtn setTitleColor:KHEXRGB(0x44C08C) forState:UIControlStateNormal];
    self.getCodebtn.titleLabel.font = [UIFont systemFontOfSize:12];
    self.codeTextfield.rightView = self.getCodebtn;
    self.codeTextfield.rightViewMode = UITextFieldViewModeAlways;
    
    UIView *lineV = [UIView new];
    lineV.backgroundColor = KHEXRGB(0x44C08C);
    [self.view addSubview:lineV];
    
    self.bindButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bindButton setTitle:NSLocalizedString(@"绑  定", nil) forState:UIControlStateNormal];
    [self.bindButton setBackgroundColor:KHEXRGB(0x44C08C)];
    XSViewBorderRadius(self.bindButton, (51 * KHEIGHTRATE(0.96))/2.0, 0, KHEXRGB(0xF9694E));
    self.bindButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:self.bindButton];
    
    [self.telephoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@(KNavgationBarHeight + 30));
        make.height.equalTo(@20);
    }];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.telephoneLabel.mas_bottom).offset(10);
        make.height.equalTo(@20);
    }];
    
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(10);
        make.left.equalTo(@20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@60);
    }];
    
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextfield.mas_bottom).offset(2);
        make.left.equalTo(@20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@1);
    }];
    
    [self.bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineV.mas_bottom).offset(51 * KHEIGHTRATE(0.96));
        make.left.equalTo(@32);
        make.right.equalTo(@(-32));
        make.height.equalTo(@(51 * KHEIGHTRATE(0.96)));
    }];
    
    @weakify(self);
    [[self.getCodebtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.getCodebtn xs_startWithTime:60 title:@"重新获取" countDownTitle:@"s" mainColor:KHEXRGB(0xF9694E) countColor:KHEXRGB(0x44C08C)];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"smsType"] = [NSNumber numberWithInt:4];
        params[@"phone"] = self.telephone;
        [[self.loginRegisterVM.getVerificationCodeCommand execute:params] subscribeNext:^(id  _Nullable x) {
            if (x != nil) {
                [ATYToast aty_bottomMessageToast:@"验证码发送成功"];
            }
        }];
    }];
    
    [[self.bindButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.codeTextfield resignFirstResponder];
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        NSString *openID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_OPEN_ID];
        NSString *unionID = [[NSUserDefaults standardUserDefaults] objectForKey:WX_UNION_ID];
        NSString *headImgUrl = [[NSUserDefaults standardUserDefaults] objectForKey:WX_HEADIMGURL];
        params[@"loginType"] = @4;
        params[@"phone"] = self.telephone;
        params[@"code"] = self.codeTextfield.text;
        params[@"openid"] = openID;
        params[@"unionid"] = unionID;
        params[@"image"] = headImgUrl;
        [[self.loginRegisterVM.BindUserCommand execute:params] subscribeNext:^(id  _Nullable x) {
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
            } else if (x != nil && [code isEqual:@1002]) {
//                NSString *userId = x[@"Data"][@"data"];
//                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//                [userDefaults setObject:userId forKey:PROJECT_USER_ID];
//                SelectIdentityViewController *selectIdentityVC = [[SelectIdentityViewController alloc] init];
//                [self.navigationController pushViewController:selectIdentityVC animated:YES];
            }
        }];
    }];
    
}

- (NSInteger)seq {
    return ++ seq;
}


@end
