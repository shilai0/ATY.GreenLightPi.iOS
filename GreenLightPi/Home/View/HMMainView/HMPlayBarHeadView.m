//
//  HMPlayBarHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/30.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMPlayBarHeadView.h"
#import "MoreButton.h"

@implementation HMPlayBarHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatPlayBarHeadViews];
    }
    return self;
}

- (void)creatPlayBarHeadViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.moreBtn];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@20);
        make.height.equalTo(@17);
        make.right.equalTo(@(-100));
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-16);
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(56, 56));
    }];
    
    @weakify(self);
    [[self.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _titleLabel;
}

- (MoreButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [[MoreButton alloc] init];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_moreBtn setImage:[UIImage imageNamed:@"wf_right"] forState:UIControlStateNormal];
    }
    return _moreBtn;
}

@end
