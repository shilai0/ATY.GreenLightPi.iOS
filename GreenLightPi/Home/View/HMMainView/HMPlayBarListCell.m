//
//  HMPlayBarListCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/30.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMPlayBarListCell.h"
#import "FatherStudyCategoryModel.h"
#import "UIImageView+WebCache.h"
#import "FileEntityModel.h"

@interface HMPlayBarListCell()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIButton *ageStageBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *summaryLabel;
@property (nonatomic, strong) UIButton *typeBtn;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation HMPlayBarListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatPlayBarListCellViews];
    }
    return self;
}

- (void)creatPlayBarListCellViews {
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel addSubview:self.ageStageBtn];
    [self.contentView addSubview:self.summaryLabel];
    [self.contentView addSubview:self.typeBtn];
    [self.contentView addSubview:self.lineView];
    self.typeBtn.hidden = YES;
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.bottom.equalTo(@(-16));
        make.width.height.equalTo(@90);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(17);
        make.right.equalTo(@(-16));
        make.top.equalTo(@23);
    }];
    
    [self.ageStageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.top.equalTo(self.titleLabel.mas_top).offset(-3);
        make.width.equalTo(@37);
        make.height.equalTo(@18);
    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(11);
        make.left.equalTo(self.coverImageView.mas_right).offset(17);
        make.right.equalTo(@(-16));
    }];
    
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.summaryLabel.mas_bottom).offset(11);
        make.left.equalTo(self.coverImageView.mas_right).offset(17);
        make.width.equalTo(@31);
        make.height.equalTo(@16);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.height.equalTo(@1);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (void)setPlayModel:(FatherStudyContentModel *)playModel {
    _playModel = playModel;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_playModel.image.path] placeholderImage:nil];
    [self.ageStageBtn setTitle:[NSString stringWithFormat:@"%@~%@岁",_playModel.ageGroupStart,_playModel.ageGroupEnd] forState:UIControlStateNormal];
    
    NSMutableParagraphStyle*style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    //对齐方式
    style.alignment = NSTextAlignmentLeft;
    //首行缩进
    style.firstLineHeadIndent=45.0f;
    NSAttributedString*attrText = [[NSAttributedString alloc] initWithString:_playModel.title attributes:@{NSParagraphStyleAttributeName: style}];
    self.titleLabel.attributedText = attrText;
    
    self.summaryLabel.text = _playModel.summarize;
}

#pragma mark -- 懒加载
- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        XSViewBorderRadius(_coverImageView, 4, 0, KHEXRGB(0x00D399));
    }
    return _coverImageView;
}

- (UIButton *)ageStageBtn {
    if (!_ageStageBtn) {
        _ageStageBtn = [[UIButton alloc] init];
        [_ageStageBtn setBackgroundImage:[UIImage imageNamed:@"age_back"] forState:UIControlStateNormal];
        [_ageStageBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
         _ageStageBtn.titleLabel.font = [UIFont systemFontOfSize:10];
    }
    return _ageStageBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)summaryLabel {
    if (!_summaryLabel) {
        _summaryLabel = [[UILabel alloc] init];
        _summaryLabel.text = @"躲猫猫是非常好的亲子互动游戏";
        _summaryLabel.font = [UIFont systemFontOfSize:13];
        _summaryLabel.textColor = KHEXRGB(0x999999);
        _summaryLabel.numberOfLines = 2;
    }
    return _summaryLabel;
}

- (UIButton *)typeBtn {
    if (!_typeBtn) {
        _typeBtn = [[UIButton alloc] init];
        XSViewBorderRadius(_typeBtn, 2, 1, KHEXRGB(0x00D399));
        [_typeBtn setBackgroundColor:KHEXRGB(0xEBFFF7)];
        [_typeBtn setTitle:@"运动" forState:UIControlStateNormal];
        [_typeBtn setTitleColor:KHEXRGB(0x00D399) forState:UIControlStateNormal];
        _typeBtn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    }
    return _typeBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

@end

