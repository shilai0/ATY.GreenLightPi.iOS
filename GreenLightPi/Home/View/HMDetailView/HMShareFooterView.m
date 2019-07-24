//
//  HMShareFooterView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HMShareFooterView.h"

@interface HMShareFooterView()
@property (nonatomic, strong) UIButton *bottomBtn;
@end

@implementation HMShareFooterView

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc] init];
        [_bottomBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        [_bottomBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _bottomBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self hm_creatFooterBtn];
    }
    return self;
}

- (void)hm_creatFooterBtn {
    [self addSubview:self.bottomBtn];
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    @weakify(self);
    [[self.bottomBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.bottomBtnBlock) {
            self.bottomBtnBlock();
        }
    }];
}

@end
