//
//  PCUserMessageReviewforwardCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCUserMessageReviewforwardCell.h"
#import "PCMessageModel.h"
#import "FileEntityModel.h"
#import "UIImageView+WebCache.h"

@interface PCUserMessageReviewforwardCell ()
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation PCUserMessageReviewforwardCell

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [UIImageView new];
        XSViewBorderRadius(_headImageView, 20, 0, KHEXRGB(0xFFFFFF));
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = KHEXRGB(0x333333);
        _nameLabel.font = FONT(15);
    }
    return _nameLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = KHEXRGB(0x333333);
        _contentLabel.font = FONT(15);
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = KHEXRGB(0x999999);
        _timeLabel.font = FONT(10);
    }
    return _timeLabel;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [UIImageView new];
        XSViewBorderRadius(_coverImageView, 6, 0, KHEXRGB(0x999999));
    }
    return _coverImageView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHEXRGB(0xEBEBEB);
    }
    return _lineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self pc_creatLikeCellViews];
    }
    return self;
}

- (void)pc_creatLikeCellViews {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.lineView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.left.equalTo(@16);
        make.width.height.equalTo(@40);
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.width.height.equalTo(@60);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@13);
        make.left.equalTo(self.headImageView.mas_right).offset(11);
        make.right.equalTo(self.coverImageView.mas_left).offset(-5);
        make.height.equalTo(@14);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_left).offset(11);
        make.height.equalTo(@8);
        make.right.equalTo(self.coverImageView.mas_left).offset(-5);
        make.bottom.equalTo(self.lineView.mas_top).offset(-12);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(11);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(7);
        make.right.equalTo(self.coverImageView.mas_left).offset(-5);
        make.bottom.equalTo(self.timeLabel.mas_top).offset(-14);
    }];
}

- (void)setModel:(UserMessageModel *)model {
    _model = model;
    self.nameLabel.text = _model.name;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_model.imagePath] placeholderImage:[UIImage imageNamed:@"kid"]];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_model.contentImagePath] placeholderImage:[UIImage imageNamed:@"picture_default"]];
    self.timeLabel.text = _model.time;
    self.contentLabel.text = _model.title;
//    _contentLabel.text = @"dbfgisldhfgi";
}

@end
