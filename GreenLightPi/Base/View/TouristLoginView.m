//
//  TouristLoginView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/1/18.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "TouristLoginView.h"

@interface TouristLoginView ()
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *goLoginBtn;
@end

@implementation TouristLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    [self addSubview:self.tipImageView];
    [self addSubview:self.tipLabel];
    [self addSubview:self.goLoginBtn];
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@(180*KHEIGHTSCALE));
        make.width.height.equalTo(@131);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.tipImageView.mas_bottom).offset(21);
        make.height.equalTo(@15);
    }];
    
    [self.goLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(33);
        make.height.equalTo(@36);
        make.width.equalTo(@145);
    }];
    
    @weakify(self);
    [[self.goLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] init];
        _tipImageView.image = [UIImage imageNamed:@"TouristDefault"];
    }
    return _tipImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.text = @"登录发现更多精彩";
        _tipLabel.textColor = KHEXRGB(0x646464);
        _tipLabel.font = [UIFont boldSystemFontOfSize:15];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIButton *)goLoginBtn {
    if (!_goLoginBtn) {
        _goLoginBtn = [[UIButton alloc] init];
        [_goLoginBtn setBackgroundColor:KHEXRGB(0x44C08C)];
        [_goLoginBtn setTitle:@"立即登录" forState:UIControlStateNormal];
        [_goLoginBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _goLoginBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        XSViewBorderRadius(_goLoginBtn, 18, 0, KHEXRGB(0x44C08C));
    }
    return _goLoginBtn;
}

@end
