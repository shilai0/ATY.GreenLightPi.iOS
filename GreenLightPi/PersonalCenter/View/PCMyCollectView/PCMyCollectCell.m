//
//  PCMyCollectCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/27.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMyCollectCell.h"
#import "FileEntityModel.h"
#import "UIImageView+WebCache.h"
#import "PCMyCollectModel.h"
#import "PCBrowseTypeModel.h"

@interface PCMyCollectCell ()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation PCMyCollectCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self pc_creatMyCollectCellContaintViews];
    }
    return self;
}

- (void)pc_creatMyCollectCellContaintViews {
    [self.contentView addSubview:self.coverImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.lineView];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.width.height.equalTo(@64);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@21);
        make.left.equalTo(self.coverImageView.mas_right).offset(17);
        make.right.equalTo(@(-16));
        make.height.equalTo(@36);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.coverImageView.mas_right).offset(17);
        make.right.equalTo(@(-16));
        make.height.equalTo(@21);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@1);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.image = [UIImage imageNamed:@"sample_2"];
        XSViewBorderRadius(_coverImageView, 6, 0, KHEXRGB(0x333333));
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.text = @"提升宝宝运动能力，一岁两个月宝宝运动推荐，值得学习收藏";
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)typeLabel {
    if (_typeLabel == nil) {
        _typeLabel = [UILabel new];
        _typeLabel.text = @"文章";
        _typeLabel.textColor = KHEXRGB(0x999999);
        _typeLabel.font = [UIFont systemFontOfSize:11];
    }
    return _typeLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

- (void)setCollectModel:(CollectModel *)collectModel {
    _collectModel = collectModel;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:collectModel.image.path] placeholderImage:[UIImage imageNamed:@""]];
    _typeLabel.text = _collectModel.collectContentType;
    _titleLabel.text = _collectModel.title;
}

- (void)setBrowseTypeModel:(BrowseModel *)browseTypeModel {
    _browseTypeModel = browseTypeModel;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_browseTypeModel.image.path] placeholderImage:[UIImage imageNamed:@""]];
    _titleLabel.text = _browseTypeModel.title;
    _typeLabel.text = _browseTypeModel.browseContentType;
}

@end
