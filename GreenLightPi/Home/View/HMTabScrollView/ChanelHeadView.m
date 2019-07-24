//
//  ChanelHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/9/6.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "ChanelHeadView.h"

@implementation ChanelHeadView

- (UILabel *)biaotiLab {
    if (!_biaotiLab) {
        _biaotiLab = [UILabel new];
        _biaotiLab.textColor = KHEXRGB(0x646464);
        _biaotiLab.font = [UIFont systemFontOfSize:15];
    }
    return _biaotiLab;
}

- (UILabel *)tishiLab {
    if (!_tishiLab) {
        _tishiLab = [UILabel new];
        _biaotiLab.textColor = KHEXRGB(0x646464);
        _biaotiLab.font = [UIFont systemFontOfSize:12];
    }
    return _tishiLab;
}

- (UIButton *)editBtn {
    if (!_editBtn) {
        _editBtn = [UIButton new];
        _editBtn.layer.cornerRadius = 5;
        _editBtn.clipsToBounds = YES;
        [_editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_editBtn setTitleColor:KHEXRGB(0x44C08C) forState:UIControlStateNormal];
        _editBtn.layer.borderWidth = 1;
        _editBtn.layer.borderColor = [KHEXRGB(0x44C08C) CGColor];
    }
    return _editBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    [self addSubview:self.biaotiLab];
    [self addSubview:self.tishiLab];
    [self addSubview:self.editBtn];
    
    [self.biaotiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(@16);
        make.width.equalTo(@60);
        make.height.equalTo(@14);
    }];
    
    [self.tishiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.biaotiLab.mas_right).offset(5);
        make.width.equalTo(@150);
        make.height.equalTo(@14);
    }];
    
    [self.editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(@(-16));
        make.height.equalTo(@30);
        make.width.equalTo(@40);
    }];
    
    @weakify(self);
    [[self.editBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.editBtnBlock) {
            self.editBtnBlock();
        }
    }];
}

@end
