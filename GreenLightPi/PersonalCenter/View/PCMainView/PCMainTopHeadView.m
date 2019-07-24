//
//  PCMainTopHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/11/29.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMainTopHeadView.h"
#import "UIImageView+WebCache.h"
#import "PersonalCenterUserModel.h"
#import "FileEntityModel.h"

@interface PCMainTopHeadView()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *headPicImageView;
@property (nonatomic, strong) UIButton *signInBtn;
@property (nonatomic, strong) UIButton *setBtn;
@property (nonatomic, strong) UIButton *messageBtn;
@end

@implementation PCMainTopHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatTopHeadViews];
    }
    return self;
}

- (void)creatTopHeadViews {
    [self addSubview:self.backImageView];
    [self.backImageView addSubview:self.headPicImageView];
    [self.backImageView addSubview:self.signInBtn];
    [self.backImageView addSubview:self.setBtn];
    [self.backImageView addSubview:self.messageBtn];
    self.signInBtn.hidden = YES;
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@66);
    }];
    
    [self.headPicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@28);
        make.width.height.equalTo(@30);
    }];
    
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.top.equalTo(@32);
        make.height.width.equalTo(@24);
    }];
    
    [self.setBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@24);
        make.right.equalTo(self.messageBtn.mas_left).offset(-20);
        make.centerY.equalTo(self.messageBtn.mas_centerY);
    }];
    
    [self.signInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@50);
        make.height.equalTo(@27);
        make.right.equalTo(self.setBtn.mas_left).offset(-20);
        make.centerY.equalTo(self.messageBtn.mas_centerY);
    }];
    
    @weakify(self);
    [[self.signInBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.setBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
    
    [[self.messageBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(2, nil, nil);
        }
    }];
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        [_backImageView setImage:[UIImage imageNamed:@"PC_topHead"]];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}

- (UIButton *)signInBtn {
    if (!_signInBtn) {
        _signInBtn = [[UIButton alloc] init];
        [_signInBtn setTitle:@"签到" forState:UIControlStateNormal];
        [_signInBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _signInBtn.titleLabel.font = [UIFont boldSystemFontOfSize:12];
        XSViewBorderRadius(_signInBtn, 12, 1, KHEXRGB(0xFFFFFF));
    }
    return _signInBtn;
}

- (UIButton *)messageBtn {
    if (!_messageBtn) {
        _messageBtn = [[UIButton alloc] init];
        [_messageBtn setImage:[UIImage imageNamed:@"PC_MessageCenter"] forState:UIControlStateNormal];
    }
    return _messageBtn;
}

- (UIButton *)setBtn {
    if (!_setBtn) {
        _setBtn = [[UIButton alloc] init];
        [_setBtn setBackgroundImage:[UIImage imageNamed:@"PC_Set"] forState:UIControlStateNormal];
    }
    return _setBtn;
}

- (UIImageView *)headPicImageView {
    if (!_headPicImageView) {
        _headPicImageView = [[UIImageView alloc] init];
        XSViewBorderRadius(_headPicImageView, 14, 0, KHEXRGB(0xFFFFFF));
        _headPicImageView.userInteractionEnabled = YES;
    }
    return _headPicImageView;
}

- (void)setModel:(PersonalCenterUserModel *)model {
    _model = model;
    NSString *headPath = nil;
    if ([_model.sex integerValue] == 1) {
        headPath = @"defaultImage_boy";
    } else {
        headPath = @"defaultImage_girl";
    }
    [self.headPicImageView sd_setImageWithURL:[NSURL URLWithString:_model.image.path] placeholderImage:[UIImage imageNamed:headPath]];
   
}

@end
