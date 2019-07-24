//
//  HMMainSectionHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/20.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMainSectionHeadView.h"
#import "MoreButton.h"

@interface HMMainSectionHeadView ()
@property (nonatomic, strong) UIImageView *iconImgView;
@property (nonatomic, strong) MoreButton *moreBtn;
@end

@implementation HMMainSectionHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatHMMainSectionHeadView];
    }
    return self;
}

- (void)creatHMMainSectionHeadView {
    [self addSubview:self.iconImgView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.moreBtn];
    
    [self.iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.bottom.equalTo(@(-4));
        make.width.height.equalTo(@24);
        make.top.equalTo(@26);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImgView.mas_trailing).mas_offset(3);
        make.centerY.equalTo(self.iconImgView.mas_centerY);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(@-16);
        make.centerY.equalTo(self.iconImgView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(56, 56));
    }];
    
    @weakify(self);
    [[self.moreBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
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
    
    self.iconImgView.image = [UIImage imageNamed:dataDic[@"icon"]];
    self.titleLabel.text = dataDic[@"title"];
    [self.moreBtn setTitle:dataDic[@"btnTitle"] forState:UIControlStateNormal];
}

#pragma mark -- 懒加载
- (UIImageView *)iconImgView
{
    if (!_iconImgView) {
        _iconImgView = [[UIImageView alloc] init];
    }
    return _iconImgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.textColor = KHEXRGB(0x333333);
    }
    return _titleLabel;
}

- (MoreButton *)moreBtn
{
    if (!_moreBtn) {
        _moreBtn = [MoreButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:[UIImage imageNamed:@"wf_right"] forState:UIControlStateNormal];
    }
    return _moreBtn;
}

@end
