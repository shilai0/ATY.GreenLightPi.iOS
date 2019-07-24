//
//  FCPurchaseTableHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/10.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCPurchaseTableHeadView.h"
#import "FcCoursesModel.h"
#import "FileEntityModel.h"
#import "UIImageView+WebCache.h"

@interface FCPurchaseTableHeadView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@end

@implementation FCPurchaseTableHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self fc_creatPurchaseHeadViews];
    }
    return self;
}

- (void)fc_creatPurchaseHeadViews {
    self.backView= [UIView new];
    self.backView.backgroundColor = KHEXRGB(0xFFFFFF);
    [self addSubview:self.backView];
    
    self.coverImageView = [UIImageView new];
    self.coverImageView.image = [UIImage imageNamed:@"sample_4"];
    XSViewBorderRadius(self.coverImageView, 4, 0, KHEXRGB(0xFFFFFF));
    [self.backView addSubview:self.coverImageView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = KHEXRGB(0x333333);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [self.backView addSubview:self.titleLabel];
    
    self.descriptionLabel = [UILabel new];
    self.descriptionLabel.textColor = KHEXRGB(0x333333);
    self.descriptionLabel.font = FONT(12);
    [self.backView addSubview:self.descriptionLabel];
    
    self.priceLabel = [UILabel new];
    self.priceLabel.textColor = KHEXRGB(0xFFA430);
    self.priceLabel.font = FONT(14);
    [self.backView addSubview:self.priceLabel];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.height.equalTo(@119);
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(16);
        make.top.equalTo(self.backView.mas_top).offset(15);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-16);
        make.width.equalTo(@75);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(17);
        make.top.equalTo(@19);
        make.right.equalTo(self.mas_right).offset(-70);
        make.height.equalTo(@16);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(13);
        make.right.equalTo(self.mas_right).offset(-70);
        make.height.equalTo(@12);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(16);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
        make.width.equalTo(@80);
        make.height.equalTo(@12);
    }];
}

- (void)setCoursesModel:(FcCoursesModel *)coursesModel {
    _coursesModel = coursesModel;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_coursesModel.image.path] placeholderImage:[UIImage imageNamed:@"sample_2"]];
    self.titleLabel.text = _coursesModel.title;
    self.descriptionLabel.text = _coursesModel.content;
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",_coursesModel.price];
}

@end
