//
//  PCCashOutView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/13.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCCashOutView.h"
#import "UIButton+Common.h"

@interface PCCashOutView()<UITextFieldDelegate>
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *balanceLabel;
@property (nonatomic, strong) UIButton *selectCardBtn;
@property (nonatomic, strong) UIView *lineView1;
@property (nonatomic, strong) UILabel *cashOutValueLabel;
@property (nonatomic, strong) UILabel *cashLabel;
@property (nonatomic, strong) UIView *lineView2;
@property (nonatomic, assign) BOOL isHaveDian;
@end

@implementation PCCashOutView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self creatCashOutSubviews];
    }
    return self;
}

- (void)creatCashOutSubviews {
    [self addSubview:self.shadowView];
    [self.shadowView addSubview:self.backView];
    [self.backView addSubview:self.balanceLabel];
    [self.backView addSubview:self.selectCardBtn];
    [self.backView addSubview:self.lineView1];
    [self.backView addSubview:self.cashOutValueLabel];
    [self.backView addSubview:self.cashLabel];
    [self.backView addSubview:self.inputTextField];
    [self.backView addSubview:self.lineView2];
    [self.backView addSubview:self.tipLabel];
    [self.backView addSubview:self.cashOutAllBtn];
    self.inputTextField.delegate = self;
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shadowView);
    }];
    
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@20);
        make.height.equalTo(@12);
        make.width.equalTo(@50);
    }];
    
    [self.selectCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.left.equalTo(self.balanceLabel.mas_right).offset(-5);
        make.centerY.equalTo(self.balanceLabel.mas_centerY);
        make.height.equalTo(@15);
    }];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(self.balanceLabel.mas_bottom).offset(20);
        make.height.equalTo(@2);
    }];
    
    [self.cashOutValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.lineView1.mas_bottom).offset(40);
        make.height.equalTo(@15);
        make.width.equalTo(@80);
    }];
    
    [self.cashLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.cashOutValueLabel.mas_bottom).offset(35);
        make.height.equalTo(@20);
        make.width.equalTo(@15);
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cashLabel.mas_right).offset(10);
        make.top.equalTo(self.cashOutValueLabel.mas_bottom).offset(38);
        make.right.equalTo(@(-16));
        make.bottom.equalTo(self.cashLabel.mas_bottom);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(self.cashLabel.mas_bottom).offset(35);
        make.height.equalTo(@2);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(self.lineView2.mas_bottom).offset(30);
        make.right.equalTo(@(-100));
        make.height.equalTo(@12);
    }];
    
    [self.cashOutAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.centerY.equalTo(self.tipLabel.mas_centerY);
        make.width.equalTo(@80);
        make.height.equalTo(@15);
    }];
    
    @weakify(self);
    [[self.selectCardBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.cashOutAllBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
    
    [[self.inputTextField rac_signalForControlEvents:UIControlEventEditingChanged | UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(2, self.inputTextField.text, nil);
        }
    }];
}

-(void)setCashOutValue:(NSString *)cashOutValue {
    _cashOutValue = cashOutValue;
    self.tipLabel.text = [NSString stringWithFormat:@"可提现余额%.2f",[_cashOutValue floatValue]];
}

