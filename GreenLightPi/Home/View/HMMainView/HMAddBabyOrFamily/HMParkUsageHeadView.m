//
//  HMParkUsageHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/3.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMParkUsageHeadView.h"

@interface HMParkUsageHeadView()
@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *moreBtn;
@end

@implementation HMParkUsageHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatHMParkUsageHeadViews];
    }
    return self;
}

- (void)creatHMParkUsageHeadViews {
    [self addSubview:self.returnBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.moreBtn];
    
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@28);
        make.width.height.equalTo(@28);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@33);
        make.height.equalTo(@13);
        make.width.equalTo(@240);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.returnBtn.mas_centerY);
        make.right.equalTo(@(-23));
        make.width.height.equalTo(@21);
    }];
    
    @weakify(self);
    [[self.returnBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
    
}

- (UIButton *)returnBtn {
    if (!_returnBtn) {
        _returnBtn = [[UIButton alloc] init];
        [_returnBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    }
    return _returnBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"独角兽乐园使用统计";
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn = [[UIButton alloc] init];
        [_moreBtn setImage:[UIImage imageNamed:@"morePark"] forState:UIControlStateNormal];
    }
    return _moreBtn;
}

@end
