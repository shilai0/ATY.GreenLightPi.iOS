//
//  PCSetCashOutPassWordView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/12.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCSetCashOutPassWordView.h"

@interface PCSetCashOutPassWordView ()

@property (nonatomic, assign) NSInteger itemCount;

@property (nonatomic, assign) CGFloat itemMargin;

@property (nonatomic, weak) UIControl *maskView;

@property (nonatomic, strong) NSMutableArray<UIView *> *lineViews;

@end

@implementation PCSetCashOutPassWordView

#pragma mark - 初始化
- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin
{
    if (self = [super init]) {
        
        self.itemCount = count;
        self.itemMargin = margin;
        
        [self configTextField];
    }
    return self;
}

- (void)configTextField
{
    self.backgroundColor = [UIColor whiteColor];
    
    self.labels = @[].mutableCopy;
    self.lineViews = @[].mutableCopy;
    
    UITextField *textField = [[UITextField alloc] init];
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    [textField addTarget:self action:@selector(tfEditingChanged:) forControlEvents:(UIControlEventEditingChanged)];
    
    [self addSubview:textField];
    self.textField = textField;
    
    UIButton *maskView = [UIButton new];
    maskView.backgroundColor = [UIColor whiteColor];
    [maskView addTarget:self action:@selector(clickMaskView) forControlEvents:(UIControlEventTouchUpInside)];
    [self addSubview:maskView];
    self.maskView = maskView;
    
    for (NSInteger i = 0; i < self.itemCount; i++)
    {
        UILabel *label = [UILabel new];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor darkTextColor];
        label.font = [UIFont fontWithName:@"PingFangSC-Regular" size:32];
        [self addSubview:label];
        [self.labels addObject:label];
        
        if (i != self.itemCount - 1) {
            UIView *lineView = [UIView new];
            lineView.backgroundColor = KHEXRGB(0xF7F7F7);
            [self addSubview:lineView];
            [self.lineViews addObject:lineView];
        }
    }
    
}

- (void)setPassWordType:(PassWordViewType)passWordType {
    _passWordType = passWordType;
    if (_passWordType == passWordTypeInput) {
        for (NSInteger i = 0; i < self.itemCount -1; i++)
        {
            UIView *lineView = [self.lineViews objectAtIndex:i];
            lineView.backgroundColor = KHEXRGB(0x999999);
            lineView.alpha = 0.8;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.labels.count != self.itemCount) return;
    
    CGFloat temp = self.bounds.size.width - (self.itemMargin * (self.itemCount - 1));
    CGFloat w = temp / self.itemCount;
    CGFloat x = 0;
    
    for (NSInteger i = 0; i < self.labels.count; i++)
    {
        x = i * (w + self.itemMargin);
        
        UILabel *label = self.labels[i];
        label.frame = CGRectMake(x, 0, w, self.bounds.size.height);
        if (i != self.labels.count - 1 && self.lineViews.count == self.labels.count - 1) {
            UIView *lineView = self.lineViews[i];
            lineView.frame = CGRectMake(x + w - 1, 2, 1, self.bounds.size.height - 4);
        }
    }
    
    self.textField.frame = self.bounds;
    self.maskView.frame = self.bounds;
}

#pragma mark - 编辑改变
- (void)tfEditingChanged:(UITextField *)textField
{
    if (textField.text.length > self.itemCount) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, self.itemCount)];
    }
    
    for (int i = 0; i < self.itemCount; i++)
    {
        UILabel *label = [self.labels objectAtIndex:i];
        
        if (i < textField.text.length) {
            label.text = [textField.text substringWithRange:NSMakeRange(i, 1)];
        } else {
            label.text = nil;
        }
    }
    
    // 输入完毕后，自动隐藏键盘
    if (textField.text.length >= self.itemCount) {
        [textField resignFirstResponder];
        if (self.inputFinishBlock) {
            self.inputFinishBlock(self.code, self.isSure);
        }
        self.isSure = YES;
    }
}

- (void)clickMaskView
{
    [self.textField becomeFirstResponder];
}

- (BOOL)endEditing:(BOOL)force
{
    [self.textField endEditing:force];
    return [super endEditing:force];
}

- (NSString *)code
{
    return self.textField.text;
}


@end
