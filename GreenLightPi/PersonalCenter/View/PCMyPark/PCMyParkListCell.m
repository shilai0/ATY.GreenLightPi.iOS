//
//  PCMyParkListCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/11.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCMyParkListCell.h"

@interface PCMyParkListCell()
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@end

@implementation PCMyParkListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatMyParkListCellViews];
    }
    return self;
}

- (void)creatMyParkListCellViews {
    [self.contentView addSubview:self.tipImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.rightImageView];
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@20);
        make.bottom.equalTo(@(-20));
        make.height.width.equalTo(@24);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.tipImageView.mas_centerY);
        make.left.equalTo(self.tipImageView.mas_right).offset(11);
        make.height.equalTo(@11);
        make.right.equalTo(@(-100));
    }];
    
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel.mas_centerY);
        make.right.equalTo(@(-16));
        make.width.height.equalTo(@16);
    }];
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    self.titleLabel.text = _dataDic[@"title"];
    self.tipImageView.image = [UIImage imageNamed:_dataDic[@"imageName"]];
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] init];
    }
    return _tipImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = [UIImage imageNamed:@"PC_Right"];
    }
    return _rightImageView;
}

@end
