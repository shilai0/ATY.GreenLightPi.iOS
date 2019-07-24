//
//  PCAuthenResultViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/1.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCAuthenResultViewController.h"

@interface PCAuthenResultViewController ()
@property (nonatomic, strong) UIImageView *resultImageView;
@property (nonatomic, strong) UILabel *resultLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *reSubmitBtn;
@end

@implementation PCAuthenResultViewController

- (UIImageView *)resultImageView {
    if (!_resultImageView) {
        _resultImageView = [UIImageView new];
    }
    return _resultImageView;
}

- (UILabel *)resultLabel {
    if (!_resultLabel) {
        _resultLabel = [UILabel new];
        _resultLabel.textColor = KHEXRGB(0x333333);
        _resultLabel.font = [UIFont boldSystemFontOfSize:20];
        _resultLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _resultLabel;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = KHEXRGB(0x999999);
        _tipLabel.font = [UIFont systemFontOfSize:15];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UIButton *)reSubmitBtn {
    if (!_reSubmitBtn) {
        _reSubmitBtn = [UIButton new];
        [_reSubmitBtn setBackgroundColor:KHEXRGB(0x44C08C)];
        [_reSubmitBtn setTitle:@"重新认证" forState:UIControlStateNormal];
        [_reSubmitBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _reSubmitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        XSViewBorderRadius(_reSubmitBtn, 6, 0, KHEXRGB(0x44C08C));
    }
    return _reSubmitBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self aty_setCenterNavItemtitle:@"提示" titleColor:0x333333];
    [self pc_creatAuthenResultViews];
}

- (void)pc_creatAuthenResultViews {
    [self.view addSubview:self.resultImageView];
    [self.view addSubview:self.resultLabel];
    [self.view addSubview:self.tipLabel];
    [self.view addSubview:self.reSubmitBtn];
    self.reSubmitBtn.hidden = YES;
    
    if ([self.authenticationStatus isEqualToString:@"authenticatFailure"]) {
        self.resultImageView.image = [UIImage imageNamed:@"authen_fail"];
        self.resultLabel.text = @"认证失败";
        self.tipLabel.text = @"请重新提交相关数据";
        self.reSubmitBtn.hidden = NO;
    } else {
        self.resultImageView.image = [UIImage imageNamed:@"authen_success"];
        self.resultLabel.text = @"提交成功";
        self.tipLabel.text = @"等待工作人员审核中";
        self.reSubmitBtn.hidden = YES;
    }
    
    [self.resultImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(@(51 + 64));
        make.width.height.equalTo(@64);
    }];
    
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.resultImageView.mas_bottom).offset(28);
        make.height.equalTo(@19);
        make.width.equalTo(@(KSCREEN_WIDTH));
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.resultLabel.mas_bottom).offset(14);
        make.height.equalTo(@14);
        make.width.equalTo(@(KSCREEN_WIDTH));
    }];
    
    [self.reSubmitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@(-28));
        make.top.equalTo(self.tipLabel.mas_bottom).offset(51);
        make.height.equalTo(@48);
    }];
    
    @weakify(self);
    [[self.reSubmitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

@end
