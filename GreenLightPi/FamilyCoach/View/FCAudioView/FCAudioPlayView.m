//
//  FCAudioPlayView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/15.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCAudioPlayView.h"
#import "FcCoursesModel.h"
#import "FileEntityModel.h"
#import "UIImageView+WebCache.h"
#import "UserModel.h"

@interface FCAudioPlayView ()
@property (nonatomic, strong) UIImageView *coverImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIButton *returnBtn;
@end

@implementation FCAudioPlayView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self fc_creatAudioPlayViews];
    }
    return self;
}

- (void)fc_creatAudioPlayViews {
    [self addSubview:self.returnBtn];
    [self addSubview:self.coverImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.headImageView];
    [self addSubview:self.nameLabel];
    
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@21);
        make.top.equalTo(@(34+KTopBarSafeHeight));
        make.width.equalTo(@30);
        make.height.equalTo(@30);
    }];
    
    [self.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@120);
        make.left.equalTo(@((KSCREEN_WIDTH - 200)/2));
        make.right.equalTo(@(-(KSCREEN_WIDTH - 200)/2));
        make.width.height.equalTo(@200);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.right.equalTo(@(-20));
        make.top.equalTo(self.coverImageView.mas_bottom).offset(40);
//        make.height.equalTo(@20);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-(KSCREEN_WIDTH/2) - 9));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(17);
        make.width.height.equalTo(@24);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(KSCREEN_WIDTH/2));
        make.right.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(20);
        make.height.equalTo(@13);
    }];
    
    @weakify(self);
    [[self.returnBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.headImageView addGestureRecognizer:tap];
    
}

- (void)setCoursesModel:(FcCoursesModel *)coursesModel {
    _coursesModel = coursesModel;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:_coursesModel.image.path] placeholderImage:[UIImage imageNamed:@""]];
    self.titleLabel.text = _coursesModel.title;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_coursesModel.user.image.path] placeholderImage:[UIImage imageNamed:@""]];
    self.nameLabel.text = _coursesModel.author;
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    FcCoursesDetailModel *detailModel = [self.coursesModel.consumptionDetails objectAtIndex:index];
    self.titleLabel.text = detailModel.title;
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    if (self.atyClickActionBlock) {
        self.atyClickActionBlock(1, nil, nil);
    }
}

- (UIImageView *)coverImageView {
    if (!_coverImageView) {
        _coverImageView = [UIImageView new];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
        XSViewBorderRadius(_coverImageView, 4, 0, KHEXRGB(0xFFFFFF));
    }
    return _coverImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont boldSystemFontOfSize:21];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [UIImageView new];
        XSViewBorderRadius(_headImageView, 12, 0, KHEXRGB(0x44C08C));
        _headImageView.userInteractionEnabled = YES;
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.textColor = KHEXRGB(0x999999);
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}

- (UIButton *)returnBtn {
    if (!_returnBtn) {
        _returnBtn = [UIButton new];
        [_returnBtn setImage:[UIImage imageNamed:@"fc_nomal"] forState:UIControlStateNormal];
    }
    return _returnBtn;
}

@end
