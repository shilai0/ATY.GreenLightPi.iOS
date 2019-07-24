//
//  PCChangePhoneNoViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCChangePhoneNoViewController.h"
#import "BaseNavigationViewController.h"
#import "RLFirstOpenAppViewController.h"
#import "RLLoginRegisterViewModel.h"
#import "PersonalCenterViewModel.h"
#import "ATYAlertViewController.h"
#import "PCChangeNoView.h"
#import "ATYCache.h"

@interface PCChangePhoneNoViewController ()
@property (nonatomic, strong) PCChangeNoView *changeNoView;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegisterVM;
@end

@implementation PCChangePhoneNoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"更换手机号码" titleColor:0x333333];
    
    if (self.changeType == ChangeTypeNew) {
        [self aty_setRightNavItemImg:@"" title:@"确定" titleColor:0x44C08C rightBlock:^{
            @strongify(self);
            [self changePhoneNoNew];
        }];
    } else {
        [self aty_setRightNavItemImg:@"" title:@"下一步" titleColor:0x44C08C rightBlock:^{
            @strongify(self);
            [self changePhoneNoOld];
        }];
    }
    
    [self pc_creatChangeNoView];
}

- (void)pc_creatChangeNoView {
    [self.view addSubview:self.changeNoView];
    
    [self.changeNoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@(KNavgationBarHeight));
        make.height.equalTo(@(KSCREENH_HEIGHT - KNavgationBarHeight));
    }];
    
    if (self.changeType == ChangeTypeOld) {
        self.changeNoView.telephoneTextfield.text = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_PHONE];
        self.changeNoView.telephoneTextfield.enabled = NO;
    }
    
    @weakify(self);
    self.changeNoView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        if (self.changeType == ChangeTypeNew) {
            params[@"smsType"] = @6;
        } else {
            params[@"smsType"] = @5;
        }
        params[@"phone"] = self.changeNoView.telephoneTextfield.text;
        NSString *phone = params[@"phone"];
        if (![ATYUtils isNumText:phone]) {
            [ATYToast aty_bottomMessageToast:@"请填写正确的手机号码"];
            return;
        }
        @weakify(self);
        [[self.loginRegisterVM.getVerificationCodeCommand execute:params] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if (x != nil) {
                self.code = x[@"Data"];
                [ATYToast aty_bottomMessageToast:@"验证码发送成功"];
            }
        }];
    };
}

- (void)changePhoneNoOld {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_PHONE];
    params[@"code"] = self.changeNoView.codeTextfield.text;
    
    if (![ATYUtils checkCodeNumber:self.changeNoView.codeTextfield.text]) {
        [ATYToast aty_bottomMessageToast:@"请填写正确的验证码"];
        return;
    }
    
    @weakify(self);
    [[self.personalCenterVM.ReplacePhoneOneCode execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            PCChangePhoneNoViewController *changePhoneNoVC = [[PCChangePhoneNoViewController alloc] init];
            changePhoneNoVC.changeType = ChangeTypeNew;
            [self.navigationController pushViewController:changePhoneNoVC animated:YES];
        }
    }];
}

- (void)changePhoneNoNew {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = self.changeNoView.telephoneTextfield.text;
    params[@"code"] = self.changeNoView.codeTextfield.text;
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"oldPhone"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_PHONE];
    
    if (![ATYUtils isNumText:self.changeNoView.telephoneTextfield.text]) {
        [ATYToast aty_bottomMessageToast:@"请填写正确的手机号码"];
        return;
    }
    
    if (![ATYUtils checkCodeNumber:self.changeNoView.codeTextfield.text]) {
        [ATYToast aty_bottomMessageToast:@"请填写正确的验证码"];
        return;
    }
    
    [[self.personalCenterVM.ReplacePhoneNew execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            ATYAlertViewController *alertCtrl = [ATYAlertViewController alertControllerWithTitle:nil message:@"手机号码修改成功，请重新登录！"];
            alertCtrl.messageAlignment = NSTextAlignmentCenter;
            ATYAlertAction *doneAction = [ATYAlertAction actionWithTitle:@"知道了" titleColor:0xF9694E handler:^(ATYAlertAction *action) {
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:PROJECT_TOKEN];
                [userDefaults removeObjectForKey:PROJECT_USER_ID];
                [userDefaults removeObjectForKey:PROJECT_PHONE];
                [userDefaults removeObjectForKey:PROJECT_BOXID];
                [ATYCache removeChache:PROJECT_USER];

                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = [[BaseNavigationViewController alloc] initWithRootViewController:[[RLFirstOpenAppViewController alloc] init]];
            }];
            [alertCtrl addAction:doneAction];
            [self presentViewController:alertCtrl animated:NO completion:nil];
        }
    }];
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

- (RLLoginRegisterViewModel *)loginRegisterVM {
    if (!_loginRegisterVM) {
        _loginRegisterVM = [[RLLoginRegisterViewModel alloc] init];
    }
    return _loginRegisterVM;
}

- (PCChangeNoView *)changeNoView {
    if (!_changeNoView) {
        _changeNoView = [PCChangeNoView new];
        _changeNoView.backgroundColor = KHEXRGB(0xFFFFFF);
    }
    return _changeNoView;
}

@end
