//
//  RLRegistAgreementView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/5/8.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "RLRegistAgreementView.h"

@interface RLRegistAgreementView ()
@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIWebView *registAgreementWebView;
@end

@implementation RLRegistAgreementView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        
        [self addSubview:self.returnBtn];
        [self addSubview:self.titleLabel];
        [self addSubview:self.registAgreementWebView];
        
        [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.top.equalTo(@28);
            make.width.height.equalTo(@28);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.returnBtn.mas_centerY);
            make.centerX.equalTo(self.mas_centerX);
            make.height.equalTo(@16);
            make.width.equalTo(@200);
        }];
        
        [self.registAgreementWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(@60);
        }];
        
        [self.registAgreementWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://business.aiteyou.net/h5/agreement.html"]]];
        
        @weakify(self);
        [[self.returnBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.atyClickActionBlock) {
                self.atyClickActionBlock(0, nil, nil);
            }
        }];
    }
    return self;
}

- (UIButton *)returnBtn {
    if (!_returnBtn) {
        _returnBtn = [[UIButton alloc] init];
        [_returnBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    }
    return _returnBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.text = @"一家老小注册协议";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIWebView *)registAgreementWebView {
    if (!_registAgreementWebView) {
        _registAgreementWebView = [[UIWebView alloc] init];
    }
    return _registAgreementWebView;
}

@end
