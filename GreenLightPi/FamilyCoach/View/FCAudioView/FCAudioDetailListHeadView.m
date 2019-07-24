//
//  FCAudioDetailListHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/10/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCAudioDetailListHeadView.h"

@interface FCAudioDetailListHeadView()
@property (nonatomic, strong) UIButton *playAllBtn;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
@end

@implementation FCAudioDetailListHeadView

- (UIButton *)playAllBtn {
    if (!_playAllBtn) {
        _playAllBtn = [[UIButton alloc] init];
        [_playAllBtn setTitle:@" 播放全部" forState:UIControlStateNormal];
        [_playAllBtn setImage:[UIImage imageNamed:@"fc_playAll"] forState:UIControlStateNormal];
        [_playAllBtn setTitleColor:KHEXRGB(0x333333) forState:UIControlStateNormal];
        _playAllBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _playAllBtn;
}

- (UIView *)topLineView {
    if (!_topLineView) {
        _topLineView = [[UIView alloc] init];
        _topLineView.backgroundColor = KHEXRGB(0xEBEBEB);
    }
    return _topLineView;
}

- (UIView *)bottomLineView {
    if (!_bottomLineView) {
        _bottomLineView = [[UIView alloc] init];
        _bottomLineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _bottomLineView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    [self addSubview:self.topLineView];
    [self addSubview:self.playAllBtn];
    [self addSubview:self.bottomLineView];
    
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [self.playAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(self.topLineView.mas_bottom);
        make.height.equalTo(@60);
        make.width.equalTo(@100);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.playAllBtn.mas_bottom);
        make.height.equalTo(@1);
    }];
}

@end
