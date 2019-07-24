//
//  FCCollectionViewCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/9.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCCollectionViewCell.h"
#import "FileEntityModel.h"
#import "UIImageView+WebCache.h"
#import "FcCoursesModel.h"

@interface FCCollectionViewCell()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *playBtn;
@end

@implementation FCCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self fc_creartSubViews];
    }
    return self;
}

- (void)fc_creartSubViews {
    self.coverImageView = [UIImageView new];
    self.coverImageView.image = [UIImage imageNamed:@"sample_2"];
    XSViewBorderRadius(self.coverImageView, 4, 0, KHEXRGB(0x333333));
    [self.contentView addSubview:self.coverImageView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.textColor = KHEXRGB(0x333333);
    self.nameLabel.font = FONT(14);
    self.nameLabel.text = @"吴伯凡读书";
    [self.contentView addSubview:self.nameLabel];
    
    self.playBtn = [UIButton new];
    [self.playBtn setTitle:@"4910" forState:UIControlStateNormal];
    [self.playBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
    self.playBtn.titleLabel.font = FONT(10);
    [self.playBtn setImage:[UIImage imageNamed:@"fc_play"] forState:UIControlStateNormal];
    [self.coverImageView addSubview:self.playBtn];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView);
        make.width.height.equalTo(@((KSCREEN_WIDTH - 52)/3));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.top.equalTo(self.coverImageView.mas_bottom).offset(11);
        make.width.equalTo(self.coverImageView.mas_width);
        make.height.equalTo(@15);
    }];
    
    [self.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@4);
        make.bottom.equalTo(@(-4));
        make.width.equalTo(@40);
    }];
}

- (void)setCourseModel:(FcCoursesModel *)courseModel {
    _courseModel = courseModel;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_courseModel.image.path] placeholderImage:[UIImage imageNamed:@"sample_5"]];
    [self.playBtn setTitle:[NSString stringWithFormat:@"%@",_courseModel.studyNumber] forState:UIControlStateNormal];
    self.nameLabel.text = _courseModel.title;
}

@end
