//
//  HMKnowledgeHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/29.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMKnowledgeHeadView.h"

@interface HMKnowledgeHeadView ()
@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UIImageView *titleImageView;
@property (nonatomic, strong) UIButton *searchBtn;
@end

@implementation HMKnowledgeHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatKnowladgeHeadViews];
        self.backgroundColor = KHEXRGB(0xFFFFFF);
    }
    return self;
}

- (void)creatKnowladgeHeadViews {
    [self addSubview:self.returnBtn];
    [self addSubview:self.titleImageView];
    [self addSubview:self.searchBtn];
    
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@(31+KTopBarSafeHeight));
        make.width.height.equalTo(@28);
    }];
    
    [self.titleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@(36+KTopBarSafeHeight));
        make.height.equalTo(@19);
        make.width.equalTo(@64);
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(31+KTopBarSafeHeight));
        make.right.equalTo(@(-16));
        make.width.height.equalTo(@28);
    }];
    
    @weakify(self);
    [[self.returnBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
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

#pragma mark -- 懒加载
- (UIButton *)returnBtn {
    if (!_returnBtn) {
        _returnBtn = [[UIButton alloc] init];
        [_returnBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    }
    return _returnBtn;
}

- (UIImageView *)titleImageView {
    if (!_titleImageView) {
        _titleImageView = [[UIImageView alloc] init];
        _titleImageView.image = [UIImage imageNamed:@"knowladge"];
    }
    return _titleImageView;
}

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    }
    return _searchBtn;
}

@end
