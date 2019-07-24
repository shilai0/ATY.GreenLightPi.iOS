//
//  PCSendCodeViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/12.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCSendCodeViewController.h"
#import "HWTFCodeBView.h"
#import "UIButton+Common.h"
#import "PCSetCashOutPassWordViewController.h"
#import "ATYCache.h"
#import "RLLoginRegisterViewModel.h"
#import "PersonalCenterViewModel.h"
#import "PCMyBankCardViewController.h"
#import "PCCashOutViewController.h"

@interface PCSendCodeViewController ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *resendBtn;
@property (nonatomic, strong) UIButton *finishBtn;
@property (nonatomic, strong) HWTFCodeBView *codeInputView;
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegisterVM;
@property (nonatomic, strong) PersonalCenterViewModel *peraonalCenterVM;
@end

@implementation PCSendCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0
                      leftBlock:^{
                          @strongify(self);
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
    
    [self aty_setCenterNavItemtitle:@"验证银行卡信息" titleColor:0x333333];
    
    [self creatCodeViews];
}

- (void)creatCodeViews {
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.tipLabel];
    [self.backView addSubview:self.resendBtn];
    [self.backView addSubview:self.codeInputView];
    [self.view addSubview:self.finishBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-19));
        make.top.equalTo(@(KNavgationBarHeight + 4));
        make.height.equalTo(@169);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@14);
        make.height.equalTo(@14);
        make.right.equalTo(@(-14));
    }];
    
    [self.resendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(11);
        make.height.equalTo(@12);
        make.width.equalTo(@120);
    }];
    
    [self.codeInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@((KSCREEN_WIDTH - 38*4 - 34)/5));
        make.right.equalTo(@(-(KSCREEN_WIDTH - 38*4 - 34)/5));
        make.top.equalTo(self.resendBtn.mas_bottom).offset(17);
        make.height.equalTo(@38);
    }];
    
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.right.equalTo(@(-60));
        make.top.equalTo(self.backView.mas_bottom).offset(36);
        make.height.equalTo(@50);
    }];
    

    self.tipLabel.text = [NSString stringWithFormat:@"验证码已下发至%@",self.phoneStr];
    
    @weakify(self);
    [[self.resendBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //重新获取验证码
        [self.resendBtn xs_startWithTime:60 title:@"重新获取" countDownTitle:@"s" mainColor:KHEXRGB(0xF9694E) countColor:KHEXRGB(0x44C08C)];
        [self sendMessage];
    }];
    
    NSMutableArray *bankCardArr = [ATYCache readCache:BANKCARDARR];

    [[self.finishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //先校验验证码是否正确
        if (self.codeInputView.code.length != 4) {
            [ATYToast aty_bottomMessageToast:@"验证码不正确"];
            return ;
        }

        switch (self.sendMessageType) {
            case 0:
            {
                if (bankCardArr.count > 0) {
                    //直接调添加接口
                    [self addBankCardAction];
                } else {//首次添加银行卡，跳转到设置提现密码界面
                    PCSetCashOutPassWordViewController *setCashOutPassWordVC = [[PCSetCashOutPassWordViewController alloc] init];
                    setCashOutPassWordVC.codeStr = self.codeInputView.code;
                    self.params[@"Code"] = self.codeInputView.code;;
                    setCashOutPassWordVC.params = self.params;
                    [self.navigationController pushViewController:setCashOutPassWordVC animated:YES];
                }
            }
                break;
            case 1:
            {//忘记密码重新绑定
                PCSetCashOutPassWordViewController *setCashOutPassWordVC = [[PCSetCashOutPassWordViewController alloc] init];
                setCashOutPassWordVC.codeStr = self.codeInputView.code;
                self.params[@"Code"] = self.codeInputView.code;;
                setCashOutPassWordVC.params = self.params;
                setCashOutPassWordVC.passWordType = PassWordTypeReset;
                [self.navigationController pushViewController:setCashOutPassWordVC animated:YES];
            }
                break;
            case 2:
            {//忘记密码添加新卡
                PCSetCashOutPassWordViewController *setCashOutPassWordVC = [[PCSetCashOutPassWordViewController alloc] init];
                setCashOutPassWordVC.codeStr = self.codeInputView.code;
                self.params[@"Code"] = self.codeInputView.code;
                setCashOutPassWordVC.params = self.params;
                setCashOutPassWordVC.passWordType = PassWordTypeAddReset;
                [self.navigationController pushViewController:setCashOutPassWordVC animated:YES];
            }
                break;
            case 3:
            {//提现选择银行卡添加新卡
                if (bankCardArr.count > 0) {
                    //直接调添加接口
                    [self addBankCardAction];
                } else {//首次添加银行卡，跳转到设置提现密码界面
                    PCSetCashOutPassWordViewController *setCashOutPassWordVC = [[PCSetCashOutPassWordViewController alloc] init];
                    setCashOutPassWordVC.codeStr = self.codeInputView.code;
                    self.params[@"Code"] = self.codeInputView.code;;
                    setCashOutPassWordVC.params = self.params;
                    setCashOutPassWordVC.passWordType = PassWordTypeAddSelectCard;
                    [self.navigationController pushViewController:setCashOutPassWordVC animated:YES];
                }
            }
                break;
            default:
                break;
        }
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
    switch (self.sendMessageType) {
        case 0:
            if (bankCardArr.count > 0) {
                [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
            } else {
                [_finishBtn setTitle:@"下一步" forState:UIControlStateNormal];
            }
            break;
        case 1:
        case 2:
            [_finishBtn setTitle:@"下一步" forState:UIControlStateNormal];
            break;
        case 3:
            if (bankCardArr.count > 0) {
                [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
            } else {
                [_finishBtn setTitle:@"下一步" forState:UIControlStateNormal];
            }
            break;
        default:
            break;
    }
    
}

#pragma mark -- 添加银行卡
- (void)addBankCardAction {
    self.params[@"Code"] = self.codeInputView.code;;
    @weakify(self);
    [[self.peraonalCenterVM.CreateBankCard execute:self.params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            if ([x[@"Msg"][@"code"] integerValue] == 1000) {
                if (self.sendMessageType == SendMessageTypeAddResetPasssWord) {
                    //添加成功，返回到提现页面,并刷新列表
                    for (UIViewController *VC in self.navigationController.viewControllers) {
                        if ([VC isKindOfClass:[PCCashOutViewController class]]) {
                            PCCashOutViewController *cashOutVC = (PCCashOutViewController *)VC;
                            [KNotificationCenter postNotificationName:ADDBANKSUCCASHOUT_NOTIFICATION object:nil];
                            [self.navigationController popToViewController:cashOutVC animated:YES];
                        }
                    }
                } else {
                    //添加成功，返回我的银行卡列表,并刷新列表
                    for (UIViewController *VC in self.navigationController.viewControllers) {
                        if ([VC isKindOfClass:[PCMyBankCardViewController class]]) {
                            PCMyBankCardViewController *myBankCardVC = (PCMyBankCardViewController *)VC;
                            [KNotificationCenter postNotificationName:ADDBANKSUCCESS_NOTIFICATION object:nil];
                            [self.navigationController popToViewController:myBankCardVC animated:YES];
                        }
                    }
                }
            }
        }
    }];
}

- (void)sendMessage {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = self.phoneStr;
    params[@"smsType"] = [NSNumber numberWithInteger:11];
    [[self.loginRegisterVM.getVerificationCodeCommand execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            [ATYToast aty_bottomMessageToast:@"验证码发送成功"];
        }
    }];
}

- (void)tap
{
    [self.codeInputView endEditing:YES];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = KHEXRGB(0x000000);
        _tipLabel.font = [UIFont systemFontOfSize:15];
    }
    return _tipLabel;
}

