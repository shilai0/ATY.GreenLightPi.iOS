//
//  RLFindPswViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "RLFindPswViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "RLLoginRegisterViewModel.h"
#import "RLFindPswView.h"
#import "RLSingleTextView.h"

@interface RLFindPswViewController ()

@property (nonatomic, strong) RLFindPswView *findPswView;
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegisterVM;
@property (nonatomic, copy) NSString *pswCode;//找回密码所获取的短信验证码

@end

@implementation RLFindPswViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar=NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"找回密码" titleColor:0x333333];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self rl_creatSubViews];
}

#pragma mark -创建并添加子视图
- (void)rl_creatSubViews {
    [self.view addSubview:self.findPswView];
    [self.findPswView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@(KNavgationBarHeight));
        make.bottom.equalTo(@(-KBottomSafeHeight));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.findPswView addGestureRecognizer:tap];
    
    @weakify(self);
    self.findPswView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0://获取找回密码的验证码
            {
                [self getFindPswCode];
            }
                break;
            case 1://完成
            {
                [self finishAction];
            }
                break;
            default:
                break;
        }
    };
    
}

#pragma mark -- 获取找回密码的验证码
- (void)getFindPswCode {
    if (![ATYUtils isNumText:self.findPswView.telephoneTextfield.contentTextfield.text]) {
        [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码"];
        return ;
    }
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = self.findPswView.telephoneTextfield.contentTextfield.text;
    params[@"smsType"] = [NSNumber numberWithInt:3];
    [[self.loginRegisterVM.getVerificationCodeCommand execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            [ATYToast aty_bottomMessageToast:@"验证码发送成功"];
        }
    }];
}

#pragma mark -- 完成
- (void)finishAction {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = self.findPswView.telephoneTextfield.contentTextfield.text;
    params[@"password"] = self.findPswView.pswTextfield.contentTextfield.text;
    params[@"code"] = self.findPswView.codeTextfield.contentTextfield.text;
    if (![self rl_checkParams:params]) {
        return;
    }
    @weakify(self);
    [[self.loginRegisterVM.resetPasswordCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            [self.navigationController popViewControllerAnimated:YES];
            [ATYToast aty_bottomMessageToast:@"密码修改成功，请重新登录"];
        }
    }];
}

#pragma mark -- 收起键盘
- (void)tapClick:(UITapGestureRecognizer *)tap
{
    [self.findPswView endEditing:YES];
}

#pragma mark -- 校验
- (BOOL)rl_checkParams:(NSMutableDictionary *)params {
    NSString *phone = params[@"phone"];
    NSString *password = params[@"password"];
    NSString *code = params[@"code"];
    
    BOOL isTure = YES;
    
    if (![ATYUtils isNumText:phone]) {
        [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码"];
        return !isTure;
    }
    
    if (password.length > 16 || password.length < 6) {
        [ATYToast aty_bottomMessageToast:@"请输入6-16位的密码"];
        return !isTure;
    }
    
    if (code.length == 0 || code.length > 4) {
        [ATYToast aty_bottomMessageToast:@"请输入正确的验证码"];
        return !isTure;
    }
    return isTure;
}

#pragma mark -- 懒加载
- (RLLoginRegisterViewModel *)loginRegisterVM {
    if (_loginRegisterVM == nil) {
        _loginRegisterVM = [[RLLoginRegisterViewModel alloc]init];
    }
    return _loginRegisterVM;
}

- (RLFindPswView *)findPswView {
    if (!_findPswView) {
        _findPswView = [[RLFindPswView alloc] init];
    }
    return _findPswView;
}

- (void)dealloc {
    NSLog(@"RLFindPswViewController找回密码控制器被销毁了");
}

@end
