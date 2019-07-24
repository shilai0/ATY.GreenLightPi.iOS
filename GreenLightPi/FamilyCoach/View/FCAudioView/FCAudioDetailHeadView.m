//
//  FCAudioDetailHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCAudioDetailHeadView.h"
#import "FileEntityModel.h"
#import "UIImageView+WebCache.h"
#import "FcCoursesModel.h"

@interface FCAudioDetailHeadView ()
@property (nonatomic, strong) UIImageView *backView;
@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *subscribeBtn;
@end

@implementation FCAudioDetailHeadView

- (UIImageView *)backView {
    if (!_backView) {
        _backView = [UIImageView new];
        _backView.userInteractionEnabled = YES;
    }
    return _backView;
}

- (UIButton *)returnBtn {
    if (!_returnBtn) {
        _returnBtn = [UIButton new];
        [_returnBtn setBackgroundImage:[UIImage imageNamed:@"fc_return"] forState:UIControlStateNormal];
    }
    return _returnBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton new];
        [_shareBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
    }
    return _shareBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:21];
        _titleLabel.textColor = KHEXRGB(0xFFFFFF);
    }
    return _titleLabel;
}

- (UIButton *)subscribeBtn {
    if (!_subscribeBtn) {
        _subscribeBtn = [UIButton new];
        [_subscribeBtn setBackgroundColor:KHEXRGB(0x44C08C)];
        [_subscribeBtn setTitle:@" 订阅" forState:UIControlStateNormal];
        [_subscribeBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _subscribeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        XSViewBorderRadius(_subscribeBtn, 12, 0, KHEXRGB(0x44C08C));
    }
    return _subscribeBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self fc_creatAudioDetailViews];
    }
    return self;
}

- (void)fc_creatAudioDetailViews {
    [self addSubview:self.backView];
    [self.backView addSubview:self.returnBtn];
    [self.backView addSubview:self.shareBtn];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.subscribeBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@35);
        make.width.height.equalTo(@24);
    }];
    
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.returnBtn.mas_centerY);
        make.right.equalTo(@(-16));
        make.width.height.equalTo(@24);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.bottom.equalTo(@(-16));
        make.height.equalTo(@20);
        make.right.equalTo(@(-80));
    }];
    
    [self.subscribeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.bottom.equalTo(@(-14));
        make.height.equalTo(@27);
        make.width.equalTo(@60);
    }];
    
    @weakify(self);
    [[self.returnBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
    
    [[self.subscribeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(2, nil, nil);
        }
    }];
}
    
- (void)setModel:(FcCoursesModel *)model {
    _model = model;
    [self.backView sd_setImageWithURL:[NSURL URLWithString:_model.image.path] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = _model.title;
    if ([model.isPurchase integerValue] == 1) {
        [self.subscribeBtn setTitle:@"已订阅" forState:UIControlStateNormal];
        [self.subscribeBtn setTitleColor:KHEXRGB(0x646464) forState:UIControlStateNormal];
        [self.subscribeBtn setBackgroundColor:KHEXRGB(0xE7E7E7)];
    } else {
        [self.subscribeBtn setTitle:@"订阅" forState:UIControlStateNormal];
        [self.subscribeBtn setImage:[UIImage imageNamed:@"Star"] forState:UIControlStateNormal];
        [self.subscribeBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        [self.subscribeBtn setBackgroundColor:KHEXRGB(0x44C08C)];
    }
}

@end
