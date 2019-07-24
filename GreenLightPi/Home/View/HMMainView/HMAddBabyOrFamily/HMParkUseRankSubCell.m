//
//  HMParkUseRankSubCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/3.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMParkUseRankSubCell.h"
#import "UIImageView+WebCache.h"
#import "UserUseLogModel.h"

@interface HMParkUseRankSubCell()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *progressView;
@property (nonatomic, strong) UILabel *timeLabel;
@end

@implementation HMParkUseRankSubCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatHMParkUseRankSubViews];
    }
    return self;
}

- (void)creatHMParkUseRankSubViews {
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.progressView];
    [self.contentView addSubview:self.timeLabel];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.bottom.equalTo(@(-4));
        make.width.height.equalTo(@50);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(12);
        make.top.equalTo(@23);
        make.height.equalTo(@15);
        make.right.equalTo(@(-16));
    }];
    
    [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(12);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(18);
        make.height.equalTo(@4);
        make.width.equalTo(@(KSCREEN_WIDTH - 200));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.progressView.mas_right).offset(9);
        make.centerY.equalTo(self.progressView.mas_centerY);
        make.height.equalTo(@13);
        make.width.equalTo(@50);
    }];
}

- (void)setDetailModel:(UseDetailModel *)detailModel {
    _detailModel = detailModel;
    [_coverImageView sd_setImageWithURL:[NSURL URLWithString:_detailModel.imagePath]];
    _nameLabel.text = _detailModel.name;
    _timeLabel.text = [NSString stringWithFormat:@"%ld分钟",_detailModel.duration/60];
    [self.progressView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@((KSCREEN_WIDTH - 200)*(detailModel.duration)/(detailModel.longDuration)));
    }];
}

#pragma mark -- 懒加载
- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.backgroundColor = KHEXRGB(0x999999);
        XSViewBorderRadius(_coverImageView, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _coverImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"贝乐虎儿歌";
        _nameLabel.textColor = KHEXRGB(0x333333);
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _nameLabel;
}

- (UIView *)progressView {
    if (!_progressView) {
        _progressView = [[UIView alloc] init];
        _progressView.backgroundColor = KHEXRGB(0xE6E6E6);
        XSViewBorderRadius(_progressView, 2, 0, KHEXRGB(0xE6E6E6));
    }
    return _progressView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"50分钟";
        _timeLabel.textColor = KHEXRGB(0x999999);
        _timeLabel.font = [UIFont systemFontOfSize:14];
    }
    return _timeLabel;
}

@end
