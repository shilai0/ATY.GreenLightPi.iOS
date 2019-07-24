//
//  HMReadBarListCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/29.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMReadBarListCell.h"
#import "FatherStudyCategoryModel.h"
#import "UIImageView+WebCache.h"
#import "FileEntityModel.h"

@interface HMReadBarListCell ()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIButton *ageStageBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *keyLabel;
@property (nonatomic, strong) UILabel *targetLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *summaryLabel;
@end

@implementation HMReadBarListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatHMReadBarListCellViews];
    }
    return self;
}

- (void)creatHMReadBarListCellViews {
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel addSubview:self.ageStageBtn];
    [self.contentView addSubview:self.targetLabel];
//    [self.contentView addSubview:self.keyLabel];
//    [self.contentView addSubview:self.targetLabel];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.summaryLabel];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@15);
        make.bottom.equalTo(@(-15));
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
    
//    [self.targetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.coverImageView.mas_right).offset(17);
//        make.bottom.equalTo(self.coverImageView.mas_bottom).offset(-5);
//        make.right.equalTo(@(-16));
//        make.height.equalTo(@13);
//    }];
//
//    [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.coverImageView.mas_right).offset(17);
//        make.bottom.equalTo(self.targetLabel.mas_top).offset(-7);
//        make.right.equalTo(@(-16));
//        make.height.equalTo(@13);
//    }];
    
    [self.summaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(11);
        make.left.equalTo(self.coverImageView.mas_right).offset(17);
        make.right.equalTo(@(-16));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.height.equalTo(@1);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
}

- (void)setReadModel:(FatherStudyContentModel *)readModel {
    _readModel = readModel;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_readModel.image.path] placeholderImage:nil];
    [self.ageStageBtn setTitle:[NSString stringWithFormat:@"%@~%@岁",_readModel.ageGroupStart,_readModel.ageGroupEnd] forState:UIControlStateNormal];

    NSMutableParagraphStyle*style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    //对齐方式
    style.alignment = NSTextAlignmentLeft;
    //首行缩进
    style.firstLineHeadIndent=45.0f;
    NSAttributedString*attrText = [[NSAttributedString alloc] initWithString:_readModel.title attributes:@{NSParagraphStyleAttributeName: style}];
    self.titleLabel.attributedText = attrText;
    
    self.summaryLabel.text = _readModel.summarize;
}

#pragma mark -- 懒加载
- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        XSViewBorderRadius(_coverImageView, 4, 0, KHEXRGB(0xFFFFFF));
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
        _titleLabel.text = @"卖火柴的小女孩";
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)keyLabel {
    if (!_keyLabel) {
        _keyLabel = [[UILabel alloc] init];
        _keyLabel.text = @"关键词：课程简介";
        _keyLabel.textColor = KHEXRGB(0x999999);
        _keyLabel.font = [UIFont systemFontOfSize:13];
    }
    return _keyLabel;
}

- (UILabel *)targetLabel {
    if (!_targetLabel) {
        _targetLabel = [[UILabel alloc] init];
        _targetLabel.text = @"培养目标：课程简介";
        _targetLabel.textColor = KHEXRGB(0x999999);
        _targetLabel.font = [UIFont systemFontOfSize:13];
    }
    return _targetLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
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

@end
