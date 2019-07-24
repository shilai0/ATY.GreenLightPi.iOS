//
//  PCActivityTipView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/18.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCActivityTipView.h"
#import "UIButton+Common.h"


@interface PCActivityTipView()
@property (nonatomic, strong) UIButton *ownActivityBtn;
@property (nonatomic, strong) UIButton *othersActivityBtn;
@property (nonatomic, strong) UIButton *noActivityBtn;

@property (nonatomic, strong) UIView *phoneBackView;
@property (nonatomic, strong) UIButton *getCodeBtn;
@property (nonatomic, strong) UIView *codeBackView;
@property (nonatomic, strong) UIButton *immediatelyBtn;
@property (nonatomic, strong) UIButton *giveUpBtn;

@end

@implementation PCActivityTipView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        [self creatActivityTipViews];
    }
    return self;
}

- (void)creatActivityTipViews {
    [self addSubview:self.backView1];
    [self.backView1 addSubview:self.ownActivityBtn];
    [self.backView1 addSubview:self.othersActivityBtn];
    [self.backView1 addSubview:self.noActivityBtn];
    self.backView1.hidden = YES;
    
    [self addSubview:self.backView2];
    [self.backView2 addSubview:self.phoneBackView];
    [self.phoneBackView addSubview:self.phoneTextField];
    [self.phoneBackView addSubview:self.getCodeBtn];
    [self.backView2 addSubview:self.codeBackView];
    [self.codeBackView addSubview:self.codeTextField];
    [self.backView2 addSubview:self.immediatelyBtn];
    [self.backView2 addSubview:self.giveUpBtn];
    self.backView2.hidden = YES;
    
    [self.backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@320);
        make.height.equalTo(@260);
        make.center.equalTo(self);
    }];
    [self.ownActivityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@26);
        make.right.equalTo(@(-26));
        make.top.equalTo(@54);
        make.height.equalTo(@48);
    }];
    [self.othersActivityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ownActivityBtn.mas_bottom).offset(23);
        make.left.equalTo(@26);
        make.right.equalTo(@(-26));
        make.height.equalTo(@48);
    }];
    [self.noActivityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView1.mas_centerX);
        make.top.equalTo(self.othersActivityBtn.mas_bottom).offset(25);
        make.height.equalTo(@20);
    }];
    
    [self.backView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@320);
        make.height.equalTo(@300);
        make.center.equalTo(self);
    }];
    [self.phoneBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@26);
        make.right.equalTo(@(-26));
        make.top.equalTo(@40);
        make.height.equalTo(@48);
    }];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.phoneBackView);
        make.left.equalTo(@19);
        make.right.equalTo(@(-130));
    }];
    [self.getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.phoneBackView.mas_centerY);
        make.height.equalTo(@14);
        make.right.equalTo(@(-10));
    }];
    [self.codeBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@26);
        make.right.equalTo(@(-26));
        make.top.equalTo(self.phoneBackView.mas_bottom).offset(23);
        make.height.equalTo(@48);
    }];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.codeBackView);
        make.left.equalTo(@18);
        make.right.equalTo(@(-18));
    }];
    [self.immediatelyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@26);
        make.right.equalTo(@(-26));
        make.top.equalTo(self.codeBackView.mas_bottom).offset(23);
        make.height.equalTo(@48);
    }];
    [self.giveUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.immediatelyBtn.mas_bottom).offset(26);
        make.centerX.equalTo(self.backView2.mas_centerX);
        make.height.equalTo(@15);
    }];
    
    
    @weakify(self);
    [[self.ownActivityBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    [[self.othersActivityBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
    [[self.noActivityBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(2, nil, nil);
        }
    }];
    
    // 账号输入框方法
    [[self.phoneTextField rac_signalForControlEvents:UIControlEventEditingChanged | UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.phoneTextField.text.length > 11) {
            self.phoneTextField.text = [self.phoneTextField.text substringToIndex:11];
        }
        if (self.phoneTextField.text.length == 11) {
            self.immediatelyBtn.alpha = 1;
            self.immediatelyBtn.enabled = YES;
        } else {
            self.immediatelyBtn.alpha = 0.5;
            self.immediatelyBtn.enabled = NO;
        }
    }];
    
    [[self.getCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (![ATYUtils isNumText:self.phoneTextField.text]) {
            [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码！"];
            return ;
        }
        [self.getCodeBtn xs_startWithTime:60 title:@"重新获取" countDownTitle:@"s" mainColor:KHEXRGB(0xF9694E) countColor:KHEXRGB(0x44C08C)];
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(3, self.phoneTextField.text, nil);
        }
    }];
    
    [[self.immediatelyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(4, nil, nil);
        }
    }];
    
    [[self.giveUpBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(5, nil, nil);
        }
    }];
    
}

