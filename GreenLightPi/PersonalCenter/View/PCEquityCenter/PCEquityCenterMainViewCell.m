//
//  PCEquityCenterMainViewCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/8.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCEquityCenterMainViewCell.h"

@interface PCEquityCenterMainViewCell()
@property (nonatomic, strong) UIImageView *typeLogolImageView;
@property (nonatomic, strong) UILabel *typeNameLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@end

@implementation PCEquityCenterMainViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatEquityCenterMainViewCellSubViews];
    }
    return self;
}

- (void)creatEquityCenterMainViewCellSubViews {
    [self.contentView addSubview:self.typeLogolImageView];
    [self.contentView addSubview:self.typeNameLabel];
    [self.contentView addSubview:self.countLabel];
    [self.contentView addSubview:self.rightImageView];
    
    [self.typeLogolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@5);
        make.bottom.equalTo(@(-5));
        make.width.height.equalTo(@23);
    }];
    
    [self.typeNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLogolImageView.mas_right).offset(6);
        make.centerY.equalTo(self.typeLogolImageView.mas_centerY);
        make.height.equalTo(@13);
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-15));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@13);
        make.width.equalTo(@10);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.rightImageView.mas_left).offset(-13);
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.height.equalTo(@11);
    }];
    
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    self.typeLogolImageView.image = [UIImage imageNamed:_dataDic[@"imageName"]];
    self.typeNameLabel.text = _dataDic[@"title"];
    NSString *teamCountStr = _dataDic[@"value"];
    if (teamCountStr.length > 0) {
        self.countLabel.text = [NSString stringWithFormat:@"%@人",_dataDic[@"value"]];
    }
}

- (UIImageView *)typeLogolImageView {
    if (!_typeLogolImageView) {
        _typeLogolImageView = [[UIImageView alloc] init];
        _typeLogolImageView.image = [UIImage imageNamed:@"myTeam"];
    }
    return _typeLogolImageView;
}

- (UILabel *)typeNameLabel {
    if (!_typeNameLabel) {
        _typeNameLabel = [[UILabel alloc] init];
        _typeNameLabel.textColor = KHEXRGB(0x1A1A1A);
        _typeNameLabel.font = [UIFont systemFontOfSize:14];
        _typeNameLabel.alpha = 0.8;
        _typeNameLabel.text = @"我的团队";
    }
    return _typeNameLabel;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [[UILabel alloc] init];
        _countLabel.textColor = KHEXRGB(0x939393);
        _countLabel.alpha = 0.8;
        _countLabel.font = [UIFont systemFontOfSize:11];
        _countLabel.textAlignment = NSTextAlignmentRight;
    }
    return _countLabel;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"wf_right"];
    }
    return _rightImageView;
}

@end

