//
//  HMMainSearchView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/19.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMainSearchView.h"

@interface HMMainSearchView ()
@property (nonatomic, strong) UIImageView *searchImageView;
@property (nonatomic, strong) UILabel *searchLabel;
@property (nonatomic, strong) UIButton *babyHeadBtn;
@end

@implementation HMMainSearchView

- (UIButton *)babyHeadBtn {
    if (!_babyHeadBtn) {
        _babyHeadBtn = [[UIButton alloc] init];
        [_babyHeadBtn setImage:[UIImage imageNamed:@"defaultBabyImage"] forState:UIControlStateNormal];
        [_babyHeadBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        XSViewBorderRadius(_babyHeadBtn, 16, 0, KHEXRGB(0xFFFFFF));
    }
    return _babyHeadBtn;
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [[UIButton alloc] init];
        _searchBtn.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_searchBtn, 16, 0, KHEXRGB(0xFFFFFF));
    }
    return _searchBtn;
}

- (UIImageView *)searchImageView {
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc] init];
        _searchImageView.image = [UIImage imageNamed:@"home_search"];
    }
    return _searchImageView;
}

- (UILabel *)searchLabel {
    if (!_searchLabel) {
        _searchLabel = [[UILabel alloc] init];
        _searchLabel.text = @"搜索";
        _searchLabel.textColor = KHEXRGB(0x999999);
        _searchLabel.font = [UIFont systemFontOfSize:13];
    }
    return _searchLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatSearchSubViews];
    }
    return self;
}

- (void)creatSearchSubViews {
    [self addSubview:self.babyHeadBtn];
    [self addSubview:self.searchBtn];
    [self.searchBtn addSubview:self.searchImageView];
    [self.searchBtn addSubview:self.searchLabel];
    
    [self.babyHeadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@(31+KTopBarSafeHeight));
        make.width.height.equalTo(@32);
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.babyHeadBtn.mas_right).offset(16);
        make.centerY.equalTo(self.babyHeadBtn.mas_centerY);
        make.height.equalTo(@32);
        make.right.equalTo(@(-16));
    }];
    
    [self.searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchBtn.mas_left).offset(8);
        make.centerY.equalTo(self.searchBtn.mas_centerY);
        make.width.height.equalTo(@16);
    }];
    
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchImageView.mas_right).offset(8);
        make.centerY.equalTo(self.searchBtn.mas_centerY);
        make.height.equalTo(@12);
        make.width.equalTo(@50);
    }];
    
    @weakify(self);
    [[self.babyHeadBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
}

@end
