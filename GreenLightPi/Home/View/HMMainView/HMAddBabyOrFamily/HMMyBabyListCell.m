//
//  HMMyBabyListCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/1.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMyBabyListCell.h"
#import "BabyModel.h"
#import "UIImageView+WebCache.h"
#import "FileEntityModel.h"

@interface HMMyBabyListCell()
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UIImageView *sexImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *rightImageView;
@end

@implementation HMMyBabyListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatMyBabyListCellViews];
    }
    return self;
}

- (void)creatMyBabyListCellViews {
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.sexImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.ageLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.rightImageView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.top.equalTo(@20);
        make.width.height.equalTo(@48);
        make.bottom.equalTo(@(-20));
    }];
    
    [self.sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headImageView.mas_right);
        make.bottom.equalTo(self.headImageView.mas_bottom);
        make.width.height.equalTo(@16);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(11);
        make.top.equalTo(@26);
        make.height.equalTo(@16);
        make.right.equalTo(self.contentView).offset(-80);
    }];
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(11);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(9);
        make.height.equalTo(@14);
        make.right.equalTo(self.contentView).offset(-80);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-16);
        make.width.equalTo(@7);
        make.height.equalTo(@12);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.height.equalTo(@1);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (void)setBabyModel:(BabyModel *)babyModel {
    _babyModel = babyModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_babyModel.path] placeholderImage:[UIImage imageNamed:@"kid"]];
    if (_babyModel.sex == 0) {
        self.sexImageView.image = [UIImage imageNamed:@"girl"];
    } else {
        self.sexImageView.image = [UIImage imageNamed:@"boy"];
    }
    self.nameLabel.text = _babyModel.nikename;
    self.ageLabel.text = _babyModel.age;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [UIImageView new];
        XSViewBorderRadius(_headImageView, 24, 0, KHEXRGB(0xFFFFFF));
    }
    return _headImageView;
}

- (UIImageView *)sexImageView {
    if (!_sexImageView) {
        _sexImageView = [UIImageView new];
    }
    return _sexImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = KHEXRGB(0x333333);
        _nameLabel.font = [UIFont boldSystemFontOfSize:17];
    }
    return _nameLabel;
}

- (UILabel *)ageLabel {
    if (!_ageLabel) {
        _ageLabel = [[UILabel alloc] init];
        _ageLabel.textColor = KHEXRGB(0x999999);
        _ageLabel.font = [UIFont systemFontOfSize:14];
    }
    return _ageLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"hm_right"];
    }
    return _rightImageView;
}

@end
