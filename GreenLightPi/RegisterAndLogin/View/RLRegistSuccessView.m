//
//  RLRegistSuccessView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/26.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "RLRegistSuccessView.h"

@interface RLRegistSuccessView()
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *activationBtn;
@property (nonatomic, strong) UIButton *noActivationBtn;
@property (nonatomic, strong) UILabel *mottoLabel;
@property (nonatomic, strong) UILabel *autherLabel;
@end

@implementation RLRegistSuccessView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatRegistSuccessSubViews];
    }
    return self;
}

- (void)creatRegistSuccessSubViews {
    [self addSubview:self.cancleBtn];
    [self addSubview:self.tipImageView];
    [self addSubview:self.tipLabel];
    [self addSubview:self.activationBtn];
    [self addSubview:self.noActivationBtn];
    [self addSubview:self.mottoLabel];
    [self addSubview:self.autherLabel];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@16);
        make.right.equalTo(@(-16));
        make.width.height.equalTo(@20);
    }];
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@72);
        make.centerX.equalTo(self);
        make.top.equalTo(@81);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipImageView.mas_bottom).offset(11);
        make.centerX.equalTo(self);
        make.height.equalTo(@18);
        make.width.equalTo(@200);
    }];
    
    [self.activationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@(-28));
        make.top.equalTo(self.tipLabel.mas_bottom).offset(97);
        make.height.equalTo(@48);
    }];
    
    [self.noActivationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.activationBtn.mas_bottom).offset(19);
        make.left.equalTo(@28);
        make.right.equalTo(@(-28));
        make.height.equalTo(@48);
    }];
    
    [self.autherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@57);
        make.right.equalTo(@(-57));
        make.height.equalTo(@8);
        make.bottom.equalTo(@(-51));
    }];
    
    [self.mottoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@57);
        make.right.equalTo(@(-57));
        make.height.equalTo(@8);
        make.bottom.equalTo(self.autherLabel.mas_top).offset(-20);
    }];
    
    @weakify(self);
    [[self.cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(20, nil, nil);
        }
    }];
    
    [[self.activationBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(21, nil, nil);
        }
    }];
    
    [[self.noActivationBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(22, nil, nil);
        }
    }];
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [[UIButton alloc] init];
        [_cancleBtn setImage:[UIImage imageNamed:@"rlCancel"] forState:UIControlStateNormal];
        [_cancleBtn setExclusiveTouch:YES];
    }
    return _cancleBtn;
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] init];
        _tipImageView.image = [UIImage imageNamed:@"regist_success"];
    }
    return _tipImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"恭喜！注册成功";
        _tipLabel.textColor = KHEXRGB(0x333333);
        _tipLabel.font = [UIFont boldSystemFontOfSize:19];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIButton *)activationBtn {
    if (!_activationBtn) {
        _activationBtn = [[UIButton alloc] init];
        [_activationBtn setBackgroundColor:KHEXRGB(0x00D399)];
        [_activationBtn setTitle:@"激活独角兽乐园" forState:UIControlStateNormal];
        [_activationBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _activationBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        XSViewBorderRadius(_activationBtn, 24, 0, KHEXRGB(0x00D399));
    }
    return _activationBtn;
}

- (UIButton *)noActivationBtn {
    if (!_noActivationBtn) {
        _noActivationBtn = [[UIButton alloc] init];
        [_noActivationBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        [_noActivationBtn setTitle:@"暂不激活" forState:UIControlStateNormal];
        [_noActivationBtn setTitleColor:KHEXRGB(0x333333) forState:UIControlStateNormal];
        _noActivationBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        XSViewBorderRadius(_noActivationBtn, 24, 0, KHEXRGB(0x00D399));
    }
    return _noActivationBtn;
}

- (UILabel *)mottoLabel {
    if (!_mottoLabel) {
        _mottoLabel = [[UILabel alloc] init];
        _mottoLabel.textColor = KHEXRGB(0x333333);
        _mottoLabel.text = @"对双亲来说，家庭教育首先是自我教育";
        _mottoLabel.font = [UIFont systemFontOfSize:14];
    }
    return _mottoLabel;
}

- (UILabel *)autherLabel {
    if (!_autherLabel) {
        _autherLabel = [[UILabel alloc] init];
        _autherLabel.text = @"— 克鲁普斯卡娅";
        _autherLabel.textColor = KHEXRGB(0x333333);
        _autherLabel.font = [UIFont systemFontOfSize:14];
        _autherLabel.textAlignment = NSTextAlignmentRight;
    }
    return _autherLabel;
}

@end
