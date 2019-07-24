//
//  RLFindPswView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/26.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "RLFindPswView.h"
#import "RLSingleTextView.h"
#import "UIButton+Common.h"

@interface RLFindPswView()
@property(strong,nonatomic)UIButton *finishBtn;
@end

@implementation RLFindPswView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatFindPswSubViews];
        [self.telephoneTextfield.contentTextfield becomeFirstResponder];
        if (@available(iOS 12.0, *)) {
            self.codeTextfield.contentTextfield.textContentType = UITextContentTypeOneTimeCode;
        }
    }
    return self;
}

- (void)creatFindPswSubViews {
    [self addSubview:self.telephoneTextfield];
    [self addSubview:self.pswTextfield];
    [self addSubview:self.codeTextfield];
    [self addSubview:self.finishBtn];
    
    [self.telephoneTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(@5);
        make.height.equalTo(@60);
    }];
    
    [self.pswTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.telephoneTextfield.mas_bottom);
        make.height.equalTo(@60);
    }];
    
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.pswTextfield.mas_bottom);
        make.height.equalTo(@60);
    }];
    
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeTextfield.mas_bottom).offset(60);
        make.left.equalTo(@28);
        make.right.equalTo(@(-28));
        make.height.equalTo(@48);
    }];
    
    @weakify(self);
    [[self.codeTextfield.getCodebtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (![ATYUtils isNumText:self.telephoneTextfield.contentTextfield.text]) {
            [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码！"];
            return ;
        } else {
            [self.codeTextfield.getCodebtn xs_startWithTime:60 title:@"重新获取" countDownTitle:@"s" mainColor:KHEXRGB(0xF9694E) countColor:KHEXRGB(0x44C08C)];
        }
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.finishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
}

#pragma mark -- 懒加载
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

- (UIButton *)finishBtn {
    if (!_finishBtn) {
        _finishBtn = [[UIButton alloc] init];
        [_finishBtn setBackgroundColor:KHEXRGB(0x00D399)];
        [_finishBtn setTitle:@"完 成" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _finishBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        XSViewBorderRadius(_finishBtn, 24, 0, KHEXRGB(0x00D399));
    }
    return _finishBtn;
}

@end
