//
//  HMShareCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HMShareCell.h"
#import "UIButton+Common.h"

@interface HMShareCell ()          
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation HMShareCell

- (UIButton *)itemButton {
    if (!_itemButton) {
        _itemButton = [[UIButton alloc] init];
        [_itemButton setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        _itemButton.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return _itemButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = KHEXRGB(0x999999);
        _titleLabel.font = [UIFont systemFontOfSize:11];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self hm_creatCellContentViews];
        self.backgroundColor = KHEXRGB(0xF8F8F8);
    }
    return self;
}

- (void)hm_creatCellContentViews {
    [self.contentView addSubview:self.itemButton];
    [self.contentView addSubview:self.titleLabel];
    
    [self.itemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.height.width.equalTo(@55);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.itemButton.mas_bottom).offset(12);
        make.height.equalTo(@11);
    }];
    
    @weakify(self);
    [[self.itemButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.itemBtnBlock) {
            self.itemBtnBlock();
        }
    }];
}

- (void)setDic:(NSDictionary *)dic {
    _dic = dic;
    [_itemButton setBackgroundImage:[UIImage imageNamed:_dic[@"image"]] forState:UIControlStateNormal];
    _titleLabel.text = _dic[@"title"];
}

@end
