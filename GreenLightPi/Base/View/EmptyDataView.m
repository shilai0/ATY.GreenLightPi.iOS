//
//  EmptyDataView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/23.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "EmptyDataView.h"

@interface EmptyDataView ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation EmptyDataView

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [UIImage imageNamed:@"em_default"];
    }
    return _imageView;
}

- (UIButton *)titleBtn {
    if (!_titleBtn) {
        _titleBtn = [[UIButton alloc] init];
        [_titleBtn setTitle:@"未找到相关内容哟~" forState:UIControlStateNormal];
        [_titleBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_titleBtn setBackgroundColor:KHEXRGB(0x44C08C)];
        _titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        XSViewBorderRadius(_titleBtn, 4, 0, KHEXRGB(0x44C08C));
    }
    return _titleBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatEmptyDataView];
    }
    return self;
}

- (void)creatEmptyDataView {
    [self addSubview:self.imageView];
    [self addSubview:self.titleBtn];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@(107*KWIDTHSCALE));
        make.height.width.equalTo(@125);
    }];
    
    [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(78);
        make.centerX.equalTo(self.imageView.mas_centerX);
        make.height.equalTo(@40);
        make.width.equalTo(@180);
    }];
    
    @weakify(self);
    [[self.titleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
}

@end
