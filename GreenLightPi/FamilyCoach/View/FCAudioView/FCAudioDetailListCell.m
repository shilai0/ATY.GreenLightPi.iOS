//
//  FCAudioDetailListCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/12.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCAudioDetailListCell.h"
#import "FcCoursesModel.h"

@interface FCAudioDetailListCell ()
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *timeImageView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *itemLabel;
@property (nonatomic, strong) UIImageView *lockImageView;
@property (nonatomic, strong) UIButton *tipBtn;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation FCAudioDetailListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self fc_creatAudioDetailListCellViews];
    }
    return self;
}

- (void)fc_creatAudioDetailListCellViews {
    [self.contentView addSubview:self.playBtn];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeImageView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.itemLabel];
    [self.contentView addSubview:self.lockImageView];
    [self.contentView addSubview:self.tipBtn];
    [self.contentView addSubview:self.lineView];
    self.itemLabel.hidden = YES;
    self.lockImageView.hidden = YES;
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@21);
        make.top.equalTo(@18);
        make.width.height.equalTo(@24);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.playBtn.mas_right).offset(11);
        make.top.equalTo(@23);
        make.right.equalTo(@(-60));
        make.height.equalTo(@16);
    }];
    
    [self.timeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_left);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(9);
        make.height.width.equalTo(@16);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeImageView.mas_right).offset(5);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(13);
        make.height.equalTo(@10);
        make.width.equalTo(@100);
    }];
    
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@26);
        make.right.equalTo(@(-17));
        make.height.equalTo(@12);
        make.width.equalTo(@50);
    }];
    
    [self.lockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@26);
        make.right.equalTo(@(-17));
        make.height.width.equalTo(@16);
    }];
    
    [self.tipBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-17));
        make.top.equalTo(self.itemLabel.mas_bottom).offset(13);
        make.height.equalTo(@12);
        make.width.equalTo(@50);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
}

- (void)setDetailModel:(FcCoursesDetailModel *)detailModel {
    _detailModel = detailModel;
    self.titleLabel.text = _detailModel.title;
    NSString *second = [_detailModel.duration integerValue]%60 > 9 ? [NSString stringWithFormat:@"%ld",[_detailModel.duration integerValue]%60] : [NSString stringWithFormat:@"0%ld",[_detailModel.duration integerValue]%60];
    self.timeLabel.text = [NSString stringWithFormat:@"%ld:%@",[_detailModel.duration integerValue]/60,second];
    if (_detailModel.isLock == 1) {
        self.itemLabel.hidden = YES;
        self.lockImageView.hidden = NO;
    } else {
        self.itemLabel.hidden = NO;
        self.lockImageView.hidden = YES;
    }
    self.itemLabel.text = _detailModel.itemNum;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton new];
        [_playBtn setImage:[UIImage imageNamed:@"fc_playDetail"] forState:UIControlStateNormal];
        [_playBtn setImage:[UIImage imageNamed:@"fc_playing"] forState:UIControlStateSelected];
    }
    return _playBtn;
}

- (UILabel *)titleLabel  {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}

- (UIImageView *)timeImageView {
    if (!_timeImageView) {
        _timeImageView = [UIImageView new];
        _timeImageView.image = [UIImage imageNamed:@"fc_time"];
    }
    return _timeImageView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = KHEXRGB(0x999999);
        _timeLabel.font =  [UIFont systemFontOfSize:12];
    }
    return _timeLabel;
}

- (UILabel *)itemLabel {
    if (!_itemLabel) {
        _itemLabel = [UILabel new];
        _itemLabel.textColor = KHEXRGB(0x999999);
        _itemLabel.font = [UIFont systemFontOfSize:12];
        _itemLabel.textAlignment = NSTextAlignmentRight;
    }
    return _itemLabel;
}

- (UIButton *)tipBtn {
    if (!_tipBtn) {
        _tipBtn = [UIButton new];
        [_tipBtn setTitleColor:KHEXRGB(0x44C08C) forState:UIControlStateNormal];
    }
    return _tipBtn;
}

- (UIImageView *)lockImageView {
    if (!_lockImageView) {
        _lockImageView = [[UIImageView alloc] init];
        _lockImageView.image = [UIImage imageNamed:@"courseLock"];
    }
    return _lockImageView;
}

@end
