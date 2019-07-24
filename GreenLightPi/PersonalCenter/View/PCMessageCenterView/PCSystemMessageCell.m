//
//  PCSystemMessageCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCSystemMessageCell.h"
#import "PCMessageModel.h"

@interface PCSystemMessageCell()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *rightIamgeView;
@end

@implementation PCSystemMessageCell

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 6, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.textColor = KHEXRGB(0x333333);
    }
    return _titleLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = KHEXRGB(0x999999);
        _timeLabel.font= FONT(10);
        _timeLabel.textAlignment = NSTextAlignmentRight;
    }
    return _timeLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHEXRGB(0xEBEBEB);
    }
    return _lineView;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = KHEXRGB(0x646464);
        _contentLabel.font = FONT(14);
    }
    return _contentLabel;
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
        self.contentView.backgroundColor = KHEXRGB(0xF7F7F7);
        [self pc_creatSystemMessageCellViews];
    }
    return self;
}

- (void)pc_creatSystemMessageCellViews {
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.timeLabel];
    [self.backView addSubview:self.lineView];
    [self.backView addSubview:self.contentLabel];
    [self.backView addSubview:self.rightIamgeView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(13);
        make.top.equalTo(self.backView.mas_top).offset(17);
        make.right.equalTo(self.backView.mas_right).offset(-70);
        make.height.equalTo(@15);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(19);
        make.right.equalTo(self.backView.mas_right).offset(-7);
        make.width.equalTo(@63);
        make.height.equalTo(@8);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(11);
        make.left.right.equalTo(self.backView);
        make.height.equalTo(@1);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.right.equalTo(self.backView.mas_right).offset(-35);
        make.top.equalTo(self.lineView.mas_bottom).offset(14);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-17);
    }];
    
    [self.rightIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentLabel.mas_centerY);
        make.right.equalTo(self.backView.mas_right).offset(-7);
        make.width.height.equalTo(@16);
    }];
    
}

- (void)setModel:(SysMessageModel *)model {
    _model = model;
    self.titleLabel.text = _model.title;
    if (_model.ctime.length > 9) {
        self.timeLabel.text = [_model.ctime substringWithRange:NSMakeRange(0, 10)];
    } else {
        self.timeLabel.text = _model.ctime;
    }
    self.contentLabel.text = _model.messageContent;
}

@end
