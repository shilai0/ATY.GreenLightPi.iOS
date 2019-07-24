//
//  PCAlreadyBoughtCourseCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/26.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCAlreadyBoughtCourseCell.h"
#import "FileEntityModel.h"
#import "UIImageView+WebCache.h"
#import "FcCoursesModel.h"

@interface PCAlreadyBoughtCourseCell ()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UIImageView *playImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UIImageView *lineImageView;
@end

@implementation PCAlreadyBoughtCourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self pc_creatContaintViews];
    }
    return self;
}

- (void)pc_creatContaintViews {
    self.coverImageView = [UIImageView new];
    self.coverImageView.image = [UIImage imageNamed:@"sample_4"];
    XSViewBorderRadius(self.coverImageView, 4, 0, KHEXRGB(0x333333));
    self.coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.coverImageView];
    
    self.playImage = [UIImageView new];
    self.playImage.image = [UIImage imageNamed:@"audioPlay"];
    [self.coverImageView addSubview:self.playImage];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.textColor = KHEXRGB(0x333333);
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.titleLabel.text = @"吴伯凡.认知方法论";
    [self.contentView addSubview:self.titleLabel];
    
    self.descriptionLabel = [UILabel new];
    self.descriptionLabel.textColor = KHEXRGB(0x999999);
    self.descriptionLabel.font = FONT(12);
    self.descriptionLabel.text = @"一年时间，打开洞察世界的50个维度";
    [self.contentView addSubview:self.descriptionLabel];
    
    self.progressLabel = [UILabel new];
    self.progressLabel.textColor = KHEXRGB(0x44C08C);
    self.progressLabel.font = [UIFont boldSystemFontOfSize:12];
    self.progressLabel.text = @"已学： 8%";
    [self.contentView addSubview:self.progressLabel];
    
    self.lineImageView = [UIImageView new];
    self.lineImageView.backgroundColor = KHEXRGB(0xE7E7E7);
    [self.contentView addSubview:self.lineImageView];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-16);
        make.width.equalTo(@60);
    }];
    
    [self.playImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.coverImageView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(11);
        make.top.equalTo(@22);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.height.equalTo(@16);
    }];
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(11);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(7);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.height.equalTo(@12);
    }];
    
    [self.progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.coverImageView.mas_right).offset(11);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
        make.width.equalTo(@100);
        make.height.equalTo(@12);
    }];
    
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.bottom.equalTo(self.contentView);
        make.height.equalTo(@1);
    }];
}

- (void)setModel:(FcCoursesModel *)model {
    _model = model;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:model.image.path] placeholderImage:[UIImage imageNamed:@"sample_1"]];
    self.titleLabel.text = _model.title;
    self.descriptionLabel.text = _model.content;
    self.progressLabel.text = _model.progressShow;
    if ([_model.coursesType integerValue] == 2) {
        self.playImage.image = [UIImage imageNamed:@"videoPlay"];
    } else if ([_model.coursesType integerValue] == 3) {
        self.playImage.image = [UIImage imageNamed:@"audioPlay"];
    }
}
@end
