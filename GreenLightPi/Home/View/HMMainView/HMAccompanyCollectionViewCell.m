//
//  HMAccompanyCollectionViewCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/20.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMAccompanyCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "HomeModel.h"

@interface HMAccompanyCollectionViewCell()
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *logolImageView;
@property (nonatomic, strong) UIImageView *typeImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation HMAccompanyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatHMAccompanyCollectionViewCellSubViews];
    }
    return self;
}

- (void)creatHMAccompanyCollectionViewCellSubViews {
    [self.contentView addSubview:self.shadowView];
    [self.shadowView addSubview:self.backView];
    [self.backView addSubview:self.logolImageView];
    [self.backView addSubview:self.typeImageView];
    [self.backView addSubview:self.titleLabel];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@16);
        make.bottom.equalTo(@(-16));
        make.left.right.equalTo(self.contentView);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shadowView);
    }];
    
    [self.logolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.right.equalTo(self.backView.mas_right).offset(-16);
        make.height.equalTo(@(134*KHEIGHTSCALE));
    }];
    
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@11);
        make.width.equalTo(@(45*KHEIGHTSCALE));
        make.height.equalTo(@(20*KHEIGHTSCALE));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@19);
        make.right.equalTo(@(-22));
        make.top.equalTo(self.logolImageView.mas_bottom).offset(13);
    }];
}

- (void)setHomeModel:(HomeModel *)homeModel {
    _homeModel = homeModel;
    [self.logolImageView sd_setImageWithURL:[NSURL URLWithString:_homeModel.imagePath] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = _homeModel.title;
    if (_homeModel.category == 1) {
        self.typeImageView.image = [UIImage imageNamed:@"duba"];
    } else if (_homeModel.category == 2) {
        self.typeImageView.image = [UIImage imageNamed:@"wanba"];
    }
}

#pragma mark -- 懒加载
- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.layer.masksToBounds = NO;
        _shadowView.layer.shadowRadius = 8;
        _shadowView.layer.shadowOpacity = 1;
        _shadowView.layer.shadowOffset = CGSizeZero;
        _shadowView.layer.shadowColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(3,3);
    }
    return _shadowView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}

- (UIImageView *)logolImageView {
    if (!_logolImageView) {
        _logolImageView = [[UIImageView alloc] init];
        _logolImageView.image = [UIImage imageNamed:@"banner"];
        XSViewBorderRadius(_logolImageView, 4, 0, KHEXRGB(0xFFFFFF));
    }
    return _logolImageView;
}

- (UIImageView *)typeImageView {
    if (!_typeImageView) {
        _typeImageView = [[UIImageView alloc] init];
        _typeImageView.image = [UIImage imageNamed:@"duba"];
    }
    return _typeImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.numberOfLines = 2;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
