//
//  AutoUpdateView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/9/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "AutoUpdateView.h"

@interface AutoUpdateView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *updateBtn;
@end

@implementation AutoUpdateView

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 4, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [UIButton new];
        [_deleteBtn setImage:[UIImage imageNamed:@"update_delete"] forState:UIControlStateNormal];
    }
    return _deleteBtn;
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [UIImageView new];
        _tipImageView.image = [UIImage imageNamed:@"update_logol"];
    }
    return _tipImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.text = @"发现新版本";
        _tipLabel.textColor = KHEXRGB(0x333333);
        _tipLabel.font = [UIFont boldSystemFontOfSize:16];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = KHEXRGB(0x999999);
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHEXRGB(0xD9D9D9);
    }
    return _lineView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton new];
        [_cancelBtn setTitle:@"忽略" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _cancelBtn;
}

- (UIButton *)updateBtn {
    if (!_updateBtn) {
        _updateBtn = [UIButton new];
        [_updateBtn setTitleColor:KHEXRGB(0xFEFEFE) forState:UIControlStateNormal];
        [_updateBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        [_updateBtn setBackgroundColor:KHEXRGB(0x44C08C)];
    }
    return _updateBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        [self creatUpdateViews];
    }
    return self;
}

- (void)creatUpdateViews {
    [self addSubview:self.backView];
    [self.backView addSubview:self.deleteBtn];
    [self.backView addSubview:self.tipImageView];
    [self.backView addSubview:self.tipLabel];
    [self.backView addSubview:self.contentLabel];
    [self.backView addSubview:self.lineView];
    [self.backView addSubview:self.cancelBtn];
    [self.backView addSubview:self.updateBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(@320);
        make.width.equalTo(@270);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@20);
        make.top.equalTo(@11);
        make.right.equalTo(@(-11));
    }];
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.backView.mas_top).offset(16);
        make.width.equalTo(@146);
        make.height.equalTo(@105);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.tipImageView.mas_bottom).offset(11);
        make.height.equalTo(@16);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(29);
        make.right.equalTo(self.backView.mas_right).offset(-21);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(16);
        make.height.equalTo(@61);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left);
        make.bottom.equalTo(self.backView.mas_bottom).offset(-48);
        make.height.equalTo(@1);
        make.width.equalTo(@135);
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom);
        make.height.equalTo(@48);
        make.left.equalTo(self.backView.mas_left);
        make.width.equalTo(@135);
    }];
    
    [self.updateBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_top);
        make.height.equalTo(@49);
        make.left.equalTo(self.cancelBtn.mas_right);
        make.width.equalTo(@135);
    }];
    
    @weakify(self);
    [[self.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.updateBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
}

- (void)setVersionStr:(NSString *)versionStr {
    _versionStr = versionStr;
    self.tipLabel.text = [NSString stringWithFormat:@"发现新版本%@",_versionStr];
}

- (void)setReleaseNotes:(NSString *)releaseNotes {
    _releaseNotes = releaseNotes;
    self.contentLabel.text = _releaseNotes;
    NSInteger lines = [self needLinesWithWidth:220];
    if (lines > 3) {
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left).offset(29);
            make.right.equalTo(self.backView.mas_right).offset(-20);
            make.top.equalTo(self.tipLabel.mas_bottom).offset(16);
            make.height.equalTo(@(61 + (lines - 3) * 20));
        }];
        
        [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.equalTo(@(320 + (lines - 3) * 20));
            make.width.equalTo(@270);
        }];
    }
}

/**
 显示当前文字需要几行
 
 @param width 给定一个宽度
 @return 返回行数
 */
- (NSInteger)needLinesWithWidth:(CGFloat)width{
    //创建一个labe
    UILabel * label = [[UILabel alloc]init];
    //font和当前label保持一致
    label.font = self.contentLabel.font;
    NSString * text = self.contentLabel.text;
    NSInteger sum = 0;
    //总行数受换行符影响，所以这里计算总行数，需要用换行符分隔这段文字，然后计算每段文字的行数，相加即是总行数。
    NSArray * splitText = [text componentsSeparatedByString:@"\n"];
    for (NSString * sText in splitText) {
        label.text = sText;
        //获取这段文字一行需要的size
        CGSize textSize = [label systemLayoutSizeFittingSize:CGSizeZero];
        //size.width/所需要的width 向上取整就是这段文字占的行数
        NSInteger lines = ceilf(textSize.width/width);
        //当是0的时候，说明这是换行，需要按一行算。
        lines = lines == 0?1:lines;
        sum += lines;
    }
    return sum;
}

@end
