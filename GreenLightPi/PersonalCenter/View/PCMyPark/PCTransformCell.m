//
//  PCTransformCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/12.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCTransformCell.h"
#import "UIImageView+WebCache.h"
#import "FamilyApiModel.h"

@interface PCTransformCell()
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation PCTransformCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatTransformParkViews];
    }
    return self;
}

- (void)creatTransformParkViews {
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.lineView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.width.height.equalTo(@40);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(14);
        make.centerY.equalTo(self.headImageView.mas_centerY);
        make.height.equalTo(@16);
        make.right.equalTo(@(-16));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (void)setMemberModel:(FamilyMemberApiModel *)memberModel {
    _memberModel = memberModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_memberModel.imagePath]];
    self.nameLabel.text = _memberModel.relationRemark;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.backgroundColor = KHEXRGB(0xF7F7F7);
        XSViewBorderRadius(_headImageView, 4, 0, KHEXRGB(0xFFFFFF));
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = KHEXRGB(0x333333);
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.text = @"名字";
    }
    return _nameLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}


@end
