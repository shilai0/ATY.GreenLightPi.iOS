//
//  PCAuthenFooterView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/1.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCAuthenFooterView.h"

@interface PCAuthenFooterView ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *idcardNoButton;
@property (nonatomic, strong) UILabel *idTipLabel;
@end

@implementation PCAuthenFooterView

- (UILabel *)idTipLabel {
    if (!_idTipLabel) {
        _idTipLabel = [UILabel new];
        _idTipLabel.text = @"身份证正面";
        _idTipLabel.textColor = KHEXRGB(0x999999);
        _idTipLabel.font = [UIFont systemFontOfSize:12];
        _idTipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _idTipLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"上传身份证";
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.text = @"头像与个人信息必须清晰，大小不超过3M";
        _tipLabel.textColor = KHEXRGB(0x999999);
        _tipLabel.font = [UIFont systemFontOfSize:12];
    }
    return _tipLabel;
}

- (UIButton *)idcardNoButton {
    if (!_idcardNoButton) {
        _idcardNoButton = [UIButton new];
        [_idcardNoButton setBackgroundColor:KHEXRGB(0xF8F8F8)];
        [_idcardNoButton setImage:[UIImage imageNamed:@"PC_add"] forState:UIControlStateNormal];
        XSViewBorderRadius(_idcardNoButton, 6, 0, KHEXRGB(0xF8F8F8));
    }
    return _idcardNoButton;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self pc_creatAuthFooterView];
    }
    return self;
}

- (void)pc_creatAuthFooterView {
    [self addSubview:self.titleLabel];
    [self addSubview:self.tipLabel];
    [self addSubview:self.idcardNoButton];
    [self addSubview:self.idTipLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@23);
        make.width.equalTo(@100);
        make.height.equalTo(@15);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.equalTo(@16);
        make.right.equalTo(self);
        make.height.equalTo(@12);
    }];
    
    [self.idcardNoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(35);
        make.width.equalTo(@150);
        make.height.equalTo(@100);
    }];
    
    [self.idTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.top.equalTo(self.idcardNoButton.mas_bottom).offset(16);
        make.width.equalTo(@150);
        make.height.equalTo(@12);
    }];
    
    @weakify(self);
    [[self.idcardNoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.addBtnBlock) {
            self.addBtnBlock();
        }
    }];
}

- (void)setIdCardimage:(UIImage *)IdCardimage {
    _IdCardimage = IdCardimage;
    [self.idcardNoButton setImage:nil forState:UIControlStateNormal];
    [self.idcardNoButton setBackgroundImage:IdCardimage forState:UIControlStateNormal];
}

@end
