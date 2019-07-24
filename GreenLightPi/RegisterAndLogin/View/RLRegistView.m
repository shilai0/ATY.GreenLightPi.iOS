//
//  RLRegistView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "RLRegistView.h"
#import "RLSingleTextView.h"
#import "UIButton+Common.h"
#import "ATYAlertViewController.h"
#import "UIView+Controller.h"

@interface RLRegistView () <UITextFieldDelegate>
@property(strong,nonatomic)UIButton *cancleBtn;
@property(strong,nonatomic)UILabel *titleLabel;
@property(strong,nonatomic)UIButton *registBtn;
@property(strong,nonatomic)UIButton *telephoneLoginBtn;
@property(strong,nonatomic)UILabel *registAgreementLabel;
@property(strong,nonatomic)UILabel *errorTipLabel;
@end

@implementation RLRegistView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self rl_creatRegistSubViews];
//        [self.telephoneTextfield.contentTextfield becomeFirstResponder];
        if (@available(iOS 12.0, *)) {
            self.codeTextfield.contentTextfield.textContentType = UITextContentTypeOneTimeCode;
        }
    }
    return self;
}

#pragma mark -创建并添加子视图
- (void)rl_creatRegistSubViews {
    [self addSubview:self.cancleBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.telephoneTextfield];
    [self addSubview:self.pswTextfield];
    [self.pswTextfield addSubview:self.errorTipLabel];
    [self addSubview:self.codeTextfield];
    [self addSubview:self.registBtn];
    [self addSubview:self.telephoneLoginBtn];
    [self addSubview:self.registAgreementLabel];
    self.errorTipLabel.alpha = 0;
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@16);
        make.right.equalTo(@(-16));
        make.width.height.equalTo(@20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.top.equalTo(@50);
        make.right.equalTo(@(-28));
        make.height.equalTo(@23);
    }];
    
    [self.telephoneTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(9);
        make.left.right.equalTo(self);
        make.height.equalTo(@60);
    }];
    
    [self.errorTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@(-30));
        make.top.equalTo(self.pswTextfield.mas_top).offset(5);
        make.height.equalTo(@15);
    }];
    
    [self.pswTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.telephoneTextfield.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@60);
    }];
    
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pswTextfield.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@60);
    }];
    
    [self.registBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextfield.mas_bottom).offset(33);
        make.left.equalTo(@28);
        make.right.equalTo(@(-28));
        make.height.equalTo(@48);
    }];
    
    [self.telephoneLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.registBtn.mas_bottom).offset(19);
        make.height.equalTo(@13);
        make.width.equalTo(@80);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.registAgreementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-24-KBottomSafeHeight);
        make.height.equalTo(@12);
        make.width.equalTo(@200);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    @weakify(self);
    // 账号输入框方法
    [[self.telephoneTextfield.contentTextfield rac_signalForControlEvents:UIControlEventEditingChanged | UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.telephoneTextfield.contentTextfield.text.length > 11) {
            self.telephoneTextfield.contentTextfield.text = [self.telephoneTextfield.contentTextfield.text substringToIndex:11];
        }
        if (self.telephoneTextfield.contentTextfield.text.length == 11) {
            self.registBtn.alpha = 1;
            self.registBtn.enabled = YES;
        } else {
            self.registBtn.alpha = 0.5;
            self.registBtn.enabled = NO;
        }
    }];
    
    [[self.pswTextfield.contentTextfield rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self showErrorTipAnimate];
    }];
    
    [[self.codeTextfield.contentTextfield rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self showErrorTipAnimate];
    }];
    
    [[self.cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.codeTextfield.getCodebtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (![ATYUtils isNumText:self.telephoneTextfield.contentTextfield.text]) {
            [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码！"];
            return ;
        }
        [self.codeTextfield.getCodebtn xs_startWithTime:60 title:@"重新获取" countDownTitle:@"s" mainColor:KHEXRGB(0xF9694E) countColor:KHEXRGB(0x44C08C)];
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, self.telephoneTextfield.contentTextfield.text, nil);
        }
    }];
    
    [[self.registBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(2, self.telephoneTextfield.contentTextfield.text, self.codeTextfield.contentTextfield.text);
        }
    }];
    
    [[self.telephoneLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(3, nil, nil);
        }
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.registAgreementLabel addGestureRecognizer:tap];
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    if (self.atyClickActionBlock) {
        self.atyClickActionBlock(4, nil, nil);
    }
}

