//
//  PCFeedBackView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/3.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCFeedBackView.h"

@interface PCFeedBackView ()<UITextViewDelegate>
@property (nonatomic, strong) UIButton *imagePicBtn;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation PCFeedBackView

- (UITextView *)descriptView {
    if (!_descriptView) {
        _descriptView = [UITextView new];
        _descriptView.font = [UIFont systemFontOfSize:16];
        _descriptView.textColor = KHEXRGB(0x333333);
        _descriptView.delegate = self;
    }
    return _descriptView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.text = @"问题描述（必填）";
        _tipLabel.font = [UIFont systemFontOfSize:16];
        _tipLabel.textColor = KHEXRGB(0xD1D1D1);
    }
    return _tipLabel;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textColor = KHEXRGB(0x999999);
        _titleLabel.text = @"问题截图（选填）";
    }
    return _titleLabel;
}

- (UIButton *)imagePicBtn {
    if (!_imagePicBtn) {
        _imagePicBtn = [UIButton new];
        [_imagePicBtn setImage:[UIImage imageNamed:@"PC_add"] forState:UIControlStateNormal];
        XSViewBorderRadius(_imagePicBtn, 0, 1, KHEXRGB(0xCCCCCC));
    }
    return _imagePicBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self pc_creatViews];
    }
    return self;
}

- (void)pc_creatViews {
    [self addSubview:self.descriptView];
    [self.descriptView addSubview:self.tipLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.imagePicBtn];
    
    [self.descriptView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@8);
        make.left.right.equalTo(self);
        make.height.equalTo(@196);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptView.mas_top).offset(11);
        make.left.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.height.equalTo(@14);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@17);
        make.top.equalTo(self.descriptView.mas_bottom).offset(22);
        make.right.equalTo(@(-10));
        make.height.equalTo(@14);
    }];
    
    [self.imagePicBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(13);
        make.width.height.equalTo(@100);
    }];
    
    @weakify(self);
    [[self.imagePicBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
}

#pragma mark -- UITextViewDelegate
- (void) textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [self.tipLabel setHidden:NO];
    } else {
        [self.tipLabel setHidden:YES];
    }
}

- (void)setPicImage:(UIImage *)picImage {
    _picImage = picImage;
    [self.imagePicBtn setImage:nil forState:UIControlStateNormal];
    [self.imagePicBtn setBackgroundImage:picImage forState:UIControlStateNormal];
}

@end
