//
//  PCChangeNoView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCChangeNoView.h"
#import "UIButton+Common.h"

@interface PCChangeNoView ()
@property(strong,nonatomic)UIView *line1V;
@property(strong,nonatomic)UIView *line2V;
/** 获取验证码 */
@property (nonatomic, strong) UIButton *getCodebtn;
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation PCChangeNoView

- (UITextField *)telephoneTextfield {
    if (!_telephoneTextfield) {
        _telephoneTextfield = [UITextField new];
        _telephoneTextfield.font = [UIFont systemFontOfSize:16];
        _telephoneTextfield.backgroundColor = [UIColor clearColor];
        _telephoneTextfield.borderStyle = UITextBorderStyleNone;
        _telephoneTextfield.keyboardType = UIKeyboardTypeNumberPad;
        _telephoneTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        _telephoneTextfield.placeholder = NSLocalizedString(@"输入新手机号", nil);
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 50, 80)];
        leftLabel.text = @"+86 |";
        leftLabel.textColor = KHEXRGB(0x666666);
        leftLabel.font = [UIFont systemFontOfSize:16];
        _telephoneTextfield.leftView = leftLabel;
        _telephoneTextfield.leftViewMode = UITextFieldViewModeAlways;
    }
    return _telephoneTextfield;
}

- (UIView *)line1V {
    if (!_line1V) {
        _line1V = [UIView new];
        _line1V.backgroundColor = KHEXRGB(0xE6E6E6);
    }
    return _line1V;
}

- (UITextField *)codeTextfield {
    if (!_codeTextfield) {
        _codeTextfield = [UITextField new];
        _codeTextfield.font = [UIFont systemFontOfSize:16];
        _codeTextfield.borderStyle = UITextBorderStyleNone;
        _codeTextfield.placeholder = @"填写获取验证码";
        self.getCodebtn = [[UIButton alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 70, 0, 120, 80)];
        [self.getCodebtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getCodebtn setTitleColor:KHEXRGB(0x44C08C) forState:UIControlStateNormal];
        self.getCodebtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _codeTextfield.rightView = self.getCodebtn;
        _codeTextfield.rightViewMode = UITextFieldViewModeAlways;
    }
    return _codeTextfield;
}

- (UIView *)line2V {
    if (!_line2V) {
        _line2V = [UIView new];
        _line2V.backgroundColor = KHEXRGB(0xE6E6E6);
    }
    return _line2V;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = KHEXRGB(0x999999);
        _tipLabel.text = @"（更换手机号后可以用新手机号及当前密码登录）";
        _tipLabel.font = [UIFont systemFontOfSize:12];
    }
    return _tipLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self pc_creatChangeNoView];
    }
    return self;
}

- (void)pc_creatChangeNoView {
    [self addSubview:self.telephoneTextfield];
    [self addSubview:self.line1V];
    [self addSubview:self.codeTextfield];
    [self addSubview:self.line2V];
    [self addSubview:self.tipLabel];
    
    [self.telephoneTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(5);
        make.left.equalTo(@20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@61);
    }];
    
    [self.line1V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.telephoneTextfield.mas_bottom);
        make.left.equalTo(@16);
        make.right.equalTo(self.mas_right).offset(-16);
        make.height.equalTo(@1);
    }];
    
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line1V.mas_bottom);
        make.left.equalTo(@20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@61);
    }];
    
    [self.line2V mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextfield.mas_bottom);
        make.left.equalTo(@20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.equalTo(@1);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@24);
        make.top.equalTo(self.line2V.mas_bottom).offset(24);
        make.right.equalTo(self);
        make.height.equalTo(@12);
    }];
    
    @weakify(self);
    [[self.getCodebtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.getCodebtn xs_startWithTime:30 title:@"重新获取" countDownTitle:@"s" mainColor:KHEXRGB(0xF9694E) countColor:KHEXRGB(0x44C08C)];
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(4, self.telephoneTextfield.text, nil);
        }
    }];
}

@end
