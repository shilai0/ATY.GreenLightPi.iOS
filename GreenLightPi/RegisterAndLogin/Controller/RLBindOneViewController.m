//
//  RLBindOneViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/15.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "RLBindOneViewController.h"
#import "RLBindTwoViewController.h"
#import "RLLoginRegisterViewModel.h"

@interface RLBindOneViewController ()
@property (nonatomic,strong) UITextField *telephoneTextfield;
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegisterVM;
@end

@implementation RLBindOneViewController

- (RLLoginRegisterViewModel *)loginRegisterVM {
    if (!_loginRegisterVM) {
        _loginRegisterVM = [[RLLoginRegisterViewModel alloc] init];
    }
    return _loginRegisterVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
        
    [self rl_creatBindingSubViews];
}

- (void)rl_creatBindingSubViews {
    UILabel *tipLabel = [UILabel new];
    tipLabel.text = @"输入手机号";
    tipLabel.textColor = KHEXRGB(0x333333);
    tipLabel.font = [UIFont boldSystemFontOfSize:27];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:tipLabel];
    
    self.telephoneTextfield = [UITextField new];
    self.telephoneTextfield.font = [UIFont systemFontOfSize:14];
    self.telephoneTextfield.backgroundColor = [UIColor clearColor];
    self.telephoneTextfield.borderStyle = UITextBorderStyleNone;
    self.telephoneTextfield.keyboardType = UIKeyboardTypeNumberPad;
    self.telephoneTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.telephoneTextfield.placeholder = NSLocalizedString(@"手机号", nil);
    [self.view addSubview:self.telephoneTextfield];
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 50, 80)];
    leftLabel.text = @"+86 |";
    leftLabel.textColor = KHEXRGB(0x666666);
    leftLabel.font = [UIFont systemFontOfSize:16];
    self.telephoneTextfield.leftView = leftLabel;
    self.telephoneTextfield.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *lineV = [UIView new];
    lineV.backgroundColor = KHEXRGB(0x44C08C);
    [self.view addSubview:lineV];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setTitle:NSLocalizedString(@"下一步", nil) forState:UIControlStateNormal];
    nextBtn.backgroundColor = KHEXRGB(0x44C08C);
    XSViewBorderRadius(nextBtn, (51 * KHEIGHTRATE(0.96))/2.0, 0, KHEXRGB(0xF9694E));
    nextBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:nextBtn];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@(KNavgationBarHeight + 30));
        make.height.equalTo(@30);
    }];
    
    [self.telephoneTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(tipLabel.mas_bottom).offset(50);
        make.left.equalTo(@20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@60);
    }];
    
    [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.telephoneTextfield.mas_bottom).offset(2);
        make.left.equalTo(@20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.equalTo(@1);
    }];
    
    [nextBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
        make.top.equalTo(lineV.mas_bottom).offset(60);
        make.height.equalTo(@50);
    }];
    
        @weakify(self);
        [[nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self.telephoneTextfield resignFirstResponder];
            if (![ATYUtils isNumText:self.telephoneTextfield.text]) {
                [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码"];
                return ;
            }
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"smsType"] = [NSNumber numberWithInt:4];
            params[@"phone"] = self.telephoneTextfield.text;
            @weakify(self);
            [[self.loginRegisterVM.getVerificationCodeCommand execute:params] subscribeNext:^(id  _Nullable x) {
                @strongify(self);
//                if (x != nil) {
//                    RLBindTwoViewController *bindTwoVC = [[RLBindTwoViewController alloc] init];
//                    bindTwoVC.telephone = self.telephoneTextfield.text;
//                    [self.navigationController pushViewController:bindTwoVC animated:YES];
//                }
                
                NSString *message = x[@"Msg"][@"message"];
                NSNumber *success = x[@"Success"];
                if (message.length > 0) {
                    [ATYToast aty_bottomMessageToast:message];
                }
                if ([success boolValue]) {
                    RLBindTwoViewController *bindTwoVC = [[RLBindTwoViewController alloc] init];
                    bindTwoVC.telephone = self.telephoneTextfield.text;
                    [self.navigationController pushViewController:bindTwoVC animated:YES];
                }
            }];
        }];
    
    [[self.telephoneTextfield rac_signalForControlEvents:UIControlEventEditingChanged | UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.telephoneTextfield.text.length > 11) {
            self.telephoneTextfield.text = [self.telephoneTextfield.text substringToIndex:11];
        }
    }];
}

@end