- (void)setBankNameStr:(NSString *)bankNameStr {
    _bankNameStr = bankNameStr;
    [self.selectCardBtn setTitle:_bankNameStr forState:UIControlStateNormal];
    [_selectCardBtn xs_layoutButtonWithButtonEdgeInsetsStyle:ButtonEdgeInsetsStyleRight WithImageAndTitleSpace:10];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    // 判断是否有小数点
    if ([textField.text containsString:@"."]) {
        self.isHaveDian = YES;
    }else{
        self.isHaveDian = NO;
    }
    if (string.length > 0) {
        //当前输入的字符
        unichar single = [string characterAtIndex:0];
        // 不能输入.0-9以外的字符
        if (!((single >= '0' && single <= '9') || single == '.')) return NO;
        // 只能有一个小数点
        if (self.isHaveDian && single == '.') return NO;
        // 如果第一位是.则前面加上0.
        if ((textField.text.length == 0) && (single == '.')) {
            textField.text = @"0";
        }
        // 如果第一位是0则后面必须输入点，否则不能输入。
        if ([textField.text hasPrefix:@"0"]) {
            if (textField.text.length > 1) {
                NSString *secondStr = [textField.text substringWithRange:NSMakeRange(1, 1)];
                if (![secondStr isEqualToString:@"."]) return NO;
            }else{
                if (![string isEqualToString:@"."]) return NO;
            }
        }
        // 小数点后最多能输入两位
        if (self.isHaveDian) {
            NSRange ran = [textField.text rangeOfString:@"."];
            // 由于range.location是NSUInteger类型的，所以这里不能通过(range.location - ran.location)>2来判断
            if (range.location > ran.location) {
                if ([textField.text pathExtension].length > 1) return NO;
            }
        }
    }
    return YES;
}

#pragma mark -- 懒加载
- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.layer.masksToBounds = NO;
        _shadowView.layer.shadowRadius = 8;
        _shadowView.layer.shadowOpacity = 1;
        _shadowView.layer.shadowOffset = CGSizeZero;
        _shadowView.layer.shadowColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(3,3);
    }
    return _shadowView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}

- (UILabel *)balanceLabel {
    if (!_balanceLabel) {
        _balanceLabel = [[UILabel alloc] init];
        _balanceLabel.text = @"提现到";
        _balanceLabel.textColor = KHEXRGB(0x1A1A1A);
        _balanceLabel.font = [UIFont systemFontOfSize:15];
    }
    return _balanceLabel;
}

- (UIButton *)selectCardBtn {
    if (!_selectCardBtn) {
        _selectCardBtn = [[UIButton alloc] init];
        [_selectCardBtn setTitleColor:KHEXRGB(0x1A1A1A) forState:UIControlStateNormal];
        _selectCardBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_selectCardBtn setImage:[UIImage imageNamed:@"selectBank"] forState:UIControlStateNormal];
        _selectCardBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return _selectCardBtn;
}

- (UIView *)lineView1 {
    if (!_lineView1) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.backgroundColor = KHEXRGB(0xF7F7F7);
    }
    return _lineView1;
}

- (UILabel *)cashOutValueLabel {
    if (!_cashOutValueLabel) {
        _cashOutValueLabel = [[UILabel alloc] init];
        _cashOutValueLabel.textColor = KHEXRGB(0x1A1A1A);
        _cashOutValueLabel.text = @"提现金额";
        _cashOutValueLabel.font = [UIFont systemFontOfSize:15];
    }
    return _cashOutValueLabel;
}

- (UILabel *)cashLabel {
    if (!_cashLabel) {
        _cashLabel = [[UILabel alloc] init];
        _cashLabel.font = [UIFont boldSystemFontOfSize:18];
        _cashLabel.text = @"￥";
        _cashLabel.textColor = KHEXRGB(0xFF4E47);
    }
    return _cashLabel;
}

- (UITextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.textColor = KHEXRGB(0x1A1A1A);
        _inputTextField.font = [UIFont systemFontOfSize:15];
        _inputTextField.keyboardType = UIKeyboardTypeDecimalPad;
        _inputTextField.clearButtonMode = UITextFieldViewModeAlways;
    }
    return _inputTextField;
}

- (UIView *)lineView2 {
    if (!_lineView2) {
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = KHEXRGB(0xF7F7F7);
    }
    return _lineView2;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textColor = KHEXRGB(0x999999);
        _tipLabel.font = [UIFont systemFontOfSize:13];
    }
    return _tipLabel;
}

- (UIButton *)cashOutAllBtn {
    if (!_cashOutAllBtn) {
        _cashOutAllBtn = [[UIButton alloc] init];
        [_cashOutAllBtn setTitle:@"全部提现" forState:UIControlStateNormal];
        [_cashOutAllBtn setTitleColor:KHEXRGB(0xFF4E47) forState:UIControlStateNormal];
        _cashOutAllBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _cashOutAllBtn;
}

@end
