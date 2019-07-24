//
//  HMMoreParkCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/3.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMoreParkCell.h"
#import "UserUseLogModel.h"

@interface HMMoreParkCell()
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *tipView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@end

@implementation HMMoreParkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatHMMoreParkViews];
    }
    return self;
}

- (void)creatHMMoreParkViews {
    [self.contentView addSubview:self.shadowView];
    [self.shadowView addSubview:self.backView];
    [self.backView addSubview:self.tipView];
    [self.backView addSubview:self.nameLabel];
    [self.backView addSubview:self.timeLabel];
    [self.backView addSubview:self.dateLabel];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.right.equalTo(@(-16));
        make.bottom.equalTo(@(-3));
        make.height.equalTo(@100);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shadowView);
    }];
    
    [self.tipView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left);
        make.top.equalTo(@22);
        make.width.equalTo(@3);
        make.height.equalTo(@16);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.top.equalTo(@23);
        make.height.equalTo(@14);
        make.right.equalTo(@(-80));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(24);
        make.height.equalTo(@22);
        make.right.equalTo(@(-150));
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeLabel.mas_centerY);
        make.height.equalTo(@10);
        make.right.equalTo(@(-15));
    }];
    
}

- (void)setModel:(UseLogModel *)model {
    _model = model;
    _nameLabel.text = _model.boxName;
    _timeLabel.text = [NSString stringWithFormat:@"%ld小时%ld分钟",_model.useTime/3600,(_model.useTime%3600)/60];
    _dateLabel.text = _model.date;
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.layer.masksToBounds = NO;
        _shadowView.layer.shadowRadius = 8;
        _shadowView.layer.shadowOpacity = 1;
        _shadowView.layer.shadowColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(0,3);
    }
    return _shadowView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}

- (UIView *)tipView {
    if (!_tipView) {
        _tipView = [[UIView alloc] init];
        _tipView.backgroundColor = KHEXRGB(0x00D399);
    }
    return _tipView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"刘老根和许仙家的盒子";
        _nameLabel.textColor = KHEXRGB(0x999999);
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"42分钟";
        _timeLabel.textColor = KHEXRGB(0x333333);
        _timeLabel.font = [UIFont boldSystemFontOfSize:23];
    }
    return _timeLabel;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.text = @"2019-03-10";
        _dateLabel.textColor = KHEXRGB(0x999999);
        _dateLabel.font = [UIFont systemFontOfSize:13];
    }
    return _dateLabel;
}


@end
