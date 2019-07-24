//
//  BaseFormView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseFormView.h"
#import "BaseFormModel.h"

@interface BaseFormView () <UITextFieldDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat titleWidth;
@end

@implementation BaseFormView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        self.isEdit = YES;
        self.isShowAddImg = NO;
        [self xs_creatSubViews];
        
    }
    return self;
}

#pragma mark -创建并添加子视图
- (void)xs_creatSubViews {
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = KHEXRGB(0x333333);
    [self.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self addSubview:self.titleLabel];
    
    self.textField = [UITextField new];
    self.textField.textColor = KHEXRGB(0x646464);
    self.textField.font = [UIFont systemFontOfSize:14];
    self.textField.textAlignment = NSTextAlignmentRight;
    self.textField.delegate = self;
    self.textField.rightView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"PC_Right.png"]];;
    self.textField.leftView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"party_add.png"]];
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self addSubview:self.textField];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.bottom.equalTo(@0);
        make.width.equalTo(@100).priorityMedium();              // 设置默认高度（优先级居中）
        make.width.greaterThanOrEqualTo(@80).priorityHigh();   // 设置最小值（优先级最高）
        make.width.lessThanOrEqualTo(@180).priorityLow();       // 设置最大值（优先级最低）
    }];
    
    [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.top.bottom.equalTo(@0);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    @weakify(self);
    [[self.textField rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (self.isEdit) {
            if (self.didTextBlock) {
                self.didTextBlock(x);
            }
        }
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    switch ([self.keyBordType integerValue]) {
        case 0:
            self.textField.keyboardType = UIKeyboardTypeDefault;
            break;
        case 1:
            self.textField.keyboardType = UIKeyboardTypeNumberPad ;
            break;
        case 2:
            self.textField.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
            break;
        case 3:
            self.textField.keyboardType = UIKeyboardTypeDecimalPad;
            break;
        default:
            self.textField.keyboardType = UIKeyboardTypeDefault;
            break;
    }
    return YES;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    if (self.isNeed) {
        self.titleLabel.attributedText = [ATYUtils setAttributedString:self.title];
    } else {
        self.titleLabel.text = self.title;
    }
    
    // 如果标题为空，让输入框居中显示（宽度自伸缩）
    if (_title.length <= 0) {
        [self.textField mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(@0);
            make.centerX.equalTo(self.mas_centerX);
        }];
        self.textField.textAlignment = NSTextAlignmentCenter;
    }
}

- (NSString *)text{
    return self.textField.text;
}

- (void)setText:(NSString *)text {
    if ([text isKindOfClass:[NSNull class]]) {
        self.textField.text = @"";
    } else {
        self.textField.text = text;
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.textField.placeholder = placeholder;
}

- (void)setTextColor:(NSInteger)textColor {
    _textColor = textColor;
    self.textField.textColor = KHEXRGB(0x646464);
}

- (void)setIsEdit:(BOOL)isEdit {
    _isEdit = isEdit;
    [self.textField setEnabled:isEdit];
}

- (void)setIsShowAddImg:(BOOL)isShowAddImg {
    _isShowAddImg = isShowAddImg;
    if (self.isShowAddImg) {
        self.textField.leftViewMode = UITextFieldViewModeAlways;
    } else {
        self.textField.leftViewMode = UITextFieldViewModeNever;
    }
}

- (void)setIsShowArrow:(BOOL)isShowArrow {
    _isShowArrow = isShowArrow;
    if (self.isShowArrow) {
        self.textField.rightViewMode = UITextFieldViewModeAlways;
    } else {
        self.textField.rightViewMode = UITextFieldViewModeNever;
    }
}

- (void)setTextAlignment:(NSInteger)textAlignment {
    _textAlignment = textAlignment;
    
    if (textAlignment == 0) {
        self.textField.textAlignment = NSTextAlignmentLeft;
    } else {
        self.textField.textAlignment = NSTextAlignmentRight;
    }
}

- (void)setIsEmpty:(BOOL)isEmpty {
    _isEmpty = isEmpty;
    if (self.isEmpty) {
        if (self.textField.text.length <= 0) {
            [ATYToast aty_bottomMessageToast:@"标识项不能为空"];
        }
    }
}

@end
