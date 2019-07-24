//
//  PCBussinessMessageCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCBussinessMessageCell.h"
#import "PCMessageModel.h"
#import "FileEntityModel.h"
#import "UIImageView+WebCache.h"

@interface PCBussinessMessageCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *coverImageView;

@end

@implementation PCBussinessMessageCell

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = KHEXRGB(0x333333);
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _nameLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHEXRGB(0xEBEBEB);
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font =FONT(17);
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = KHEXRGB(0x44C08C);
        _timeLabel.font = FONT(12);
    }
    return _timeLabel;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [UIImageView new];
        XSViewBorderRadius(_coverImageView, 6, 0, KHEXRGB(0x44C08C));
    }
    return _coverImageView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self pc_creatBussinessMessageCellViews];
    }
    return self;
}

- (void)pc_creatBussinessMessageCellViews {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.coverImageView];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@13);
        make.height.equalTo(@16);
        make.right.equalTo(@(-20));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(12);
        make.height.equalTo(@1);
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(16);
        make.right.equalTo(@(-16));
        make.width.height.equalTo(@80);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.top.equalTo(self.lineView.mas_bottom).offset(15);
        make.right.equalTo(self.coverImageView.mas_left).offset(-5);
        make.height.equalTo(@45);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(22);
        make.right.equalTo(self.coverImageView.mas_left).offset(-5);
        make.height.equalTo(@12);
    }];
}

- (void)setModel:(BusinessMessageModel *)model {
    _model = model;
    self.nameLabel.text = _model.storeName;
    self.titleLabel.text = _model.title;
    self.timeLabel.text = _model.ctime;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_model.imagePath] placeholderImage:[UIImage imageNamed:@"picture_default"]];
}

@end
