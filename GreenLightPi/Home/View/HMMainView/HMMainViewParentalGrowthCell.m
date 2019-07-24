//
//  HMMainViewParentalGrowthCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/20.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMainViewParentalGrowthCell.h"
#import "UIImageView+WebCache.h"
#import "HomeModel.h"

@interface HMMainViewParentalGrowthCell()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation HMMainViewParentalGrowthCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatHMMainViewParentalGrowthCellSubViews];
    }
    return self;
}

- (void)creatHMMainViewParentalGrowthCellSubViews {
    [self.contentView addSubview:self.backImageView];
    [self.backImageView addSubview:self.titleLabel];
    [self.contentView addSubview:self.bottomView];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(@12);
        make.height.equalTo(@(136*KHEIGHTSCALE));
        make.bottom.equalTo(@0);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.backImageView);
        make.height.equalTo(@18);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.backImageView.mas_bottom);
    }];
}

- (void)setHomeModel:(HomeModel *)homeModel {
    _homeModel = homeModel;
    [self.backImageView sd_setImageWithURL:[NSURL URLWithString:_homeModel.imagePath] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = _homeModel.title;
}

#pragma mark -- 懒加载
- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.contentMode = UIViewContentModeScaleAspectFill;
        XSViewBorderRadius(_backImageView, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"为孩子优秀的行为点赞";
        _titleLabel.textColor = KHEXRGB(0xFEFEFE);
        _titleLabel.font = [UIFont boldSystemFontOfSize:19];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = KHEXRGB(0xFFFFFF);
    }
    return _bottomView;
}

@end
