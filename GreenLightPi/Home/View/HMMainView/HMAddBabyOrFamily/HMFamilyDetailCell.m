//
//  HMFamilyDetailCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/10.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMFamilyDetailCell.h"
#import "UIImageView+WebCache.h"
#import "FamilyApiModel.h"

@interface HMFamilyDetailCell()
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *selectedImageView;
@end

@implementation HMFamilyDetailCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatFamilyDetailCellViews];
    }
    return self;
}

- (void)creatFamilyDetailCellViews {
    [self addSubview:self.headImageView];
    [self addSubview:self.selectedImageView];
    [self addSubview:self.nameLabel];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.height.width.equalTo(@68);
    }];
    
    [self.selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.headImageView.mas_bottom);
        make.right.equalTo(self.headImageView.mas_right).offset(-4);
        make.width.height.equalTo(@18);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headImageView);
        make.top.equalTo(self.headImageView.mas_bottom).offset(8);
        make.height.equalTo(@14);
    }];
}

- (void)setMemberModel:(FamilyMemberApiModel *)memberModel {
    _memberModel = memberModel;
    if (_memberModel.imagePath) {
        self.selectedImageView.hidden = NO;
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_memberModel.imagePath] placeholderImage:[UIImage imageNamed:@"parentCenter"]];
    } else {
        self.selectedImageView.hidden = YES;
    }
    self.nameLabel.text = _memberModel.relationRemark;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"addFamilyBtn"];
        XSViewBorderRadius(_headImageView, 34, 0, KHEXRGB(0xFFFFFF));
    }
    return _headImageView;
}

- (UIImageView *)selectedImageView {
    if (!_selectedImageView) {
        _selectedImageView = [[UIImageView alloc] init];
        _selectedImageView.image = [UIImage imageNamed:@"memberSelected"];
    }
    return _selectedImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = KHEXRGB(0x333333);
        _nameLabel.font = [UIFont boldSystemFontOfSize:14];
        _nameLabel.text = @"妈妈";
    }
    return _nameLabel;
}

@end
