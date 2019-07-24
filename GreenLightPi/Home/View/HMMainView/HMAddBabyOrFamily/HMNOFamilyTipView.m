//
//  HMNOFamilyTipView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/5/29.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "HMNOFamilyTipView.h"

@interface HMNOFamilyTipView()
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UIButton *addBabyBtn;
@property (nonatomic, strong) UIButton *activationBtn;
@end

@implementation HMNOFamilyTipView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatNOFamilyTipViews];
    }
    return self;
}

- (void)creatNOFamilyTipViews {
    [self addSubview:self.tipImageView];
    [self addSubview:self.addBabyBtn];
    [self addSubview:self.activationBtn];
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@(KNavgationBarHeight + 50*KHEIGHTSCALE));
        make.width.height.equalTo(@125);
    }];
    
    [self.addBabyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@(-30));
        make.height.equalTo(@50);
        make.top.equalTo(self.tipImageView.mas_bottom).offset(80);
    }];
    
    [self.activationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.right.equalTo(@(-30));
        make.height.equalTo(@50);
        make.top.equalTo(self.addBabyBtn.mas_bottom).offset(50);
    }];
    
    @weakify(self);
    [[self.addBabyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.activationBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
}

//- (UILabel *)tipLabel1 {
//    if (!_tipLabel1) {
//        _tipLabel1 = [[UILabel alloc] init];
//        _tipLabel1.text = @"您的账号暂时没有建立家庭组哦！";
//        _tipLabel1.textColor = KHEXRGB(0x646464);
//        _tipLabel1.font = [UIFont boldSystemFontOfSize:18];
//    }
//    return _tipLabel1;
//}
//
//- (UILabel *)tipLabel2 {
//    if (!_tipLabel2) {
//        _tipLabel2 = [[UILabel alloc] init];
//        _tipLabel2.text = @"您可以通过以下方式建立自己的家庭组：";
//        _tipLabel2.textColor = KHEXRGB(0xFD6D5E);
//        _tipLabel2.font = [UIFont boldSystemFontOfSize:18];
//    }
//    return _tipLabel2;
//}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] init];
        _tipImageView.image = [UIImage imageNamed:@"em_default"];
    }
    return _tipImageView;
}

- (UIButton *)addBabyBtn {
    if (!_addBabyBtn) {
        _addBabyBtn = [[UIButton alloc] init];
        [_addBabyBtn setBackgroundColor:KHEXRGB(0x44C08C)];
        [_addBabyBtn setTitle:@"添加宝宝创建家庭组" forState:UIControlStateNormal];
        [_addBabyBtn setTitleColor:KHEXRGB(0xFEFEFE) forState:UIControlStateNormal];
        _addBabyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        XSViewBorderRadius(_addBabyBtn, 24, 0, KHEXRGB(0xFFFFFF));
    }
    return _addBabyBtn;
}

- (UIButton *)activationBtn {
    if (!_activationBtn) {
        _activationBtn = [[UIButton alloc] init];
        [_activationBtn setBackgroundColor:KHEXRGB(0x44C08C)];
        [_activationBtn setTitle:@"激活盒子创建家庭组" forState:UIControlStateNormal];
        [_activationBtn setTitleColor:KHEXRGB(0xFEFEFE) forState:UIControlStateNormal];
        _activationBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        XSViewBorderRadius(_activationBtn, 24, 0, KHEXRGB(0xFFFFFF));
    }
    return _activationBtn;
}

@end
