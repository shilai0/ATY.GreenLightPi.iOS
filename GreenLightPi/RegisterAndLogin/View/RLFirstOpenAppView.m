//
//  RLFirstOpenAppView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/22.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "RLFirstOpenAppView.h"

@interface RLFirstOpenAppView()
@property (nonatomic, strong) UILabel *mainLabel;
@property (nonatomic, strong) UILabel *subLabel;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *registerBtn;
@property (nonatomic, strong) UIButton *lookAroundBtn;
@end

@implementation RLFirstOpenAppView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatFirstOpenAppSubViews];
    }
    return self;
}

- (void)creatFirstOpenAppSubViews {
    [self addSubview:self.mainLabel];
    [self addSubview:self.backImageView];
    [self addSubview:self.subLabel];
    [self addSubview:self.loginBtn];
    [self addSubview:self.registerBtn];
    [self addSubview:self.lookAroundBtn];
    
    [self.mainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@29);
        make.right.equalTo(@(-24));
        make.height.equalTo(@24);
        make.top.equalTo(@(89 + KTopBarSafeHeight));
    }];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mainLabel.mas_bottom).offset(22);
        make.height.equalTo(@(322*KHEIGHTSCALE));
    }];
    
    [self.subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mainLabel.mas_bottom).offset(17);
        make.left.equalTo(@29);
        make.right.equalTo(@(-24));
        make.height.equalTo(@14);
    }];
    
    [self.lookAroundBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(- 38 - KBottomSafeHeight));
        make.height.equalTo(@20);
        make.width.equalTo(@100);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@29);
        make.right.equalTo(@(-29));
        make.height.equalTo(@48);
        make.bottom.equalTo(self.lookAroundBtn.mas_top).offset(-23);
    }];
    
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@29);
        make.right.equalTo(@(-29));
        make.height.equalTo(@48);
        make.bottom.equalTo(self.loginBtn.mas_top).offset(-15);
    }];
    
    @weakify(self);
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
    
    [[self.lookAroundBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(2, nil, nil);
        }
    }];
}

#pragma mark -- 懒加载
- (UILabel *)mainLabel {
    if (!_mainLabel) {
        _mainLabel = [[UILabel alloc] init];
        _mainLabel.text = @"更好的父母 成就更好的孩子";
        _mainLabel.textColor = KHEXRGB(0x333333);
        _mainLabel.font = [UIFont boldSystemFontOfSize:25];
    }
    return _mainLabel;
}

- (UILabel *)subLabel {
    if (!_subLabel) {
        _subLabel = [[UILabel alloc] init];
        _subLabel.text = @"每天进步一点点 给TA的爱多一点点";
        _subLabel.textColor = KHEXRGB(0x999999);
        _subLabel.font = [UIFont boldSystemFontOfSize:12];
    }
    return _subLabel;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"loginBack"];
    }
    return _backImageView;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        [_loginBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:KHEXRGB(0x333333) forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        XSViewBorderRadius(_loginBtn, 24, 1, KHEXRGB(0x00D399));
    }
    return _loginBtn;
}

- (UIButton *)registerBtn {
    if (!_registerBtn) {
        _registerBtn = [[UIButton alloc] init];
        [_registerBtn setBackgroundColor:KHEXRGB(0x00D399)];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _registerBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        XSViewBorderRadius(_registerBtn, 24, 0, KHEXRGB(0xFFFFFF));
    }
    return _registerBtn;
}

- (UIButton *)lookAroundBtn {
    if (!_lookAroundBtn) {
        _lookAroundBtn = [[UIButton alloc] init];
        [_lookAroundBtn setTitle:@"随便看看>>" forState:UIControlStateNormal];
        [_lookAroundBtn setTitleColor:KHEXRGB(0x333333) forState:UIControlStateNormal];
        _lookAroundBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return _lookAroundBtn;
}

@end
