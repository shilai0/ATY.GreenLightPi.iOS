//
//  HMMainViewPatentingSubView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/20.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMainViewPatentingSubView.h"
#import "UIImageView+WebCache.h"
#import "HomeModel.h"

@implementation HMMainViewPatentingSubView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatHMMainViewPatentingSubView];
    }
    return self;
}

- (void)creatHMMainViewPatentingSubView {
    [self addSubview:self.logolImageView];
    [self addSubview:self.titleLabel];
    
    [self.logolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self);
        make.width.height.equalTo(@48);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.logolImageView.mas_centerY);
        make.left.equalTo(self.logolImageView.mas_right).offset(16);
        make.right.equalTo(@(-28));
        make.height.equalTo(@36);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self addGestureRecognizer:tap];
    
}

- (void)setHomeModel:(HomeModel *)homeModel {
    _homeModel = homeModel;
    [self.logolImageView sd_setImageWithURL:[NSURL URLWithString:_homeModel.imagePath] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = _homeModel.title;
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    if (self.atyClickActionBlock) {
        self.atyClickActionBlock(0, nil, nil);
    }
}


#pragma mark -- 懒加载
- (UIImageView *)logolImageView {
    if (!_logolImageView) {
        _logolImageView = [[UIImageView alloc] init];
        _logolImageView.image = [UIImage imageNamed:@"story_maker_tiezhi1"];
        _logolImageView.contentMode = UIViewContentModeScaleAspectFill;
        XSViewBorderRadius(_logolImageView, 4, 0, KHEXRGB(0xFFFFFF));
    }
    return _logolImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"吓唬式教育 是管教还是伤害？";
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

@end
