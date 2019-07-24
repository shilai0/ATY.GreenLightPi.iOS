//
//  MyCashCouponUsedRecordCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/30.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "MyCashCouponUsedRecordCell.h"

@interface MyCashCouponUsedRecordCell()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *summaryLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@end

@implementation MyCashCouponUsedRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatUsedRecordCellViews];
        self.contentView.backgroundColor = KHEXRGB(0xF7F7F7);
    }
    return self;
}

- (void)creatUsedRecordCellViews {
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.coverImageView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.summaryLabel];
    [self.backView addSubview:self.valueLabel];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.right.equalTo(@(-16));
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.width.height.equalTo(@64);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(13);
        make.top.equalTo(self.backView.mas_top).offset(17);
        make.right.equalTo(self.backView.mas_right).offset(-16);
    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(13);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.backView.mas_right).offset(-16);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(13);
        make.top.equalTo(self.summaryLabel.mas_bottom).offset(14);
        make.right.equalTo(self.backView.mas_right).offset(-16);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-17);
    }];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.backgroundColor = KHEXRGB(0x44C08C);
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.text = @"我能表达自己全8册绘本 儿童 3-4- 6-7周岁正版幼儿园大大班情商...";
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)summaryLabel {
    if (!_summaryLabel) {
        _summaryLabel = [[UILabel alloc] init];
        _summaryLabel.textColor = KHEXRGB(0x999999);
        _summaryLabel.font = [UIFont systemFontOfSize:13];
        _summaryLabel.text = @"大开本 儿童语言训练 情绪管理 故事绘本";
    }
    return _summaryLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textColor = KHEXRGB(0xFF5753);
        _valueLabel.font = [UIFont boldSystemFontOfSize:12];
        _valueLabel.text = @"¥ 55";
    }
    return _valueLabel;
}

@end
