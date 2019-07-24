//
//  HomeListVideoCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/14.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HomeListVideoCell.h"
#import "HomeListModel.h"
#import "UIImageView+WebCache.h"
#import "FileEntityModel.h"

@interface HomeListVideoCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIButton *authorButton;
@property (nonatomic, strong) UIButton *readsButton;
@property (nonatomic, strong) UILabel *typeLabel;
@end

@implementation HomeListVideoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self hm_creatPictureViews];
    }
    return self;
}

- (void)hm_creatPictureViews {
    self.titleLabel = [UILabel new];
    self.titleLabel.numberOfLines = 2;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = KHEXRGB(0x333333);
    [self.contentView addSubview:self.titleLabel];
    
    self.coverImageView = [UIImageView new];
    XSViewBorderRadius(self.coverImageView, 6, 0, KHEXRGB(0x333333));
    [self.contentView addSubview:self.coverImageView];
    
    self.authorButton = [UIButton new];
    [self.authorButton setImage:[UIImage imageNamed:@"home_ author"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.authorButton];
    
    self.readsButton = [UIButton new];
    [self.readsButton setImage:[UIImage imageNamed:@"home_ reads"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.readsButton];
    
    self.typeLabel = [UILabel new];
    self.typeLabel.font = [UIFont systemFontOfSize:12];
    self.typeLabel.layer.borderColor = [KHEXRGB(0x44C08C) CGColor];
    self.typeLabel.layer.borderWidth = 0.5f;
    self.typeLabel.layer.masksToBounds = YES;
    self.typeLabel.textColor = KHEXRGB(0x44C08C);
    [self.contentView addSubview:self.typeLabel];
    
    UIImageView *lineImageView = [UIImageView new];
    lineImageView.backgroundColor = KHEXRGB(0xE7E7E7);
    [self.contentView addSubview:lineImageView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView.mas_left).offset(-15);
        make.top.equalTo(self.contentView).offset(10);
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.width.equalTo(@200);
    }];
    
    [self.authorButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.coverImageView.mas_bottom).offset(9);
        make.height.equalTo(@12);
    }];
    
    [self.readsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.authorButton.mas_right).offset(12);
        make.top.equalTo(self.coverImageView.mas_bottom).offset(9);
        make.height.equalTo(@12);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.top.equalTo(self.coverImageView.mas_bottom).offset(9);
        make.height.equalTo(@20);
    }];
    
    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(11);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        make.height.equalTo(@1);
    }];
}

- (void)setHomeListModel:(HomeListModel *)homeListModel {
    if (_homeListModel != homeListModel) {
        _homeListModel = homeListModel;
        self.titleLabel.text = _homeListModel.title;
        self.typeLabel.text = _homeListModel.articletype.typename;
        [self.authorButton setTitle:_homeListModel.author forState:UIControlStateNormal];
        self.authorButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.authorButton setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        [self.readsButton setTitle:[_homeListModel.reads stringValue] forState:UIControlStateNormal];
        self.readsButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.readsButton setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_homeListModel.image.path] placeholderImage:[UIImage imageNamed:@"picture_default"]];
        if ([_homeListModel.is_red integerValue] != 1) {
            self.typeLabel.hidden = YES;
        } else {
            self.typeLabel.hidden = NO;
        }
    }
}

@end
