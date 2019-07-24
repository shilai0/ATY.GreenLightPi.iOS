//
//  HomeListPictureCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/14.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HomeListPictureCell.h"
#import "FileEntityModel.h"
#import "HomeListModel.h"
#import "UIImageView+WebCache.h"

@interface HomeListPictureCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIButton *authorButton;
@property (nonatomic, strong) UIButton *readsButton;
@property (nonatomic, strong) UILabel *typeLabel;
@end
@implementation HomeListPictureCell

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
    
    for (int i = 0; i < 3; i ++) {
        self.coverImageView = [UIImageView new];
        self.coverImageView.tag = 10 + i;
        XSViewBorderRadius(self.coverImageView, 6, 0, KHEXRGB(0x333333));
        self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.coverImageView];
    }
    
    self.authorButton = [UIButton new];
    [self.authorButton setImage:[UIImage imageNamed:@"home_ author"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.authorButton];
    
    self.readsButton = [UIButton new];
    [self.readsButton setImage:[UIImage imageNamed:@"home_ reads"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.readsButton];
    
    self.typeLabel = [UILabel new];
    self.typeLabel.font = [UIFont systemFontOfSize:10];
    XSViewBorderRadius(self.typeLabel, 2, 1, KHEXRGB(0x44C08C));
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
    
    for (int i = 0; i < 3; i ++) {
        [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.equalTo(self.contentView).offset((15 + (KSCREEN_WIDTH - 15
                                                              )*i/3));
            make.height.width.equalTo(@((KSCREEN_WIDTH - 45)/3));
        }];
    }
    
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

-(void)setListModel:(HomeListModel *)listModel {
    if (_listModel != listModel) {
        _listModel = listModel;
        self.titleLabel.text = _listModel.title;
        self.typeLabel.text = _listModel.articletype.typename;
        [self.authorButton setTitle:_listModel.author forState:UIControlStateNormal];
        self.authorButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.authorButton setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        [self.readsButton setTitle:[_listModel.reads stringValue] forState:UIControlStateNormal];
        self.readsButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.readsButton setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        for (int i = 0; i < 3; i ++) {
            UIImageView *coverImageView = [self.contentView viewWithTag:10 + i];
            FileEntityModel *imageModel = listModel.imageList[i];
            [coverImageView sd_setImageWithURL:[NSURL URLWithString:imageModel.path] placeholderImage:[UIImage imageNamed:@"picture_default"]];
        }
        if ([_listModel.is_red integerValue] != 1) {
            self.typeLabel.hidden = YES;
        } else {
            self.typeLabel.hidden = NO;
        }
    }
}

@end
