//
//  RLSingleTextView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/22.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "RLSingleTextView.h"

@interface RLSingleTextView()

/** leftViewMode */
@property (nonatomic, strong) UILabel *leftLabel;

/** 下划线 */
@property (nonatomic, strong) UIView *lineView;

@end

@implementation RLSingleTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatSigleTextViews];
    }
    return self;
}

- (void)creatSigleTextViews {
    [self addSubview:self.contentTextfield];
    [self addSubview:self.getCodebtn];
    [self addSubview:self.lineView];
    
    [self.contentTextfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.top.equalTo(@17);
        make.left.equalTo(@28);
        make.right.equalTo(@(-28));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.equalTo(@28);
        make.right.equalTo(@(-28));
        make.height.equalTo(@1);
    }];
    
    [self.getCodebtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lineView.mas_bottom).offset(-14);
        make.right.equalTo(self.lineView.mas_right);
        make.height.equalTo(@13);
        make.width.equalTo(@120);
    }];
}

- (void)setIsShowLeft:(BOOL)isShowLeft {
    _isShowLeft = isShowLeft;
    if (_isShowLeft) {
        self.contentTextfield.leftView = self.leftLabel;
        self.contentTextfield.leftViewMode = UITextFieldViewModeAlways;
    }
}

#pragma mark -- 懒加载
- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 32, 40, 13)];
        NSString *defaultStr = @"+86 |";
        _leftLabel.textColor = KHEXRGB(0x333333);
        _leftLabel.font = [UIFont systemFontOfSize:14];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:defaultStr];
        //设置尺寸
        [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[defaultStr rangeOfString:@"|"]];
        [attributedString addAttribute:NSForegroundColorAttributeName value:KHEXRGB(0x999999) range:[defaultStr rangeOfString:@"|"]];
        _leftLabel.attributedText = attributedString;
    }
    return _leftLabel;
}

- (UITextField *)contentTextfield {
    if (!_contentTextfield) {
        _contentTextfield = [[UITextField alloc] init];
        _contentTextfield.textColor = KHEXRGB(0x333333);
        _contentTextfield.font = [UIFont systemFontOfSize:14];
    }
    return _contentTextfield;
}

- (UIButton *)getCodebtn {
    if (!_getCodebtn) {
        _getCodebtn = [[UIButton alloc] init];
        [_getCodebtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_getCodebtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodebtn setTitleColor:KHEXRGB(0x646464) forState:UIControlStateNormal];
        _getCodebtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _getCodebtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

@end
