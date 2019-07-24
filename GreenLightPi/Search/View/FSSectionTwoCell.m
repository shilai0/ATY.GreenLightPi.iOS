//
//  FSSectionTwoCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/3.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FSSectionTwoCell.h"
#import "FatherStudyCategoryModel.h"
#import "UIImageView+WebCache.h"
#import "FileEntityModel.h"
#import "ArticleUserModel.h"

@interface FSSectionTwoCell ()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *ageLabel;
@end

@implementation FSSectionTwoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self fs_creatSectionTwoCellViews];
    }
    return self;
}

- (void)fs_creatSectionTwoCellViews {
    self.coverImageView = [UIImageView new];
    self.coverImageView.image = [UIImage imageNamed:@""];
    XSViewBorderRadius(self.coverImageView, 4, 0, KHEXRGB(0x333333));
    [self.contentView addSubview:self.coverImageView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = KHEXRGB(0x333333);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.contentView addSubview:self.titleLabel];
    
    self.descriptionLabel = [UILabel new];
    self.descriptionLabel.textColor = KHEXRGB(0x999999);
    self.descriptionLabel.font = [UIFont boldSystemFontOfSize:12];
    self.descriptionLabel.numberOfLines = 2;
    [self.contentView addSubview:self.descriptionLabel];
    
    self.ageLabel = [UILabel new];
    self.ageLabel.textColor = KHEXRGB(0x44C08C);
    self.ageLabel.font = [UIFont boldSystemFontOfSize:10];
    XSViewBorderRadius(self.ageLabel, 2, 1, KHEXRGB(0x44C08C));
    self.ageLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.ageLabel];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.width.equalTo(@75);
        make.height.equalTo(@97);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(10);
        make.top.equalTo(@18);
        make.height.equalTo(@17);
        make.right.equalTo(@(-16));
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(10);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(13);
        make.height.equalTo(@30);
        make.right.equalTo(@(-16));
    }];
    
    [self.ageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(10);
        make.top.equalTo(self.descriptionLabel.mas_bottom).offset(14);
        make.height.equalTo(@17);
        make.width.equalTo(@36);
    }];
}

- (void)setModel:(FatherStudyContentModel *)model {
    if (_model != model) {
        _model = model;
        self.titleLabel.text = _model.title;
        self.descriptionLabel.text = _model.summarize;
        self.ageLabel.text = [NSString stringWithFormat:@"%@-%@岁",_model.ageGroupStart,_model.ageGroupEnd];
        FileEntityModel *imageModel = _model.image;
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:imageModel.path] placeholderImage:[UIImage imageNamed:@""]];
    }
}

- (void)setArtlcalModel:(UserArticleModel *)artlcalModel {
    _artlcalModel = artlcalModel;
    self.titleLabel.text = _artlcalModel.title;
    self.descriptionLabel.text = _artlcalModel.summarize;
    self.ageLabel.hidden = YES;
//    self.ageLabel.text = [NSString stringWithFormat:@"%@-%@",_model.ageGroupStart,_model.ageGroupEnd];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_artlcalModel.imagePath] placeholderImage:[UIImage imageNamed:@""]];
}

@end
