//
//  RLLoginView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "RLLoginView.h"
#import "RLSegmentView.h"
#import "RLSingleTextView.h"
#import "ATYAlertViewController.h"
#import "UIButton+Common.h"

@interface RLLoginView () <UITextFieldDelegate>
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) RLSegmentView *segmentView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *newUserRegistBtn;
@property (nonatomic, strong) UIButton *wechatLoginBtn;
@property (nonatomic, strong) UILabel *wechatLoginLabel;
@property (nonatomic, assign) NSInteger loginIndex;
@end

@implementation RLLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self rl_creatLoginSubViews];
//        [self.telephoneTextfield.contentTextfield becomeFirstResponder];
        if (@available(iOS 12.0, *)) {
            self.codeTextfield.contentTextfield.textContentType = UITextContentTypeOneTimeCode;
        }
    }
    return self;
}

#pragma mark -创建并添加子视图
- (void)rl_creatLoginSubViews {
    [self addSubview:self.cancleBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.segmentView];
    [self addSubview:self.telephoneTextfield];
    [self addSubview:self.codeTextfield];
    [self addSubview:self.psdTextfield];
    [self addSubview:self.loginBtn];
    [self addSubview:self.newUserRegistBtn];
    [self addSubview:self.wechatLoginBtn];
    [self addSubview:self.wechatLoginLabel];
    self.codeTextfield.hidden = NO;
    self.psdTextfield.hidden = YES;
    
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
    
    [self.segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.height.equalTo(@40);
    }];
    
    [self.telephoneTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.segmentView.mas_bottom);
        make.height.equalTo(@60);
    }];
    
    [self.codeTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.telephoneTextfield.mas_bottom);
        make.height.equalTo(@60);
    }];
    
    [self.psdTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.telephoneTextfield.mas_bottom);
        make.height.equalTo(@60);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@(-28));
        make.top.equalTo(self.codeTextfield.mas_bottom).offset(33);
        make.height.equalTo(@48);
    }];
    
    [self.newUserRegistBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loginBtn.mas_bottom).offset(18);
        make.height.equalTo(@14);
        make.centerX.equalTo(self.loginBtn.mas_centerX);
        make.width.equalTo(@150);
    }];
    
    [self.wechatLoginLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.loginBtn.mas_centerX);
        make.bottom.equalTo(self.mas_bottom).offset(-28-KBottomSafeHeight);
        make.height.equalTo(@13);
        make.width.equalTo(@80);
    }];
    
    [self.wechatLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.loginBtn.mas_centerX);
        make.bottom.equalTo(self.wechatLoginLabel.mas_top).offset(-11);
        make.width.height.equalTo(@36);
    }];
    
    @weakify(self);
    // 账号输入框方法
    [[self.telephoneTextfield.contentTextfield rac_signalForControlEvents:UIControlEventEditingChanged | UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.telephoneTextfield.contentTextfield.text.length > 11) {
            self.telephoneTextfield.contentTextfield.text = [self.telephoneTextfield.contentTextfield.text substringToIndex:11];
        }
        if (self.telephoneTextfield.contentTextfield.text.length == 11) {
            self.loginBtn.alpha = 1;
            self.loginBtn.enabled = YES;
        } else {
            self.loginBtn.alpha = 0.5;
            self.loginBtn.enabled = NO;
        }
    }];
    
    [[self.cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(10, nil, nil);
        }
    }];
    
    self.segmentView.DidSegmentClickBlock = ^(NSInteger index) {
        @strongify(self);
        self.loginIndex = index;
        if (index == 0) {
            self.titleLabel.text = @"短信验证码登录";
            self.codeTextfield.hidden = NO;
            self.psdTextfield.hidden = YES;
        } else {
            self.titleLabel.text = @"密码登录";
            self.codeTextfield.hidden = YES;
            self.psdTextfield.hidden = NO;
        }
    };
    
    [[self.codeTextfield.getCodebtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (![ATYUtils isNumText:self.telephoneTextfield.contentTextfield.text]) {
            [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码！"];
            return ;
        } else {
            [self.codeTextfield.getCodebtn xs_startWithTime:60 title:@"重新获取" countDownTitle:@"s" mainColor:KHEXRGB(0xF9694E) countColor:KHEXRGB(0x44C08C)];
        }
        
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(self.loginIndex + 11, self.telephoneTextfield.contentTextfield.text, nil);
        }
    }];
    
    [[self.psdTextfield.getCodebtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(self.loginIndex + 11, self.telephoneTextfield.contentTextfield.text, nil);
        }
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(self.loginIndex + 13, nil, nil);
        }
    }];
    
    [[self.newUserRegistBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(15, nil, nil);
        }
    }];
    
    [[self.wechatLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(16, nil, nil);
        }
    }];
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
        _titleLabel.text = @"短信验证码登录";
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont boldSystemFontOfSize:24];
    }
    return _titleLabel;
}

