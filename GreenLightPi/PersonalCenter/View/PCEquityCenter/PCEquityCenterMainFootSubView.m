//
//  PCEquityCenterMainFootSubView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/6.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCEquityCenterMainFootSubView.h"

@interface PCEquityCenterMainFootSubView()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *identifiLabel;
@property (nonatomic, strong) UIButton *sendLinksBtn;
@property (nonatomic, strong) UIButton *generatExtendQRBtn;
@end

@implementation PCEquityCenterMainFootSubView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatEquityCenterFooterSubViews];
    }
    return self;
}

- (void)creatEquityCenterFooterSubViews {
    [self addSubview:self.backImageView];
    [self.backImageView addSubview:self.identifiLabel];
    [self.backImageView addSubview:self.sendLinksBtn];
    [self.backImageView addSubview:self.generatExtendQRBtn];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.identifiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@16);
        make.left.equalTo(@14);
        make.right.equalTo(@(-5));
        make.height.equalTo(@15);
    }];
    
    [self.sendLinksBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.top.equalTo(self.identifiLabel.mas_bottom).offset(12);
        make.height.equalTo(@17);
        make.width.equalTo(@(KSCREEN_WIDTH/4 - 24));
    }];
    
    [self.generatExtendQRBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sendLinksBtn.mas_right).offset(5);
        make.centerY.equalTo(self.sendLinksBtn.mas_centerY);
        make.height.equalTo(@17);
        make.right.equalTo(@(-11));
    }];
    
    @weakify(self);
    [[self.sendLinksBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.generatExtendQRBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
}

- (void)setIdentifitext:(NSString *)identifitext {
    _identifitext = identifitext;
    self.identifiLabel.text = _identifitext;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"partnerBack"];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}

- (UILabel *)identifiLabel {
    if (!_identifiLabel) {
        _identifiLabel = [[UILabel alloc] init];
//        _identifiLabel.text = @"发展城市合伙人";
        _identifiLabel.textColor = KHEXRGB(0xFFFFFF);
        _identifiLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _identifiLabel;
}

- (UIButton *)sendLinksBtn {
    if (!_sendLinksBtn) {
        _sendLinksBtn = [[UIButton alloc] init];
        [_sendLinksBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_sendLinksBtn setTitleColor:KHEXRGB(0xFA7655) forState:UIControlStateNormal];
        [_sendLinksBtn setTitle:@"发送链接给好友" forState:UIControlStateNormal];
        [_sendLinksBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        _sendLinksBtn.titleLabel.font = [UIFont boldSystemFontOfSize:9];
        XSViewBorderRadius(_sendLinksBtn, 7, 0, KHEXRGB(0xFFFFFF));
    }
    return _sendLinksBtn;
}

- (UIButton *)generatExtendQRBtn {
    if (!_generatExtendQRBtn) {
        _generatExtendQRBtn = [[UIButton alloc] init];
        [_generatExtendQRBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_generatExtendQRBtn setTitle:@"生成推广二维码" forState:UIControlStateNormal];
        [_generatExtendQRBtn setTitleColor:KHEXRGB(0xFA7655) forState:UIControlStateNormal];
        _generatExtendQRBtn.titleLabel.font = [UIFont boldSystemFontOfSize:9];
        [_generatExtendQRBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        XSViewBorderRadius(_generatExtendQRBtn, 7, 0, KHEXRGB(0xFFFFFF));
    }
    return _generatExtendQRBtn;
}

@end
