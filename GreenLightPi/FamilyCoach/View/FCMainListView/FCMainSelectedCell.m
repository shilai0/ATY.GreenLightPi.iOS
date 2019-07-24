//
//  FCMainSelectedCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/9.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCMainSelectedCell.h"
#import "FcCoursesModel.h"
#import "FileEntityModel.h"
#import "UIImageView+WebCache.h"

@interface FCMainSelectedCell()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UIButton *moneyBtn;

@end
@implementation FCMainSelectedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self fc_creatSelectedCell];
    }
    return self;
}

- (void)fc_creatSelectedCell {
    self.coverImageView = [UIImageView new];
    self.coverImageView.image = [UIImage imageNamed:@""];
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    XSViewBorderRadius(self.coverImageView, 4, 0, KHEXRGB(0x333333));
    [self.contentView addSubview:self.coverImageView];
    
    self.tipImageView = [UIImageView new];
    [self.coverImageView addSubview:self.tipImageView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = KHEXRGB(0x333333);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:self.titleLabel];
    
    self.descriptionLabel = [UILabel new];
    self.descriptionLabel.textColor = KHEXRGB(0x999999);
    self.descriptionLabel.font = FONT(13);
    self.descriptionLabel.numberOfLines = 2;
    [self.contentView addSubview:self.descriptionLabel];
    
    self.moneyBtn = [UIButton new];
    [self.moneyBtn setTitle:@"免费" forState:UIControlStateNormal];
    [self.moneyBtn setTitleColor:KHEXRGB(0x00D399) forState:UIControlStateNormal];
    self.moneyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [self.contentView addSubview:self.moneyBtn];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@16);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-16);
        make.width.height.equalTo(@88);
    }];
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.coverImageView);
        make.width.height.equalTo(@30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(16);
        make.top.equalTo(@15);
        make.right.equalTo(self.contentView.mas_right).offset(-22);
        make.height.equalTo(@16);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-22);
    }];
    
    [self.moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(-18));
        make.left.equalTo(self.coverImageView.mas_right).offset(16);
        make.height.equalTo(@14);
    }];
}

- (void)setCourseModel:(FcCoursesModel *)courseModel {
    _courseModel = courseModel;
    self.titleLabel.text = _courseModel.title;
    self.descriptionLabel.text = _courseModel.content;
    if ([_courseModel.isPurchase integerValue] == 1) {
        [self.moneyBtn setTitle:@"已订阅" forState:UIControlStateNormal];
    } else {
        if ([_courseModel.consumptionType isEqualToString:@"free"]) {
            [self.moneyBtn setTitle:@"免费" forState:UIControlStateNormal];
            [self.moneyBtn setTitleColor:KHEXRGB(0x00D399) forState:UIControlStateNormal];
            self.moneyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        } else {
            [self.moneyBtn setTitle:[NSString stringWithFormat:@"￥%@",courseModel.price] forState:UIControlStateNormal];
            [self.moneyBtn setTitleColor:KHEXRGB(0xFFA430) forState:UIControlStateNormal];
            self.moneyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        }
    }
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_courseModel.image.path] placeholderImage:[UIImage imageNamed:@""]];
    if ([_courseModel.coursesType integerValue] == 2) {
        self.tipImageView.image = [UIImage imageNamed:@"videoPlay"];
    } else if ([_courseModel.coursesType integerValue] == 3) {
        self.tipImageView.image = [UIImage imageNamed:@"audioPlay"];
    }
    
}

@end
