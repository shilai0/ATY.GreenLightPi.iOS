//
//  FCPayFailView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/10.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCPayFailView.h"

@interface FCPayFailView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *rePayBtn;
@end

@implementation FCPayFailView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self fc_creatPayFailViews];
    }
    return self;
}

- (void)fc_creatPayFailViews {
    [self addSubview:self.backView];
    [self.backView addSubview:self.tipImageView];
    [self.backView addSubview:self.tipLabel];
    [self.backView addSubview:self.rePayBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.backView.mas_top).offset(46);
        make.height.width.equalTo(@48);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.tipImageView.mas_bottom).offset(16);
        make.height.equalTo(@15);
    }];
    
    [self.rePayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(43);
        make.right.equalTo(self.backView.mas_right).offset(-43);
        make.height.equalTo(@40);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-43);
    }];
    
    @weakify(self);
    [[self.rePayBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
    }
    return _backView;
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [UIImageView new];
        _tipImageView.image = [UIImage imageNamed:@"fc_payFail"];
    }
    return _tipImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.text = @"支付失败，请重新支付";
        _tipLabel.textColor = KHEXRGB(0x333333);
        _tipLabel.font = [UIFont boldSystemFontOfSize:14];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIButton *)rePayBtn {
    if (!_rePayBtn) {
        _rePayBtn = [UIButton new];
        [_rePayBtn setBackgroundColor:KHEXRGB(0x44C08C)];
        [_rePayBtn setTitle:@"重新支付" forState:UIControlStateNormal];
        [_rePayBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _rePayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        XSViewBorderRadius(_rePayBtn, 4, 0, KHEXRGB(0x44C08C));
    }
    return _rePayBtn;
}

@end