#pragma mark -UITextField
- (void)showErrorTipAnimate {
    if (![ATYUtils isNumText:self.telephoneTextfield.contentTextfield.text]) {
        [UIView animateWithDuration:1
                         animations:^{
                             self.errorTipLabel.alpha = 1;
                         } completion:^(BOOL finished) {
                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1.0* NSEC_PER_SEC)),dispatch_get_main_queue(),^{
                                 [UIView animateWithDuration:1 animations:^{
                                     self.errorTipLabel.alpha = 0;
                                 }];
                             });
                         }];
    }
}

#pragma mark -- 懒加载
- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [[UIButton alloc] init];
        [_cancleBtn setImage:[UIImage imageNamed:@"rlCancel"] forState:UIControlStateNormal];
    }
    return _cancleBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"新用户注册";
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont boldSystemFontOfSize:24];
    }
    return _titleLabel;
}

- (RLSingleTextView *)telephoneTextfield {
    if (!_telephoneTextfield) {
        _telephoneTextfield = [[RLSingleTextView alloc] init];
        _telephoneTextfield.isShowLeft = YES;
        _telephoneTextfield.contentTextfield.placeholder = @"手机号";
        _telephoneTextfield.contentTextfield.keyboardType = UIKeyboardTypeNumberPad;
        _telephoneTextfield.getCodebtn.hidden = YES;
    }
    return _telephoneTextfield;
}

- (RLSingleTextView *)pswTextfield {
    if (!_pswTextfield) {
        _pswTextfield = [[RLSingleTextView alloc] init];
        _pswTextfield.contentTextfield.placeholder = @"设置密码（6-16位）";
        _pswTextfield.contentTextfield.keyboardType = UIKeyboardTypeASCIICapable;
        _pswTextfield.getCodebtn.hidden = YES;
        _pswTextfield.contentTextfield.secureTextEntry = YES;
    }
    return _pswTextfield;
}

- (RLSingleTextView *)codeTextfield {
    if (!_codeTextfield) {
        _codeTextfield = [[RLSingleTextView alloc] init];
        _codeTextfield.contentTextfield.placeholder = @"请输入验证码";
        _codeTextfield.contentTextfield.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeTextfield;
}

- (UIButton *)registBtn {
    if (!_registBtn) {
        _registBtn = [[UIButton alloc] init];
        [_registBtn setBackgroundColor:KHEXRGB(0x00D399)];
        [_registBtn setTitle:@"注 册" forState:UIControlStateNormal];
        [_registBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _registBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        XSViewBorderRadius(_registBtn, 24, 0, KHEXRGB(0x00D399));
    }
    return _registBtn;
}

- (UIButton *)telephoneLoginBtn {
    if (!_telephoneLoginBtn) {
        _telephoneLoginBtn = [[UIButton alloc] init];
        [_telephoneLoginBtn setTitle:@"手机号登录" forState:UIControlStateNormal];
        [_telephoneLoginBtn setTitleColor:KHEXRGB(0x3696DF) forState:UIControlStateNormal];
        _telephoneLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _telephoneLoginBtn;
}

- (UILabel *)registAgreementLabel {
    if (!_registAgreementLabel) {
        _registAgreementLabel = [[UILabel alloc] init];
        _registAgreementLabel.userInteractionEnabled = YES;
        _registAgreementLabel.textColor = KHEXRGB(0x999999);
        _registAgreementLabel.font = [UIFont systemFontOfSize:12];
        _registAgreementLabel.textAlignment = NSTextAlignmentCenter;
        NSString *defaultStr = @"注册表示你同意 《注册协议》";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:defaultStr];
        //设置尺寸
        [attributedString addAttribute:NSForegroundColorAttributeName value:KHEXRGB(0x44C08C) range:[defaultStr rangeOfString:@"《注册协议》"]];
        _registAgreementLabel.attributedText = attributedString;
    }
    return _registAgreementLabel;
}

- (UILabel *)errorTipLabel {
    if (!_errorTipLabel) {
        _errorTipLabel = [[UILabel alloc] init];
        _errorTipLabel.textColor = KHEXRGB(0xFF5753);
        _errorTipLabel.font = [UIFont systemFontOfSize:12];
        _errorTipLabel.text = @"!手机号码错误";
    }
    return _errorTipLabel;
}

@end
