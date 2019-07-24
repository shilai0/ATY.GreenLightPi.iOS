//
//  FCSelectItemHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/10/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCSelectItemHeadView.h"

@interface FCSelectItemHeadView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation FCSelectItemHeadView

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"播放全部";
        _titleLabel.textColor = KHEXRGB(0x646464);
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@48);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

- (void)setWorkCount:(NSInteger)workCount {
    _workCount = workCount;
    self.titleLabel.text = [NSString stringWithFormat:@"播放列表（%ld）",_workCount];
}

@end
