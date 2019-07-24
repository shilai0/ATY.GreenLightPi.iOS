//
//  DataLoadFaultView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/11/1.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "DataLoadFaultView.h"

@interface DataLoadFaultView ()
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UIButton *reLoadBtn;
@end

@implementation DataLoadFaultView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatLoadDataDefaultView];
    }
    return self;
}

- (void)creatLoadDataDefaultView {
    [self addSubview:self.tipImageView];
    [self addSubview:self.reLoadBtn];

    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@(227*KWIDTHSCALE));
        make.width.equalTo(@228);
        make.height.equalTo(@157);
    }];

    [self.reLoadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipImageView.mas_bottom).offset(28);
        make.centerX.equalTo(self.tipImageView.mas_centerX);
        make.height.equalTo(@33);
        make.width.equalTo(@100);
    }];

    @weakify(self);
    [[self.reLoadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] init];
        _tipImageView.image = [UIImage imageNamed:@"dataLoadDefault"];
    }
    return _tipImageView;
}

- (UIButton *)reLoadBtn {
    if (!_reLoadBtn) {
        _reLoadBtn = [[UIButton alloc] init];
        [_reLoadBtn setTitle:@"重新加载" forState:UIControlStateNormal];
        [_reLoadBtn setTitleColor:KHEXRGB(0x44C08C) forState:UIControlStateNormal];
        _reLoadBtn.titleLabel.font = [UIFont boldSystemFontOfSize:13];
        XSViewBorderRadius(_reLoadBtn, 17, 1, KHEXRGB(0x44C08C));
    }
    return _reLoadBtn;
}

@end