- (UIView *)backView1 {
    if (!_backView1) {
        _backView1 = [[UIView alloc] init];
        _backView1.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView1, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView1;
}

- (UIButton *)ownActivityBtn {
    if (!_ownActivityBtn) {
        _ownActivityBtn = [[UIButton alloc] init];
        [_ownActivityBtn setTitle:@"给自己激活" forState:UIControlStateNormal];
        [_ownActivityBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_ownActivityBtn setBackgroundColor:KHEXRGB(0x00D399)];
        _ownActivityBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        XSViewBorderRadius(_ownActivityBtn, 24, 0, KHEXRGB(0x00D399));
    }
    return _ownActivityBtn;
}

- (UIButton *)othersActivityBtn {
    if (!_othersActivityBtn) {
        _othersActivityBtn = [UIButton new];
        [_othersActivityBtn setTitleColor:KHEXRGB(0x00D399) forState:UIControlStateNormal];
        [_othersActivityBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        [_othersActivityBtn setTitle:@"给他人激活" forState:UIControlStateNormal];
        _othersActivityBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        XSViewBorderRadius(_othersActivityBtn, 24, 1, KHEXRGB(0x00D399));
    }
    return _othersActivityBtn;
}

- (UIButton *)noActivityBtn {
    if (!_noActivityBtn) {
        _noActivityBtn = [UIButton new];
        [_noActivityBtn setTitle:@"暂不激活" forState:UIControlStateNormal];
        [_noActivityBtn setTitleColor:KHEXRGB(0x00D399) forState:UIControlStateNormal];
        _noActivityBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _noActivityBtn;
}

- (UIView *)backView2 {
    if (!_backView2) {
        _backView2 = [[UIView alloc] init];
        _backView2.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView2, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView2;
}

- (UIView *)phoneBackView {
    if (!_phoneBackView) {
        _phoneBackView = [UIView new];
        _phoneBackView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_phoneBackView, 24, 1, KHEXRGB(0x00D399));
    }
    return _phoneBackView;
}

- (UITextField *)phoneTextField {
    if (!_phoneTextField) {
        _phoneTextField = [UITextField new];
        _phoneTextField.placeholder = @"请填写TA的手机号";
        _phoneTextField.font = [UIFont boldSystemFontOfSize:14];
        _phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _phoneTextField;
}

- (UIButton *)getCodeBtn {
    if (!_getCodeBtn) {
        _getCodeBtn = [[UIButton alloc] init];
        [_getCodeBtn setTitle:@"验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:KHEXRGB(0x00D399) forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_getCodeBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
    }
    return _getCodeBtn;
}

- (UIView *)codeBackView {
    if (!_codeBackView) {
        _codeBackView = [UIView new];
        _codeBackView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_codeBackView, 24, 1, KHEXRGB(0x00D399));
    }
    return _codeBackView;
}

- (UITextField *)codeTextField {
    if (!_codeTextField) {
        _codeTextField = [UITextField new];
        _codeTextField.placeholder = @"请填写验证码";
        _codeTextField.font = [UIFont boldSystemFontOfSize:14];
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _codeTextField;
}

- (UIButton *)immediatelyBtn {
    if (!_immediatelyBtn) {
        _immediatelyBtn = [[UIButton alloc] init];
        [_immediatelyBtn setBackgroundColor:KHEXRGB(0x00D399)];
        [_immediatelyBtn setTitle:@"立即激活" forState:UIControlStateNormal];
        [_immediatelyBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _immediatelyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _immediatelyBtn.alpha = 0.5;
        _immediatelyBtn.enabled = NO;
        XSViewBorderRadius(_immediatelyBtn, 24, 0, KHEXRGB(0x00D399));
    }
    return _immediatelyBtn;
}

- (UIButton *)giveUpBtn {
    if (!_giveUpBtn) {
        _giveUpBtn = [UIButton new];
        [_giveUpBtn setTitle:@"放弃激活" forState:UIControlStateNormal];
        [_giveUpBtn setTitleColor:KHEXRGB(0x00D399) forState:UIControlStateNormal];
        _giveUpBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _giveUpBtn;
}

@end
