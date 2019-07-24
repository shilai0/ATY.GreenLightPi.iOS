//
//  FCCourseItemCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/21.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCCourseItemCell.h"
#import "FcCoursesModel.h"

@interface FCCourseItemCell();
@property (nonatomic, strong) UIImageView *logolImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *statusBtn;
@property (nonatomic, strong) UIImageView *lockImageView;
@end

@implementation FCCourseItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self fc_creatCourseItemViews];
    }
    return self;
}

- (void)fc_creatCourseItemViews {
    [self.contentView addSubview:self.logolImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.statusBtn];
    [self.contentView addSubview:self.lockImageView];
    self.statusBtn.hidden = YES;
    self.lockImageView.hidden = YES;
    
    [self.logolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@28);
        make.width.height.equalTo(@16);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.logolImageView.mas_right).offset(9);
        make.top.equalTo(@28);
        make.height.equalTo(@14);
        make.right.equalTo(@(-110));
    }];
    
    [self.statusBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@28);
        make.right.equalTo(@(-15));
        make.width.equalTo(@100);
        make.height.equalTo(@14);
    }];
    
    [self.lockImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@28);
        make.right.equalTo(@(-15));
        make.width.height.equalTo(@12);
    }];
}

- (void)setCourseDetailModel:(FcCoursesDetailModel *)courseDetailModel {
    _courseDetailModel = courseDetailModel;
    self.titleLabel.text = _courseDetailModel.title;
    if ([self.courseModel.isPurchase integerValue] == 1 || [_courseModel.consumptionType isEqualToString:@"free"]) {
        if ([_courseDetailModel.progress floatValue] == 0) {
            [_statusBtn setTitle:_courseDetailModel.progressShow forState:UIControlStateNormal];
            [_statusBtn setTitleColor:KHEXRGB(0x44C08C) forState:UIControlStateNormal];
        } else {
            CGFloat progress = [_courseDetailModel.progress floatValue]*100;
            [_statusBtn setTitle:[NSString stringWithFormat:@"已学%.1f%%",progress] forState:UIControlStateNormal];
            [_statusBtn setTitleColor:KHEXRGB(0xFFA430) forState:UIControlStateNormal];
            if ([_courseDetailModel.progress integerValue] == 1) {
                [_statusBtn setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
                [_statusBtn setTitle:@"已学完" forState:UIControlStateNormal];
                self.titleLabel.textColor = KHEXRGB(0x999999);
            }
        }
    } else {
        [_statusBtn setImage:[UIImage imageNamed:@"fc_lock"] forState:UIControlStateNormal];
    }
    
    if (_courseDetailModel.isCurrentPlay) {
        self.titleLabel.textColor = KHEXRGB(0x44C08C);
        self.logolImageView.image = [UIImage imageNamed:@"fc_playAll"];
        [_statusBtn setTitleColor:KHEXRGB(0x44C08C) forState:UIControlStateNormal];
        [_statusBtn setTitle:@"正在学习" forState:UIControlStateNormal];
    } else {
        self.titleLabel.textColor = KHEXRGB(0x333333);
        self.logolImageView.image = [UIImage imageNamed:@"fc_itemPlay"];
    }
    
    if (_courseDetailModel.isLock == 1) {
        self.statusBtn.hidden = YES;
        self.lockImageView.hidden = NO;
    } else {
        self.statusBtn.hidden = NO;
        self.lockImageView.hidden = YES;
    }
    
}

- (void)setCourseModel:(FcCoursesModel *)courseModel {
    _courseModel = courseModel;
}


- (UIImageView *)lockImageView {
    if (!_lockImageView) {
        _lockImageView = [[UIImageView alloc] init];
        _lockImageView.image = [UIImage imageNamed:@"courseLock"];
    }
    return _lockImageView;
}

- (UIImageView *)logolImageView {
    if (!_logolImageView) {
        _logolImageView = [UIImageView new];
        _logolImageView.image = [UIImage imageNamed:@"fc_itemPlay"];
    }
    return _logolImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UIButton *)statusBtn {
    if (!_statusBtn) {
        _statusBtn = [UIButton new];
        [_statusBtn setTitleColor:KHEXRGB(0x44C08C) forState:UIControlStateNormal];
        _statusBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _statusBtn;
}

@end
