//
//  FCCourseDetailTipView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/21.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCCourseDetailTipView.h"

@interface FCCourseDetailTipView()
@property (nonatomic, strong) UIView *backColorView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel1;
@property (nonatomic, strong) UILabel *titleLabel2;
@property (nonatomic, strong) UIButton *tipButton;
@end

@implementation FCCourseDetailTipView

- (UIView *)backColorView {
    if (!_backColorView) {
        _backColorView = [UIView new];
        _backColorView.backgroundColor = KHEXRGB(0x000000);
        _backColorView.alpha = 0.3;
    }
    return _backColorView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 4, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = KHEXRGB(0x646464);
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.text = @"提示";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor =KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

- (UILabel *)titleLabel1 {
    if (!_titleLabel1) {
        _titleLabel1 = [UILabel new];
        _titleLabel1.textColor = KHEXRGB(0x333333);
        _titleLabel1.font = [UIFont systemFontOfSize:16];
        _titleLabel1.text = @"暂只支持在线下游泳馆门店";
        _titleLabel1.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel1;
}

- (UILabel *)titleLabel2 {
    if (!_titleLabel2) {
        _titleLabel2 = [UILabel new];
        _titleLabel2.textColor = KHEXRGB(0x333333);
        _titleLabel2.font = [UIFont systemFontOfSize:16];
        _titleLabel2.text = @"购买相关VIP会员服务";
        _titleLabel2.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel2;
}

- (UIButton *)tipButton {
    if (!_tipButton) {
        _tipButton = [UIButton new];
        [_tipButton setBackgroundColor:KHEXRGB(0x44C08C)];
        [_tipButton setTitle:@"我知道了" forState:UIControlStateNormal];
        [_tipButton setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        XSViewBorderRadius(_tipButton, 4, 0, KHEXRGB(0x44C08C));
    }
    return _tipButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        [self fc_tipViews];
    }
    return self;
}

- (void)fc_tipViews {
//    [self addSubview:self.backColorView];
    [self addSubview:self.backView];
    [self.backView addSubview:self.tipLabel];
    [self.backView addSubview:self.lineView];
    [self.backView addSubview:self.titleLabel1];
    [self.backView addSubview:self.titleLabel2];
    [self.backView addSubview:self.tipButton];
    
//    [self.backColorView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@270);
        make.height.equalTo(@192);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.backView);
        make.height.equalTo(@41);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.tipLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.lineView.mas_bottom).offset(28);
        make.height.equalTo(@19);
    }];
    
    [self.titleLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.titleLabel1.mas_bottom);
        make.height.equalTo(@19);
    }];
    
    [self.tipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.bottom.equalTo(self.backView.mas_bottom).offset(-19);
        make.height.equalTo(@40);
    }];
    
    @weakify(self);
    [[self.tipButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
}

@end
