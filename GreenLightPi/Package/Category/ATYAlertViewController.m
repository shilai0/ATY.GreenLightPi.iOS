//
//  ATYAlertViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/14.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "ATYAlertViewController.h"

@interface ATYHighLightButton : UIButton

@property (strong, nonatomic) UIColor *highlightedColor;

@end

@implementation ATYHighLightButton

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    
    if (highlighted) {
        self.backgroundColor = self.highlightedColor;
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.backgroundColor = nil;
        });
    }
}

@end

@interface ATYAlertAction ()

@property (copy, nonatomic) void(^actionHandler)(ATYAlertAction *action);

@end

@implementation ATYAlertAction

+ (instancetype)actionWithTitle:(NSString *)title titleColor:(NSInteger)titleColor handler:(void (^)(ATYAlertAction *action))handler {
    ATYAlertAction *instance = [ATYAlertAction new];
    instance -> _title = title;
    instance -> _titleColor = titleColor;
    instance.actionHandler = handler;
    return instance;
}

@end



@interface ATYAlertViewController ()
{
    UIEdgeInsets _contentMargin;
    CGFloat _contentViewWidth;
    CGFloat _buttonHeight;
    
    BOOL _firstDisplay;
}

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) NSMutableArray *mutableActions;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *shadowView;
@end

@implementation ATYAlertViewController

+ (instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message {
    ATYAlertViewController *instance = [ATYAlertViewController new];
    instance.title = title;
    instance.message = message;
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        [self defaultSetting];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建对话框
    [self creatShadowView];
    [self creatContentView];
    
    [self creatAllButtons];
    [self creatAllSeparatorLine];
    
    self.titleLabel.text = self.title;
    self.messageLabel.text = self.message;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    // 更新标题的frame
    [self updateTitleLabelFrame];
    
    // 更新message的frame
    [self updateMessageLabelFrame];
    
    // 更新按钮的frame
    [self updateAllButtonsFrame];
    
    // 更新分割线的frame
    [self updateAllSeparatorLineFrame];
    
    // 更新弹出框的frame
    [self updateShadowAndContentViewFrame];
    
    // 显示弹出动画
    [self showAppearAnimation];
}

- (void)defaultSetting {
    _contentMargin = UIEdgeInsetsMake(25, 20, 0, 20);
    _contentViewWidth = 285;
    _buttonHeight = 45;
    _firstDisplay = YES;
    _messageAlignment = NSTextAlignmentCenter;
}

#pragma mark - 创建内部视图
// 阴影层
- (void)creatShadowView {
    self.shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentViewWidth, 175)];
    self.shadowView.layer.masksToBounds = NO;
    self.shadowView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.25].CGColor;
    self.shadowView.layer.shadowRadius = 20;
    self.shadowView.layer.shadowOpacity = 1;
    self.shadowView.layer.shadowOffset = CGSizeMake(0, 10);
    [self.view addSubview:self.shadowView];
}

// 内容层
- (void)creatContentView {
    self.contentView = [[UIView alloc] initWithFrame:self.shadowView.bounds];
    self.contentView.backgroundColor = [UIColor colorWithRed:250 green:251 blue:252 alpha:1];
    self.contentView.layer.cornerRadius = 13;
    self.contentView.clipsToBounds = NO;
    [self.shadowView addSubview:self.contentView];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.contentView.frame)-64)/2.0, CGRectGetMinX(self.contentView.frame)-25, 64, 50)];
    imageV.image = [UIImage imageNamed:@"window"];
    [self.contentView addSubview:imageV];
}

// 创建所有按钮
- (void)creatAllButtons {
    for (int i=0; i<self.actions.count; i++) {
        ATYHighLightButton *btn = [ATYHighLightButton new];
        btn.tag = 10+i;
        btn.highlightedColor = [UIColor colorWithWhite:0.97 alpha:1];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:KHEXRGB(self.actions[i].titleColor) forState:UIControlStateNormal];
        [btn setTitle:self.actions[i].title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btn];
    }
}

// 创建所有的分割线
- (void)creatAllSeparatorLine {
    if (!self.actions.count) {
        return;
    }
    
    // 要创建的分割线条数
    NSInteger linesAmount = self.actions.count>2 ? self.actions.count : 1;
    linesAmount -= (self.title.length || self.message.length) ? 0 : 1;
    
    for (int i=0; i<linesAmount; i++) {
        
        UIView *separatorLine = [UIView new];
        separatorLine.tag = 1000+i;
        separatorLine.backgroundColor = KHEXRGB(0xCACACA);
        [self.contentView addSubview:separatorLine];
    }
    
    if (self.actions.count == 2) {
        UIView *lineView = [UIView new];
        lineView.tag = 300;
        lineView.backgroundColor = KHEXRGB(0xCACACA);
        [self.contentView addSubview:lineView];
    }
}

- (void)updateTitleLabelFrame {
    CGFloat labelWidth = _contentViewWidth - _contentMargin.left - _contentMargin.right;
    CGFloat titleHeight = 0.0;
    if (self.title.length) {
        CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(labelWidth, CGFLOAT_MAX)];
        titleHeight = size.height;
        self.titleLabel.frame = CGRectMake(_contentMargin.left, _contentMargin.top, labelWidth, size.height);
    }
}

- (void)updateMessageLabelFrame {
    CGFloat labelWidth = _contentViewWidth - _contentMargin.left - _contentMargin.right;
    // 更新message的frame
    CGFloat messageHeight = 0.0;
    CGFloat messageY = self.title.length ? CGRectGetMaxY(_titleLabel.frame) + 20 : _contentMargin.top;
    if (self.message.length) {
        CGSize size = [self.messageLabel sizeThatFits:CGSizeMake(labelWidth, CGFLOAT_MAX)];
        messageHeight = size.height;
        self.messageLabel.frame = CGRectMake(_contentMargin.left, messageY, labelWidth, size.height);
    }
}

