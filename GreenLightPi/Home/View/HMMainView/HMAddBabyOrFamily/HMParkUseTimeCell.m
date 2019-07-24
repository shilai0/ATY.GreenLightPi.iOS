//
//  HMParkUseTimeCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/3.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMParkUseTimeCell.h"
#import "UserUseLogModel.h"

@interface HMParkUseTimeCell()
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation HMParkUseTimeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = KHEXRGB(0xF7F7F7);
        [self creatParkUseTimeViews];
    }
    return self;
}

- (void)creatParkUseTimeViews {
    [self.contentView addSubview:self.shadowView];
    [self.shadowView addSubview:self.backView];
    [self.backView addSubview:self.timeLabel];
    [self.backView addSubview:self.titleLabel];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@3);
        make.right.equalTo(@(-16));
        make.bottom.equalTo(@(-3));
        make.height.equalTo(@115);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shadowView);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.top.equalTo(@30);
        make.right.equalTo(@(-17));
        make.height.equalTo(@23);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(16);
        make.right.equalTo(@(-17));
    }];
}

- (void)setModel:(UseLogModel *)model {
    _model = model;
    _timeLabel.text = [NSString stringWithFormat:@"%ld小时%ld分钟",_model.useTime/3600,_model.useTime%3600/60];
    NSString *str = nil;
    float useTime = (float)_model.useTime;
    float totalTime = (float)3600*24;
    float percent = useTime/totalTime;
    if (percent <= 0.04) {
        str = [NSString stringWithFormat:@"只有%.1f%%的时间在盒子上，请继续保持；",percent*100];
    } else if (percent > 0.04 && percent <= 0.125) {
        str = [NSString stringWithFormat:@"%.1f%%的时间在盒子上，记得多带孩子到户外活动；",percent*100];
    } else {
        str = [NSString stringWithFormat:@"请注意，孩子的%.1f%%的时间在盒子上，请家长做好监督与控制；",percent*100];
    }
    _titleLabel.text = str;
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
        _timeLabel.text = @"1小时36分钟";
        _timeLabel.textColor = KHEXRGB(0x333333);
        _timeLabel.font = [UIFont boldSystemFontOfSize:24];
    }
    return _timeLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"12%的时间用在盒子上，记得多带孩子去户外活动";
        _titleLabel.textColor = KHEXRGB(0x999999);
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

@end
