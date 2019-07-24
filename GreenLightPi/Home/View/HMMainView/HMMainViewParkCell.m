//
//  HMMainViewParkCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/20.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMainViewParkCell.h"
#import "UserUseLogModel.h"

@interface HMMainViewParkCell ()
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation HMMainViewParkCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatHMMainViewParkCellSubviews];
    }
    return self;
}

- (void)creatHMMainViewParkCellSubviews {
    [self.contentView addSubview:self.shadowView];
    [self.shadowView addSubview:self.backView];
    [self.backView addSubview:self.timeLabel];
    [self.backView addSubview:self.lineView];
    [self.backView addSubview:self.dateLabel];
    [self.backView addSubview:self.nameLabel];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(@3);
        make.bottom.equalTo(@(-16));
        make.height.equalTo(@134);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shadowView);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).offset(32);
        make.centerX.equalTo(self.backView.mas_centerX);
        make.height.equalTo(@21);
        make.width.equalTo(@150);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(27);
        make.height.equalTo(@1);
    }];
    
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-19);
        make.width.equalTo(@100);
        make.height.equalTo(@10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.bottom.equalTo(self.backView.mas_bottom).offset(-18);
        make.height.equalTo(@13);
    }];
}
    
- (void)setUseParkModel:(UseLogModel *)useParkModel {
    _useParkModel = useParkModel;
    NSString *defaultStr = [NSString stringWithFormat:@"%ld小时%ld分钟",_useParkModel.useTime/3600,(_useParkModel.useTime%3600)/60];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:defaultStr];
    //设置尺寸
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:[defaultStr rangeOfString:@"小时"]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:14] range:[defaultStr rangeOfString:@"分钟"]];
    _timeLabel.attributedText = attributedString;
    _dateLabel.text = _useParkModel.date;
    _nameLabel.text = _useParkModel.boxName;
}

#pragma mark -- 懒加载
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

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.textColor = KHEXRGB(0x00D399);
        _timeLabel.font = [UIFont boldSystemFontOfSize:28];
   }
    return _timeLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = KHEXRGB(0x999999);
        _dateLabel.font = [UIFont boldSystemFontOfSize:13];
        _dateLabel.text = @"2013-3-20";
    }
    return _dateLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = KHEXRGB(0x999999);
        _nameLabel.font = [UIFont boldSystemFontOfSize:13];
        _nameLabel.textAlignment = NSTextAlignmentRight;
    }
    return _nameLabel;
}

@end
