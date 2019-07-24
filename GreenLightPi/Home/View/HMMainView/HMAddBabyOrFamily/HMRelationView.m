//
//  HMRelationView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/11.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMRelationView.h"

@interface HMRelationView()
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIView *backView;
@end

@implementation HMRelationView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatRelationViews];
        self.backgroundColor = KHEXRGB(0xFFFFFF);
    }
    return self;
}

- (void)creatRelationViews {
    [self addSubview:self.backView];
    [self.backView addSubview:self.relationTextField];
    [self addSubview:self.sureBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@12);
        make.right.equalTo(@(-69));
        make.height.equalTo(@36);
    }];
    
    [self.relationTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.bottom.equalTo(self.backView);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.relationTextField.mas_centerY);
        make.left.equalTo(self.relationTextField.mas_right);
        make.right.equalTo(self);
        make.height.equalTo(@60);
    }];
    
    @weakify(self);
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xF7F7F7);
        XSViewBorderRadius(_backView, 18, 0, KHEXRGB(0xF7F7F7));
    }
    return _backView;
}

- (UITextField *)relationTextField {
    if (!_relationTextField) {
        _relationTextField = [[UITextField alloc] init];
        _relationTextField.placeholder = @"与宝宝的关系";
    }
    return _relationTextField;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:KHEXRGB(0x00D399) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _sureBtn;
}

@end
