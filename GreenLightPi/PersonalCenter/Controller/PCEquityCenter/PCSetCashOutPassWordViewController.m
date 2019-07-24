//
//  PCSetCashOutPassWordViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/12.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCSetCashOutPassWordViewController.h"
#import "PCSetCashOutPassWordView.h"
#import "PersonalCenterViewModel.h"
#import "PCMyBankCardViewController.h"
#import "PCEquityCenterViewController.h"
#import "PCCashOutViewController.h"

@interface PCSetCashOutPassWordViewController ()
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *surePassWord;
@property (nonatomic, strong) PCSetCashOutPassWordView *setCashOutPassWordView;
@property (nonatomic, strong) PersonalCenterViewModel *peraonalCenterVM;
@end

@implementation PCSetCashOutPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0
                      leftBlock:^{
                          @strongify(self);
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
    [self aty_setCenterNavItemtitle:@"设置提现密码" titleColor:0x333333];
    [self creatSetCashOutPassWordView];
}

- (void)creatSetCashOutPassWordView {
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.backView];
    [self.backView addSubview:self.setCashOutPassWordView];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(KNavgationBarHeight + 120));
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.height.equalTo(@15);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.height.equalTo(@60);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(30);
    }];
    
    [self.setCashOutPassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backView);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
    @weakify(self);
    self.setCashOutPassWordView.inputFinishBlock = ^(NSString * _Nonnull code, BOOL isSure) {
        @strongify(self);
        if (isSure) {
            self.surePassWord = code;
            if ([self.surePassWord isEqualToString:self.passWord]) {
                //密码校验通过，
                
                switch (self.passWordType) {
                    case 0:
                    {
                        [self addBankCard];
                    }
                        break;
                    case 1:
                    {
                        [self resetPassWord];
                    }
                        break;
                    case 2:
                    {
                        [self addBankCard];
                    }
                        break;
                    case 3:
                    {
                        [self addBankCard];
                    }
                        break;
                    default:
                        break;
                }
            } else {
                self.setCashOutPassWordView.textField.text = nil;
                for (UILabel *label in self.setCashOutPassWordView.labels) {
                    label.text = nil;
                }
                [ATYToast aty_bottomMessageToast:@"密码不一致，请重新设置"];
                self.tipLabel.text = @"请设置提现密码";
                self.setCashOutPassWordView.isSure = NO;
            }
        } else {
            self.passWord = code;
            self.setCashOutPassWordView.textField.text = nil;
            for (UILabel *label in self.setCashOutPassWordView.labels) {
                label.text = nil;
            }
            self.tipLabel.text = @"请确认提现密码";
        }
    };
}

- (void)addBankCard {
    self.params[@"Password"] = self.passWord;
    @weakify(self);
    [[self.peraonalCenterVM.CreateBankCard execute:self.params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            if ([x[@"Msg"][@"code"] integerValue] == 1000) {
                if (self.passWordType == PassWordTypeSet) {
                    //添加成功，返回我的银行卡列表,并刷新列表
                    for (UIViewController *VC in self.navigationController.viewControllers) {
                        if ([VC isKindOfClass:[PCMyBankCardViewController class]]) {
                            PCMyBankCardViewController *myBankCardVC = (PCMyBankCardViewController *)VC;
                            [KNotificationCenter postNotificationName:ADDBANKSUCCESS_NOTIFICATION object:nil];
                            [self.navigationController popToViewController:myBankCardVC animated:YES];
                        }
                    }
                } else if (self.passWordType == PassWordTypeAddReset) {
                    //返回权益中心
                    [ATYToast aty_bottomMessageToast:@"密码重置成功！"];
                    [KNotificationCenter postNotificationName:ADDBANKSUCCASHOUT_NOTIFICATION object:nil];
                    for (UIViewController *VC in self.navigationController.viewControllers) {
                        if ([VC isKindOfClass:[PCEquityCenterViewController class]]) {
                            PCEquityCenterViewController *equityCenterVC = (PCEquityCenterViewController *)VC;
                            [self.navigationController popToViewController:equityCenterVC animated:YES];
                        }
                    }
                } else if (self.passWordType == PassWordTypeAddSelectCard) {
                    [ATYToast aty_bottomMessageToast:@"添加成功！"];
                    [KNotificationCenter postNotificationName:ADDBANKSUCCASHOUT_NOTIFICATION object:nil];
                    //返回提现页面
                    for (UIViewController *VC in self.navigationController.viewControllers) {
                        if ([VC isKindOfClass:[PCCashOutViewController class]]) {
                            PCCashOutViewController *cashOutVC = (PCCashOutViewController *)VC;
                            [self.navigationController popToViewController:cashOutVC animated:YES];
                        }
                    }
                }
            }
        }
    }];
    
}

- (void)tap
{
    [self.setCashOutPassWordView endEditing:YES];
}

#pragma mark -- 忘记密码
- (void)resetPassWord {
    self.params[@"Password"] = self.passWord;
    @weakify(self);
    [[self.peraonalCenterVM.ForgetDrawMoneyPassword execute:self.params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        //密码重设成功
        if (x != nil) {
            for (UIViewController *VC in self.navigationController.viewControllers) {
                if ([VC isKindOfClass:[PCEquityCenterViewController class]]) {
                    PCEquityCenterViewController *equityCenterVC = (PCEquityCenterViewController *)VC;
                    [self.navigationController popToViewController:equityCenterVC animated:YES];
                }
            }
        }
    }];
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"请设置提现密码";
        _tipLabel.textColor = KHEXRGB(0x999999);
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}

- (PCSetCashOutPassWordView *)setCashOutPassWordView {
    if (!_setCashOutPassWordView) {
        _setCashOutPassWordView = [[PCSetCashOutPassWordView alloc] initWithCount:6 margin:0];
    }
    return _setCashOutPassWordView;
}

- (PersonalCenterViewModel *)peraonalCenterVM {
    if (!_peraonalCenterVM) {
        _peraonalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _peraonalCenterVM;
}

@end
