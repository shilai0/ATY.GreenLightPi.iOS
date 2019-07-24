//
//  PCInputPassWordView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/15.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCInputPassWordView.h"
#import "PCSetCashOutPassWordView.h"

@interface PCInputPassWordView()
@property (nonatomic, strong) UIView *backVIew;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UILabel *tipLabel1;
@property (nonatomic, strong) UILabel *tipLabel2;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UILabel *taxationLabel;
@property (nonatomic, strong) UILabel *taxationValueLabel;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, strong) UILabel *taxrateLabel;
@property (nonatomic, strong) UILabel *taxrateValueLabel;
@property (nonatomic, strong) UIView *lineView3;
@end

@implementation PCInputPassWordView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        [self creatInputPassWordViews];
    }
    return self;
}

- (void)creatInputPassWordViews {
    [self addSubview:self.backVIew];
    [self.backVIew addSubview:self.cancelBtn];
    [self.backVIew addSubview:self.tipLabel1];
    [self.backVIew addSubview:self.tipLabel2];
    [self.backVIew addSubview:self.valueLabel];
    [self.backVIew addSubview:self.lineView1];
    [self.backVIew addSubview:self.taxationLabel];
    [self.backVIew addSubview:self.taxationValueLabel];
    [self.backVIew addSubview:self.lineView2];
    [self.backVIew addSubview:self.taxrateLabel];
    [self.backVIew addSubview:self.taxrateValueLabel];
    [self.backVIew addSubview:self.lineView3];
    [self.backVIew addSubview:self.passWordView];
    
    [self.backVIew mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(@(KNavgationBarHeight + 50));
        make.height.equalTo(@270);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.height.width.equalTo(@20);
    }];
    
    [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cancelBtn.mas_right).offset(5);
        make.right.equalTo(@(-5));
        make.top.equalTo(self.backVIew.mas_top).offset(20);
        make.height.equalTo(@10);
        make.centerX.equalTo(self.backVIew.mas_centerX);
    }];
    
    [self.tipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backVIew);
        make.top.equalTo(self.tipLabel1.mas_bottom).offset(10);
        make.height.equalTo(@12);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backVIew);
        make.top.equalTo(self.tipLabel2.mas_bottom).offset(25);
        make.height.equalTo(@15);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.height.equalTo(@1);
        make.top.equalTo(self.valueLabel.mas_bottom).offset(15);
    }];
    
    [self.taxationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.lineView1.mas_bottom).offset(15);
        make.height.equalTo(@10);
        make.width.equalTo(@50);
    }];
    
    [self.taxationValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.top.equalTo(self.lineView1.mas_bottom).offset(15);
        make.height.equalTo(@10);
        make.width.equalTo(@100);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.height.equalTo(@1);
        make.top.equalTo(self.taxationLabel.mas_bottom).offset(10);
    }];
    
    [self.taxrateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(self.lineView2.mas_bottom).offset(15);
        make.height.equalTo(@10);
        make.width.equalTo(@50);
    }];
    
    [self.taxrateValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-20));
        make.top.equalTo(self.lineView2.mas_bottom).offset(15);
        make.height.equalTo(@10);
        make.width.equalTo(@100);
    }];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.height.equalTo(@1);
        make.top.equalTo(self.taxrateLabel.mas_bottom).offset(10);
    }];
    
    [self.passWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView3.mas_bottom).offset(20);
        make.left.equalTo(@25);
        make.right.equalTo(@(-25));
        make.height.equalTo(@((KSCREEN_WIDTH - 32 - 50)/6));
    }];
    
    @weakify(self);
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
}

- (void)setCashoutValue:(NSString *)cashoutValue {
    _cashoutValue = cashoutValue;
    self.valueLabel.text = [NSString stringWithFormat:@"￥%.2f",[_cashoutValue floatValue]];
    self.taxationValueLabel.text = [NSString stringWithFormat:@"￥%.2f",[_cashoutValue floatValue]*0.05];
}

- (UIView *)backVIew {
    if (!_backVIew) {
        _backVIew = [[UIView alloc] init];
        _backVIew.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backVIew, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backVIew;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"icon_revocation1"] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}

- (UILabel *)tipLabel1 {
    if (!_tipLabel1) {
        _tipLabel1 = [[UILabel alloc] init];
        _tipLabel1.text = @"请输入提现密码";
        _tipLabel1.font = [UIFont systemFontOfSize:12];
        _tipLabel1.textAlignment = NSTextAlignmentCenter;
        _tipLabel1.textColor = KHEXRGB(0x999999);
    }
    return _tipLabel1;
}

- (UILabel *)tipLabel2 {
    if (!_tipLabel2) {
        _tipLabel2 = [[UILabel alloc] init];
        _tipLabel2.text = @"提现";
        _tipLabel2.font = [UIFont systemFontOfSize:15];
        _tipLabel2.textAlignment = NSTextAlignmentCenter;
        _tipLabel2.textColor = KHEXRGB(0x333333);
    }
    return _tipLabel2;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.font = [UIFont boldSystemFontOfSize:18];
        _valueLabel.textColor = KHEXRGB(0x333333);
    }
    return _valueLabel;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.backgroundColor = KHEXRGB(0xF7F7F7);
    }
    return _lineView1;
}

- (UILabel *)taxationLabel {
    if (!_taxationLabel) {
        _taxationLabel = [[UILabel alloc] init];
        _taxationLabel.text = @"税费";
        _taxationLabel.font = [UIFont systemFontOfSize:9];
        _taxationLabel.textColor = KHEXRGB(0x999999);
    }
    return _taxationLabel;
}

- (UILabel *)taxationValueLabel {
    if (!_taxationValueLabel) {
        _taxationValueLabel = [[UILabel alloc] init];
        _taxationValueLabel.text = @"￥ 50.0";
        _taxationValueLabel.font = [UIFont systemFontOfSize:9];
        _taxationValueLabel.textColor = KHEXRGB(0x999999);
        _taxationValueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _taxationValueLabel;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = KHEXRGB(0xF7F7F7);
    }
    return _lineView2;
}

- (UILabel *)taxrateLabel {
    if (!_taxrateLabel) {
        _taxrateLabel = [[UILabel alloc] init];
        _taxrateLabel.text = @"税率";
        _taxrateLabel.font = [UIFont systemFontOfSize:9];
        _taxrateLabel.textColor = KHEXRGB(0x999999);
    }
    return _taxrateLabel;
}

- (UILabel *)taxrateValueLabel {
    if (!_taxrateValueLabel) {
        _taxrateValueLabel = [[UILabel alloc] init];
        _taxrateValueLabel.text = @"5%";
        _taxrateValueLabel.font = [UIFont systemFontOfSize:9];
        _taxrateValueLabel.textColor = KHEXRGB(0x999999);
        _taxrateValueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _taxrateValueLabel;
}

- (UIView *)lineView3 {
    if (!_lineView3) {
        _lineView3 = [[UIView alloc] init];
        _lineView3.backgroundColor = KHEXRGB(0xF7F7F7);
    }
    return _lineView3;
}

- (PCSetCashOutPassWordView *)passWordView {
    if (!_passWordView) {
        _passWordView = [[PCSetCashOutPassWordView alloc] initWithCount:6 margin:0];
        _passWordView.passWordType = passWordTypeInput;
        _passWordView.alpha = 0.8;
        XSViewBorderRadius(_passWordView, 0, 1, KHEXRGB(0x999999));
    }
    return _passWordView;
}

@end
