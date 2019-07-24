//
//  PCMainCollectionViewCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/23.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMainCollectionViewCell.h"
#import "UIButton+Common.h"

@interface PCMainCollectionViewCell ()
@property (nonatomic, strong) UIButton *itemBtn;
@property (nonatomic, strong) UIView *rightLine;
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation PCMainCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.contentView.backgroundColor = KHEXRGB(0xFFFFFF);
        [self pc_creatContaintViews];
    }
    return self;
}

- (void)pc_creatContaintViews {
    self.itemBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH/3, 96)];
    [self.itemBtn setImage:[UIImage imageNamed:@"PC_MessageCenter"] forState:UIControlStateNormal];
    [self.itemBtn setTitle:@"消息中心" forState:UIControlStateNormal];
    [self.itemBtn setTitleColor:KHEXRGB(0x646464) forState:UIControlStateNormal];
    self.itemBtn.titleLabel.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:13];
    [self.itemBtn xs_layoutButtonWithButtonEdgeInsetsStyle:ButtonEdgeInsetsStyleTop WithImageAndTitleSpace:10];
    [self.contentView addSubview:self.itemBtn];
    
    self.rightLine = [UIView new];
    self.rightLine.backgroundColor = KHEXRGB(0xE7E7E7);
    self.rightLine.alpha = 0.5;
    [self.contentView addSubview:self.rightLine];

    self.bottomLine = [UIView new];
    self.bottomLine.backgroundColor = KHEXRGB(0xE7E7E7);
    self.bottomLine.alpha = 0.5;
    [self.contentView addSubview:self.bottomLine];

    [self.rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-1));
        make.top.bottom.equalTo(self.contentView);
        make.width.equalTo(@1);
    }];

    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.equalTo(self.contentView);
        make.bottom.equalTo(@(-1));
        make.height.equalTo(@1);
    }];
    
    @weakify(self);
    [[self.itemBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.cellBtnClick) {
            self.cellBtnClick();
        }
    }];
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    [self.itemBtn setImage:[UIImage imageNamed:_dic[@"imageName"]] forState:UIControlStateNormal];
    [self.itemBtn setTitle:_dic[@"title"] forState:UIControlStateNormal];
}

@end