- (UIButton *)resendBtn {
    if (!_resendBtn) {
        _resendBtn = [[UIButton alloc] init];
//        [_resendBtn setTitle:@"60s后重新获取" forState:UIControlStateNormal];
        [_resendBtn setTitleColor:KHEXRGB(0x000000) forState:UIControlStateNormal];
        _resendBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        _resendBtn.alpha = 0.6;
        [_resendBtn xs_startWithTime:60 title:@"重新获取" countDownTitle:@"s" mainColor:KHEXRGB(0xF9694E) countColor:KHEXRGB(0x44C08C)];

    }
    return _resendBtn;
}

- (HWTFCodeBView *)codeInputView {
    if (!_codeInputView) {
        _codeInputView = [[HWTFCodeBView alloc] initWithCount:4 margin:(KSCREEN_WIDTH - 38*4 - 34)/5];
    }
    return _codeInputView;
}

- (UIButton *)finishBtn {
    if (!_finishBtn) {
        _finishBtn = [[UIButton alloc] init];
        [_finishBtn setBackgroundImage:[UIImage imageNamed:@"finished"] forState:UIControlStateNormal];
        [_finishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
    }
    return _finishBtn;
}

- (RLLoginRegisterViewModel *)loginRegisterVM {
    if (!_loginRegisterVM) {
        _loginRegisterVM = [[RLLoginRegisterViewModel alloc] init];
    }
    return _loginRegisterVM;
}

- (PersonalCenterViewModel *)peraonalCenterVM {
    if (!_peraonalCenterVM) {
        _peraonalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _peraonalCenterVM;
}

@end
