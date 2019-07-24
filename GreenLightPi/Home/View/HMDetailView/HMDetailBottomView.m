//
//  HMDetailBottomView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/18.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HMDetailBottomView.h"

@interface HMDetailBottomView ()<UITextFieldDelegate>
@property (nonatomic, strong) UIButton *commentBtn;
@property (nonatomic, strong) UIButton *likeBtn;
@property (nonatomic, strong) UILabel *commentNumLabel;
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation HMDetailBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self hm_creatDetailBottomViews];
    }
    return self;
}

- (void)hm_creatDetailBottomViews {
    [self addSubview:self.likeBtn];
    [self addSubview:self.commentBtn];
    [self addSubview:self.commentNumLabel];
    [self addSubview:self.tipLabel];
    [self.tipLabel addSubview:self.inputTextField];
    
    [self.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-22));
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.equalTo(@24);
    }];
    
    [self.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.likeBtn.mas_left).offset(-21);
        make.centerY.equalTo(self.mas_centerY);
        make.width.height.equalTo(@24);
    }];
    
    [self.commentNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentBtn.mas_right).offset(-8);
        make.bottom.equalTo(self.commentBtn.mas_top).offset(8);
        make.height.equalTo(@10);
        make.width.equalTo(@14);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.commentBtn.mas_left).offset(-20);
        make.height.equalTo(@35);
    }];
    
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.bottom.top.equalTo(self.tipLabel);
    }];
    
    @weakify(self);
    [[self.inputTextField rac_signalForControlEvents:UIControlEventEditingChanged | UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(3, nil, nil);
        }
    }];
    
    
    [[self.commentBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
    
    [[self.likeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(2, [NSString stringWithFormat:@"%@",[NSNumber numberWithBool:self.likeBtn.selected]], nil);
        }
    }];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {    // 点击了return按钮后调用该方法
    if (textField.text.length <= 0) {
        [ATYToast aty_bottomMessageToast:@"请输入评论内容"];
    }
    
    [textField resignFirstResponder];
    
    if (self.atyClickActionBlock) {
        self.atyClickActionBlock(0, nil, nil);
    }
    
    return YES;
}

- (void)setIsCollect:(BOOL)isCollect {
    _isCollect = isCollect;
    self.likeBtn.selected = _isCollect;
}

- (void)setCommentNum:(NSInteger)commentNum {
    _commentNum = commentNum;
    if (_commentNum == 0) {
        self.commentNumLabel.hidden = YES;
    } else {
        self.commentNumLabel.hidden = NO;
        self.commentNumLabel.text = [NSString stringWithFormat:@"%ld",commentNum];
    }
}

- (UILabel *)commentNumLabel {
    if (!_commentNumLabel) {
        _commentNumLabel = [UILabel new];
        _commentNumLabel.textColor = KHEXRGB(0x44C08C);
        _commentNumLabel.font = [UIFont boldSystemFontOfSize:10];
        _commentNumLabel.backgroundColor = KHEXRGB(0xFFFFFF);
        [_commentNumLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        _commentNumLabel.textAlignment = NSTextAlignmentCenter;
        self.commentNumLabel.hidden = YES;
        XSViewBorderRadius(_commentNumLabel, 5, 0, KHEXRGB(0xFFFFFF));
    }
    return _commentNumLabel;
}

- (UIButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [UIButton new];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"hm_comment"] forState:UIControlStateNormal];
    }
    return _commentBtn;
}

- (UIButton *)likeBtn {
    if (!_likeBtn) {
        _likeBtn = [UIButton new];
        [_likeBtn setBackgroundImage:[UIImage imageNamed:@"hm_likeNormal"] forState:UIControlStateNormal];
        [_likeBtn setBackgroundImage:[UIImage imageNamed:@"hm_likeSeleted"] forState:UIControlStateSelected];
    }
    return _likeBtn;
}

- (UITextField *)inputTextField {
    if (!_inputTextField) {
        _inputTextField = [UITextField new];
        _inputTextField.returnKeyType = UIReturnKeySend;
        _inputTextField.placeholder = @" 说点什么......";
        _inputTextField.delegate = self;
    }
    return _inputTextField;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.backgroundColor = KHEXRGB(0xF2F2F2);
        _tipLabel.userInteractionEnabled = YES;
        XSViewBorderRadius(_tipLabel, 18, 0, KHEXRGB(0xF2F2F2));
    }
    return _tipLabel;
}

@end
