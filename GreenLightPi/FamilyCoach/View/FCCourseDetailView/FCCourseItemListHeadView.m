//
//  FCCourseItemListHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/10/12.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCCourseItemListHeadView.h"

@interface FCCourseItemListHeadView()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation FCCourseItemListHeadView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KHEXRGB(0x646464);
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _titleLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xF8F8F8);
        [self creatSubviews];
    }
    return self;
}

- (void)creatSubviews {
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.bottom.equalTo(self);
        make.right.equalTo(@(-16));
    }];
}

- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.titleLabel.text = _titleStr;
}

@end
