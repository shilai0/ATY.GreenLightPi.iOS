//
//  PCChangePassWordView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/3.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCChangePassWordView.h"

@interface PCChangePassWordView ()
@property (nonatomic, strong) UITextField *passWordTextField;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation PCChangePassWordView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self pc_creatViews];
    }
    return self;
}

- (void)pc_creatViews {
    NSArray *textArr = @[@"旧密码",@"新密码",@"确认密码"];
    NSArray *placeHoldArr = @[@"请填写旧密码",@"请输入新的密码",@"请再次输入新的密码"];
    for (int i = 0; i < textArr.count; i ++) {
        self.passWordTextField = [UITextField new];
        self.passWordTextField.font = [UIFont systemFontOfSize:16];
        self.passWordTextField.backgroundColor = [UIColor clearColor];
        self.passWordTextField.borderStyle = UITextBorderStyleNone;
        self.passWordTextField.keyboardType = UIKeyboardTypeNumberPad;
        if (i != 0) {
            self.passWordTextField.secureTextEntry = YES;
        }
        self.passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.passWordTextField.placeholder = placeHoldArr[i];
        UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 80, 61)];
        leftLabel.text = textArr[i];
        leftLabel.textColor = KHEXRGB(0x666666);
        leftLabel.font = [UIFont systemFontOfSize:16];
        self.passWordTextField.leftView = leftLabel;
        self.passWordTextField.leftViewMode = UITextFieldViewModeAlways;
        self.passWordTextField.tag = 100 + i;
        [self addSubview:self.passWordTextField];
        
        self.lineView = [UIView new];
        self.lineView.backgroundColor = KHEXRGB(0xE6E6E6);
        self.lineView.tag = 200 + i;
        [self addSubview:self.lineView];
    }
    
    for (int i = 0; i < textArr.count; i ++) {
        UITextField *passWordTextField = [self viewWithTag:100 + i];
        [passWordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(61 * i + i));
            make.left.equalTo(@20);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.equalTo(@61);
        }];
        
        UIView *lineView = [self viewWithTag:200 + i];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(passWordTextField.mas_bottom);
            make.left.equalTo(@16);
            make.right.equalTo(self.mas_right).offset(-16);
            make.height.equalTo(@1);
        }];
        
        @weakify(self);
        [[passWordTextField rac_signalForControlEvents:UIControlEventEditingChanged | UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.atyClickActionBlock) {
                self.atyClickActionBlock(i, passWordTextField.text, nil);
            }
        }];
    }
}

@end
