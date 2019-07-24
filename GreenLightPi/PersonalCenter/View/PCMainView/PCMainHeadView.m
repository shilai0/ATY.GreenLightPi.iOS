//
//  PCMainHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/21.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMainHeadView.h"
#import "FileEntityModel.h"
#import "UIImageView+WebCache.h"
#import "PersonalCenterUserModel.h"

@interface PCMainHeadView ()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIButton *setBtn;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UIImageView *headPicImageView;
@property (nonatomic, strong) UIButton *telephoneBtn;
@property (nonatomic, strong) UIImageView *noLoginImageView;
@end

@implementation PCMainHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self fc_creatMainHeadViews];
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)fc_creatMainHeadViews {
    [self addSubview:self.backImageView];
    [self.backImageView addSubview:self.messageBtn];
    [self.backImageView addSubview:self.setBtn];
    [self.backImageView addSubview:self.headPicImageView];
    [self.headPicImageView addSubview:self.noLoginImageView];
    [self.backImageView addSubview:self.telephoneBtn];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@168);
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
    
    [self.headPicImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@64);
        make.width.height.equalTo(@56);
    }];
    
    [self.noLoginImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.headPicImageView);
        make.width.height.equalTo(@30);
    }];
    
    [self.telephoneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headPicImageView.mas_right).offset(8);
        make.centerY.equalTo(self.headPicImageView.mas_centerY);
        make.height.equalTo(@18);
    }];
    
    @weakify(self);
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
    
    [[self.telephoneBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(3, nil, nil);
        }
    }];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadImage)];
    [self.headPicImageView addGestureRecognizer:tapGesture];
}

- (void)clickHeadImage {
    if (self.atyClickActionBlock) {
        self.atyClickActionBlock(3, nil, nil);
    }
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        [_backImageView setImage:[UIImage imageNamed:@"PC_HeadBack"]];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
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
        XSViewBorderRadius(_headPicImageView, 28, 0, KHEXRGB(0xFFFFFF));
        _headPicImageView.userInteractionEnabled = YES;
        _headPicImageView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _headPicImageView;
}

- (UIImageView *)noLoginImageView {
    if (!_noLoginImageView) {
        _noLoginImageView = [[UIImageView alloc] init];
        _noLoginImageView.image = [UIImage imageNamed:@"PC_headDefault"];
    }
    return _noLoginImageView;
}

- (UIButton *)telephoneBtn {
    if (!_telephoneBtn) {
        _telephoneBtn = [[UIButton alloc] init];
        [_telephoneBtn setTitle:@"点击登录" forState:UIControlStateNormal];
        [_telephoneBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _telephoneBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    }
    return _telephoneBtn;
}

- (void)setModel:(PersonalCenterUserModel *)model {
    _model = model;
    NSString *headPath = nil;
    NSString *bindPath = nil;
    if ([_model.sex integerValue] == 1) {
        headPath = @"defaultImage_boy";
        bindPath = @"defaultImage_girl";
    } else {
        headPath = @"defaultImage_girl";
        bindPath = @"defaultImage_boy";
    }
    [self.headPicImageView sd_setImageWithURL:[NSURL URLWithString:_model.image.path] placeholderImage:[UIImage imageNamed:headPath]];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_PHONE]) {
        NSString *phoneStr = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_PHONE];
        [self.telephoneBtn setTitle:[NSString stringWithFormat:@"%@***%@",[phoneStr substringWithRange:NSMakeRange(0, 3)],[phoneStr substringWithRange:NSMakeRange(phoneStr.length - 3, 3)]] forState:UIControlStateNormal];
        self.noLoginImageView.hidden = YES;
    }
}

@end