- (RLSegmentView *)segmentView {
    if (!_segmentView) {
        _segmentView = [[RLSegmentView alloc] initWithItems:[[NSArray alloc] initWithObjects:@"短信验证码登录", @"密码登录",nil]];
    }
    return _segmentView;
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

- (RLSingleTextView *)codeTextfield {
    if (!_codeTextfield) {
        _codeTextfield = [[RLSingleTextView alloc] init];
        _codeTextfield.contentTextfield.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextfield.getCodebtn.hidden = NO;
        _codeTextfield.contentTextfield.placeholder = @"输入验证码";
        [_codeTextfield.getCodebtn setTitle:@"获取验证码？" forState:UIControlStateNormal];
        [_codeTextfield.getCodebtn setTitleColor:KHEXRGB(0x646464) forState:UIControlStateNormal];
        _codeTextfield.getCodebtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _codeTextfield;
}

- (RLSingleTextView *)psdTextfield {
    if (!_psdTextfield) {
        _psdTextfield = [[RLSingleTextView alloc] init];
        _psdTextfield.contentTextfield.keyboardType = UIKeyboardTypeASCIICapable;
        _psdTextfield.getCodebtn.hidden = NO;
        _psdTextfield.contentTextfield.secureTextEntry = YES;
        _psdTextfield.contentTextfield.placeholder = @"输入密码";
        [_psdTextfield.getCodebtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_psdTextfield.getCodebtn setTitleColor:KHEXRGB(0x646464) forState:UIControlStateNormal];
        _psdTextfield.getCodebtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _psdTextfield;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setBackgroundColor:KHEXRGB(0x00D399)];
        [_loginBtn setTitle:@"登 录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        XSViewBorderRadius(_loginBtn, 24, 0, KHEXRGB(0x00D399));
    }
    return _loginBtn;
}

- (UIButton *)newUserRegistBtn {
    if (!_newUserRegistBtn) {
        _newUserRegistBtn = [[UIButton alloc] init];
        [_newUserRegistBtn setTitle:@"新用户注册" forState:UIControlStateNormal];
        [_newUserRegistBtn setTitleColor:KHEXRGB(0x3696DF) forState:UIControlStateNormal];
        _newUserRegistBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_newUserRegistBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    }
    return _newUserRegistBtn;
}

- (UIButton *)wechatLoginBtn {
    if (!_wechatLoginBtn) {
        _wechatLoginBtn = [[UIButton alloc] init];
        [_wechatLoginBtn setImage:[UIImage imageNamed:@"login_wx"] forState:UIControlStateNormal];
    }
    return _wechatLoginBtn;
}

- (UILabel *)wechatLoginLabel {
    if (!_wechatLoginLabel) {
        _wechatLoginLabel = [[UILabel alloc] init];
        _wechatLoginLabel.text = @"微信登录";
        _wechatLoginLabel.textColor = KHEXRGB(0xCCCCCC);
        _wechatLoginLabel.font = [UIFont systemFontOfSize:13];
        _wechatLoginLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _wechatLoginLabel;
}

@end
