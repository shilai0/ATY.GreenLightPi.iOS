//
//  BabyListCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/14.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BabyListCell.h"
#import "UIImageView+WebCache.h"

@interface BabyListCell()
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@property (nonatomic, strong) UIImageView *rightIamgeView;
@end

@implementation BabyListCell

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        XSViewBorderRadius(_headImageView, 20, 0, KHEXRGB(0xFFFFFF));
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = KHEXRGB(0x333333);
        _nameLabel.font = FONT(16);
    }
    return _nameLabel;
}

- (UILabel *)ageLabel {
    if (!_ageLabel) {
        _ageLabel = [UILabel new];
        _ageLabel.textColor = KHEXRGB(0x999999);
        _ageLabel.font = FONT(14);
    }
    return _ageLabel;
}

- (UIImageView *)rightIamgeView {
    if (!_rightIamgeView) {
        _rightIamgeView = [UIImageView new];
        _rightIamgeView.image = [UIImage imageNamed:@"PC_Right"];
    }
    return _rightIamgeView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self pc_creatBabyListCellViews];
    }
    return self;
}

- (void)pc_creatBabyListCellViews {
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.ageLabel];
    [self.contentView addSubview:self.rightIamgeView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.top.equalTo(@18);
        make.height.width.equalTo(@40);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@21);
        make.left.equalTo(self.headImageView.mas_right).offset(11);
        make.height.equalTo(@15);
        make.right.equalTo(@(-40));
    }];
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(11);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
        make.height.equalTo(@13);
        make.right.equalTo(@(-40));
    }];
    
    [self.rightIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(@(-16));
        make.height.width.equalTo(@16);
    }];
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:[_dic[@"imagePath"] firstObject]] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = _dic[@"nikename"];
    self.ageLabel.text = _dic[@"birthday"];
}

@end