- (void)updateAllButtonsFrame {
    if (!self.actions.count) {
        return;
    }
    
    CGFloat firstButtonY = [self getFirstButtonY];
    
    CGFloat buttonWidth = self.actions.count>2 ? _contentViewWidth : _contentViewWidth/self.actions.count;
    
    for (int i=0; i<self.actions.count; i++) {
        UIButton *btn = [self.contentView viewWithTag:10+i];
        CGFloat buttonX = self.actions.count>2 ? 0 : buttonWidth*i;
        CGFloat buttonY = self.actions.count>2 ? firstButtonY+_buttonHeight*i : firstButtonY;
        
        btn.frame = CGRectMake(buttonX, buttonY, buttonWidth, _buttonHeight);
    }
}

- (void)updateAllSeparatorLineFrame {
    // 分割线的条数
    NSInteger linesAmount = self.actions.count>2 ? self.actions.count : 1;
    linesAmount -= (self.title.length || self.message.length) ? 0 : 1;
    NSInteger offsetAmount = (self.title.length || self.message.length) ? 0 : 1;
    for (int i=0; i<linesAmount; i++) {
        // 获取到分割线
        UIView *separatorLine = [self.contentView viewWithTag:1000+i];
        // 获取到对应的按钮
        UIButton *btn = [self.contentView viewWithTag:10+i+offsetAmount];
        
        CGFloat x = linesAmount==1 ? _contentMargin.left : btn.frame.origin.x;
        CGFloat y = btn.frame.origin.y;
        CGFloat width = linesAmount==1 ? _contentViewWidth - _contentMargin.left - _contentMargin.right : _contentViewWidth;
        separatorLine.frame = CGRectMake(x, y, width, 0.5);
    }
    
    // 2个按钮时, 在按钮中间加一个分割线
    if (self.actions.count == 2) {
        UIView *lineView = [self.contentView viewWithTag:300];
        
        CGFloat lineY = [self getFirstButtonY];
        
        lineView.frame = CGRectMake((self.contentView.frame.size.width-1)/2.0, lineY + 5, 1, 35);
    }
}

- (void)updateShadowAndContentViewFrame {
    CGFloat firstButtonY = [self getFirstButtonY];
    
    CGFloat allButtonHeight;
    if (!self.actions.count) {
        allButtonHeight = 0;
    } else if (self.actions.count<3) {
        allButtonHeight = _buttonHeight;
    } else {
        allButtonHeight = _buttonHeight*self.actions.count;
    }
    
    // 更新警告框的frame
    CGRect frame = self.shadowView.frame;
    frame.size.height = firstButtonY+allButtonHeight;
    self.shadowView.frame = frame;
    
    self.shadowView.center = self.view.center;
    self.contentView.frame = self.shadowView.bounds;
}

- (CGFloat)getFirstButtonY {
    
    CGFloat firstButtonY = 0.0;
    if (self.title.length) {
        firstButtonY = CGRectGetMaxY(self.titleLabel.frame);
    }
    if (self.message.length) {
        firstButtonY = CGRectGetMaxY(self.messageLabel.frame);
    }
    firstButtonY += firstButtonY>0 ? 15 : 0;
    return firstButtonY;
}

#pragma mark - 事件响应
- (void)didClickButton:(UIButton *)sender {
    ATYAlertAction *action = self.actions[sender.tag-10];
    if (action.actionHandler) {
        action.actionHandler(action);
    }
    
    [self showDisappearAnimation];
}

#pragma mark - 其他方法
- (void)addAction:(ATYAlertAction *)action {
    [self.mutableActions addObject:action];
}

- (UILabel *)creatLabelWithFontSize:(CGFloat)fontSize {
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.textColor = KHEXRGB(0x333333);
    return label;
}

- (void)showAppearAnimation {
    if (_firstDisplay) {
        _firstDisplay = NO;
        self.shadowView.alpha = 0;
        self.shadowView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.55 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
            self.shadowView.transform = CGAffineTransformIdentity;
            self.shadowView.alpha = 1;
        } completion:nil];
    }
}

- (void)showDisappearAnimation {
    [UIView animateWithDuration:0.1 animations:^{
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

#pragma mark - getter & setter
- (NSString *)title {
    return [super title];
}

- (NSArray<ATYAlertAction *> *)actions {
    return [NSArray arrayWithArray:self.mutableActions];
}

- (NSMutableArray *)mutableActions {
    if (!_mutableActions) {
        _mutableActions = [NSMutableArray array];
    }
    return _mutableActions;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [self creatLabelWithFontSize:20];
        _titleLabel.text = self.title;
        _titleLabel.textColor = [UIColor colorWithRed:60/255.0 green:60/255.0 blue:60/255.0 alpha:1.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)messageLabel {
    if (!_messageLabel) {
        _messageLabel = [self creatLabelWithFontSize:16];
        _messageLabel.text = self.message;
        _messageLabel.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _messageLabel.textAlignment = self.messageAlignment;
        [self.contentView addSubview:_messageLabel];
    }
    return _messageLabel;
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    _titleLabel.text = title;
}

- (void)setMessage:(NSString *)message {
    _message = message;
    _messageLabel.text = message;
}

- (void)setMessageAlignment:(NSTextAlignment)messageAlignment {
    _messageAlignment = messageAlignment;
    _messageLabel.textAlignment = messageAlignment;
}

@end
