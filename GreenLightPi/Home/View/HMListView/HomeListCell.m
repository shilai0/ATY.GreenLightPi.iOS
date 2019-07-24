//
//  HomeListCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/9.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HomeListCell.h"
#import "HomeListModel.h"
#import "UIImageView+WebCache.h"
#import "UIButton+Common.h"
#import "FileEntityModel.h"

@interface HomeListCell ()
@property(nonatomic, strong)UILabel *contentLabel;
@property(nonatomic, strong)UILabel *typeLabel;
@property(nonatomic, strong)UIButton *authorButton;
@property(nonatomic, strong)UIButton *timeButton;
@property(nonatomic, strong)UIImageView *coverImageView;
@end

@implementation HomeListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self hm_creatListCellContaintViews];
    }
    return self;
}

- (void)hm_creatListCellContaintViews {
    self.contentLabel = [UILabel new];
    self.contentLabel.numberOfLines = 2;
    self.contentLabel.font = [UIFont boldSystemFontOfSize:16];
    self.contentLabel.textColor = KHEXRGB(0x333333);
    [self.contentView addSubview:self.contentLabel];
    
    self.typeLabel = [UILabel new];
    self.typeLabel.font = [UIFont systemFontOfSize:12];
    XSViewBorderRadius(self.typeLabel, 2, 1, KHEXRGB(0x44C08C));
    self.typeLabel.textColor = KHEXRGB(0x44C08C);
    [self.contentView addSubview:self.typeLabel];
    
    self.authorButton = [UIButton new];
    [self.authorButton setImage:[UIImage imageNamed:@"home_ author"] forState:UIControlStateNormal];
    [self.authorButton xs_layoutButtonWithButtonEdgeInsetsStyle:ButtonEdgeInsetsStyleLeft WithImageAndTitleSpace:5];
    [self.contentView addSubview:self.authorButton];
    
    self.timeButton = [UIButton new];
    [self.timeButton setImage:[UIImage imageNamed:@"eye"] forState:UIControlStateNormal];
    [self.timeButton xs_layoutButtonWithButtonEdgeInsetsStyle:ButtonEdgeInsetsStyleLeft WithImageAndTitleSpace:5];
    self.timeButton.hidden = YES;
    [self.contentView addSubview:self.timeButton];
    
    self.coverImageView = [UIImageView new];
    XSViewBorderRadius(self.coverImageView, 6, 0, KHEXRGB(0x333333));
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.coverImageView];
    
    UIImageView *lineImageView = [UIImageView new];
    lineImageView.backgroundColor = KHEXRGB(0xE7E7E7);
    [self.contentView addSubview:lineImageView];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-15);
        make.right.equalTo(self.contentView).offset(-15);
        make.width.height.equalTo(@90);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.coverImageView.mas_left).offset(-15);
        make.top.equalTo(self.contentView).offset(10);
        make.height.equalTo(@40);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(12);
        make.height.equalTo(@20);
    }];
    
    [self.authorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(9);
        make.height.equalTo(@12);
    }];
    
    [self.timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorButton.mas_right).offset(14);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(9);
        make.height.equalTo(@12);
    }];
    
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@0.5);
    }];
}

- (void)setHomeListModel:(HomeListModel *)homeListModel {
    _homeListModel = homeListModel;
    self.contentLabel.text = _homeListModel.title;
    self.typeLabel.text = [NSString stringWithFormat:@"  %@  ",_homeListModel.articletype.typename];
    [self.authorButton setTitle:_homeListModel.author forState:UIControlStateNormal];
    self.authorButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.authorButton setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
    [self.timeButton setTitle:_homeListModel.utime forState:UIControlStateNormal];
    self.timeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    [self.timeButton setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_homeListModel.image.path] placeholderImage:[UIImage imageNamed:@"picture_default"]];
    if (_homeListModel.isShowType) {
        self.typeLabel.hidden = NO;
    } else {
        self.typeLabel.hidden = YES;
    }
    
    if (_homeListModel.isShowTime) {
        self.timeButton.hidden = NO;
    } else {
        self.timeButton.hidden = YES;
    }
}

@end

