//
//  PCMessageCenterCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/27.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMessageCenterCell.h"

@interface PCMessageCenterCell ()
@property (nonatomic, strong) UIImageView *logImageView;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation PCMessageCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self pc_creatMessageCenterContentViews];
    }
    return self;
}

- (void)pc_creatMessageCenterContentViews {
    [self.contentView addSubview:self.logImageView];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.numLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.lineView];
    
    [self.logImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@12);
        make.width.height.equalTo(@40);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logImageView.mas_right).offset(12);
        make.top.equalTo(@14);
        make.height.equalTo(@14);
        make.width.equalTo(@65);
    }];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.typeLabel.mas_right).offset(6);
        make.top.equalTo(@14);
        make.height.width.equalTo(@14);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logImageView.mas_right).offset(12);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(10);
        make.height.equalTo(@12);
        make.right.equalTo(@(-16));
    }];
     
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@17);
        make.right.equalTo(@(-16));
        make.width.equalTo(@100);
        make.height.equalTo(@10);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@1);
    }];
}

- (UIImageView *)logImageView {
    if (!_logImageView) {
        _logImageView = [UIImageView new];
        _logImageView.image = [UIImage imageNamed:@"message_notification"];
//        _logImageView.backgroundColor = [UIColor greenColor];
        XSViewBorderRadius(_logImageView, 20, 0, KHEXRGB(0x555555));
    }
    return _logImageView;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [UILabel new];
        _typeLabel.text = @"系统通知";
        _typeLabel.textColor = KHEXRGB(0x333333);
        _typeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _typeLabel;
}

- (UILabel *)numLabel {
    if (!_numLabel) {
        _numLabel = [UILabel new];
        _numLabel.textColor = KHEXRGB(0xFFFFFF);
        _numLabel.font = FONT(10);
        _numLabel.backgroundColor = KHEXRGB(0xFF6560);
        _numLabel.textAlignment = NSTextAlignmentCenter;
        XSViewBorderRadius(_numLabel, 7, 0, KHEXRGB(0xFFFFFF));
    }
    return _numLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.text = @"这是一条系统消息";
        _contentLabel.textColor = KHEXRGB(0x999999);
        _contentLabel.font = [UIFont systemFontOfSize:12];
    }
    return _contentLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.text = @"2018-8-8";
        _timeLabel.textColor = KHEXRGB(0x999999);
        _timeLabel.font = [UIFont systemFontOfSize:10];
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

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    self.logImageView.image = [UIImage imageNamed:_dic[@"imageName"]];
    self.typeLabel.text = _dic[@"title"];
    self.timeLabel.text = _dic[@"time"];
    if ([dic[@"type"] isEqual:@2]) {
        self.timeLabel.hidden = YES;
        [self.typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@35);
        }];
    } else {
        self.timeLabel.hidden = NO;
    }
    
    if (StrEmpty(_dic[@"message"])) {
        self.contentLabel.text = @"暂无消息";
    } else {
        self.contentLabel.text = _dic[@"message"];
    }
    
    if ([_dic[@"messageCount"] integerValue] > 9) {
        self.numLabel.hidden = NO;
        [self.numLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.logImageView.mas_right).offset(12);
            make.top.equalTo(@14);
            make.height.equalTo(@14);
            make.width.equalTo(@21);
        }];
        XSViewBorderRadius(self.numLabel, 7, 0, KHEXRGB(0xFFFFFF));
        self.numLabel.text = [NSString stringWithFormat:@"%@",_dic[@"messageCount"]];
    } else if ([_dic[@"messageCount"] integerValue] < 9 && [_dic[@"messageCount"] integerValue] > 0) {
        self.numLabel.hidden = NO;
        self.numLabel.text = [NSString stringWithFormat:@"%@",_dic[@"messageCount"]];
    } else {
        self.numLabel.hidden = YES;
    }
}

@end
