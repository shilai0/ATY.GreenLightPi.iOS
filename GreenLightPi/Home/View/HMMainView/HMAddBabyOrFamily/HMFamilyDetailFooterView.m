//
//  HMFamilyDetailFooterView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/10.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMFamilyDetailFooterView.h"

@interface HMFamilyDetailFooterView()
@property (nonatomic, strong) UIButton *invitationBtn;
@end

@implementation HMFamilyDetailFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatFamilyDetailFooterViews];
    }
    return self;
}

- (void)creatFamilyDetailFooterViews {
    [self addSubview:self.invitationBtn];
    [self addSubview:self.otherBtn];
    
    [self.invitationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@30);
        make.right.equalTo(@(-16));
        make.height.equalTo(@48);
    }];
    
    [self.otherBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(self.invitationBtn.mas_bottom).offset(30);
        make.height.equalTo(@48);
    }];
    
    @weakify(self);
    [[self.invitationBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.invitationBlock) {
            self.invitationBlock(0);
        }
    }];
    
    [[self.otherBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.invitationBlock) {
            self.invitationBlock(1);
        }
    }];
}

- (UIButton *)invitationBtn {
    if (!_invitationBtn) {
        _invitationBtn = [[UIButton alloc] init];
        [_invitationBtn setBackgroundColor:KHEXRGB(0x00D399)];
        [_invitationBtn setTitle:@"邀请更多家人" forState:UIControlStateNormal];
        [_invitationBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _invitationBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        XSViewBorderRadius(_invitationBtn, 24, 0, KHEXRGB(0x00D399));
    }
    return _invitationBtn;
}

- (UIButton *)otherBtn {
    if (!_otherBtn) {
        _otherBtn = [[UIButton alloc] init];
        [_otherBtn setBackgroundColor:KHEXRGB(0xFF7976)];
        [_otherBtn setTitle:@"退出家庭组" forState:UIControlStateNormal];
        [_otherBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _otherBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        XSViewBorderRadius(_otherBtn, 24, 0, KHEXRGB(0x00D399));
    }
    return _otherBtn;
}

@end
