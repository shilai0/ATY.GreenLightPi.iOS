//
//  PCUserMessageFollowCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCUserMessageFollowCell.h"
#import "PCMessageModel.h"
#import "FileEntityModel.h"
#import "UIImageView+WebCache.h"

@interface PCUserMessageFollowCell ()
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *followButton;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation PCUserMessageFollowCell

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

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [UILabel new];
        _timeLabel.textColor = KHEXRGB(0x999999);
        _timeLabel.font = FONT(10);
    }
    return _timeLabel;
}

- (UIButton *)followButton {
    if (!_followButton) {
        _followButton = [UIButton new];
        [_followButton setTitle:@"关 注" forState:UIControlStateNormal];
        [_followButton setTitleColor:KHEXRGB(0xFEFEFE) forState:UIControlStateNormal];
        _followButton.titleLabel.font = FONT(12);
        [_followButton setBackgroundColor:KHEXRGB(0x44C08C)];
        XSViewBorderRadius(_followButton, 6, 0, KHEXRGB(0x44C08C));
    }
    return _followButton;
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
    [self.contentView addSubview:self.followButton];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.lineView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.left.equalTo(@16);
        make.width.height.equalTo(@40);
    }];
    
    [self.followButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.width.height.equalTo(@50);
        make.height.equalTo(@24);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@13);
        make.left.equalTo(self.headImageView.mas_right).offset(11);
        make.right.equalTo(self.followButton.mas_left).offset(-5);
        make.height.equalTo(@14);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(11);
        make.height.equalTo(@8);
        make.right.equalTo(self.followButton.mas_left).offset(-5);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.headImageView.mas_bottom).offset(12);
        make.height.equalTo(@1);
    }];
}

- (void)setModel:(UserMessageModel *)model {
    _model = model;
    self.nameLabel.attributedText = [self firstString:_model.name firstColor:KHEXRGB(0x333333) secondString:@"关注了你" secondColor:KHEXRGB(0x999999)];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_model.imagePath] placeholderImage:[UIImage imageNamed:@"kid"]];
    self.timeLabel.text = _model.time;
}

-(NSMutableAttributedString *)firstString:(NSString *)firstString firstColor:(UIColor *)firstColor secondString:(NSString *)secondString secondColor:(UIColor *)secondColor{
    
    // 创建 firstAttributedString
    NSMutableAttributedString * firstAttributedString = [[NSMutableAttributedString alloc] initWithString:[self isNullOrEmpty:firstString]];
    
    // 设置 firstAttributes 属性 （字体、颜色）
    NSDictionary * firstAttributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:firstColor};
    
    // 设置 firstAttributedString 长度范围
    [firstAttributedString setAttributes:firstAttributes range:NSMakeRange(0,firstAttributedString.length)];
    
    // 创建 secondAttributedString
    NSMutableAttributedString * secondAttributedString = [[NSMutableAttributedString alloc] initWithString:[self isNullOrEmpty:secondString]];
    
    // 设置 secondAttributes 属性 （字体、颜色）
    NSDictionary * secondAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:16],NSForegroundColorAttributeName:secondColor};
    
    // 设置 secondAttributedString 长度范围
    [secondAttributedString setAttributes:secondAttributes range:NSMakeRange(0,secondAttributedString.length)];
    
    // 将两个firstAttributedString 和 secondAttributedString 进行字符串拼接
    [firstAttributedString appendAttributedString:[[NSAttributedString alloc] initWithString:@"    "]];
    [firstAttributedString appendAttributedString:secondAttributedString];
    
    // 返回字符串
    return firstAttributedString;
}

- (NSString *)isNullOrEmpty:(NSString*)str
{
    if (StrEmpty(str)) {
        return @"";
    }
    return str;
}

@end
