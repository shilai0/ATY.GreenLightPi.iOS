//
//  FamilyIndexSectionView.m
//  FamilyDemo
//
//  Created by luckyCoderCai on 2018/6/23.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "FamilyIndexSectionView.h"
#import "MoreButton.h"

@interface FamilyIndexSectionView ()
@property (nonatomic, strong) MoreButton *moreBtn;
@property (nonatomic, strong) UIView *seperatView;
@property (nonatomic, strong) UIView *backView;
@end

@implementation FamilyIndexSectionView

#pragma mark -

- (UIView *)seperatView {
    if (!_seperatView) {
        _seperatView = [[UIView alloc] init];
        _seperatView.backgroundColor = KHEXRGB(0xF7F7F7);
    }
    return _seperatView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
    }
    return _backView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _titleLabel;
}

- (MoreButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [MoreButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:@"wf_right"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(moreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self createViews];
    }
    return self;
}

- (void)createViews
{
    [self addSubview:self.seperatView];
    [self addSubview:self.backView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.moreBtn];
    
    [self.seperatView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@8);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.seperatView.mas_bottom);
        make.height.equalTo(@60);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.centerY.equalTo(self.backView);
        make.height.equalTo(@17);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-15);
        make.centerY.equalTo(self.backView);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
}

- (void)setDisplay:(BOOL)display
{
    _display = display;
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    self.moreBtn.hidden = !self.display;
    
    self.titleLabel.text = dataDic[@"title"];
    [self.moreBtn setTitle:dataDic[@"btnTitle"] forState:UIControlStateNormal];
}

- (void)moreBtnAction
{
    NSLog(@"--section: %ld", self.section);
    if (self.moreBtnBlock) {
        self.moreBtnBlock();
    }
}

@end
