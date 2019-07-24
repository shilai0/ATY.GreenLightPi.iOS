//
//  HMMyBabyHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/1.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMyBabyHeadView.h"

@interface HMMyBabyHeadView ()
@property (nonatomic, strong) UIButton *addBabyBtn;
@property (nonatomic, strong) UILabel *addBabyLabel;
@property (nonatomic, strong) UIButton *addFamilyBtn;
@property (nonatomic, strong) UILabel *addFamilyLabel;
@end

@implementation HMMyBabyHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatMyBabyHeadViews];
    }
    return self;
}

- (void)creatMyBabyHeadViews {
    [self addSubview:self.addBabyBtn];
    [self addSubview:self.addBabyLabel];
    [self addSubview:self.addFamilyBtn];
    [self addSubview:self.addFamilyLabel];
    
    [self.addBabyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@22);
        make.left.equalTo(@((KSCREEN_WIDTH/2 - 48)/2));
        make.width.height.equalTo(@48);
    }];
    
    [self.addBabyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.addBabyBtn.mas_centerX);
        make.top.equalTo(self.addBabyBtn.mas_bottom).offset(13);
        make.height.equalTo(@14);
        make.width.equalTo(@150);
    }];
    
    [self.addFamilyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.addBabyBtn.mas_centerY);
        make.right.equalTo(@(-(KSCREEN_WIDTH/2 - 48)/2));
        make.width.height.equalTo(@48);
    }];
    
    [self.addFamilyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.addFamilyBtn.mas_centerX);
        make.top.equalTo(self.addFamilyBtn.mas_bottom).offset(13);
        make.height.equalTo(@14);
        make.width.equalTo(@150);
    }];
    
    @weakify(self);
    [[self.addBabyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.addFamilyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
}

- (UIButton *)addBabyBtn {
    if (!_addBabyBtn) {
        _addBabyBtn = [[UIButton alloc] init];
        [_addBabyBtn setImage:[UIImage imageNamed:@"addBaby"] forState:UIControlStateNormal];
    }
    return _addBabyBtn;
}

- (UILabel *)addBabyLabel {
    if (!_addBabyLabel) {
        _addBabyLabel = [[UILabel alloc] init];
        _addBabyLabel.text = @"添加我的宝宝";
        _addBabyLabel.textColor = KHEXRGB(0x333333);
        _addBabyLabel.font = [UIFont boldSystemFontOfSize:14];
        _addBabyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _addBabyLabel;
}

- (UIButton *)addFamilyBtn {
    if (!_addFamilyBtn) {
        _addFamilyBtn = [[UIButton alloc] init];
        [_addFamilyBtn setImage:[UIImage imageNamed:@"addFamily"] forState:UIControlStateNormal];
    }
    return _addFamilyBtn;
}

- (UILabel *)addFamilyLabel {
    if (!_addFamilyLabel) {
        _addFamilyLabel = [[UILabel alloc] init];
        _addFamilyLabel.text = @"邀请家人";
        _addFamilyLabel.font = [UIFont boldSystemFontOfSize:14];
        _addFamilyLabel.textColor = KHEXRGB(0x333333);
        _addFamilyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _addFamilyLabel;
}

@end
