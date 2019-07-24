//
//  PCSelectBankCardView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/14.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCSelectBankCardView.h"
#import "MyCardModel.h"
#import "PCSelectCardTableView.h"
#import "UIButton+Common.h"

@interface PCSelectBankCardView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *selectFooterView;
@property (nonatomic, strong) UIButton *addBtn;
@end

@implementation PCSelectBankCardView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        [self creatSelectBankViews];
    }
    return self;
}

- (void)creatSelectBankViews {
    [self addSubview:self.backView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.cancleBtn];
    [self.backView addSubview:self.lineView];
    [self.selectFooterView addSubview:self.addBtn];
    self.selectCardTableView.tableFooterView = self.selectFooterView;
    [self.backView addSubview:self.selectCardTableView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.equalTo(@(KSCREEN_WIDTH - 60));
        make.height.equalTo(@200);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@16);
        make.right.equalTo(@(-16));
        make.width.height.equalTo(@30);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cancleBtn.mas_centerY);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.cancleBtn.mas_bottom).offset(10);
        make.height.equalTo(@1);
    }];
    
    [self.selectCardTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.backView);
        make.top.equalTo(self.lineView.mas_bottom);
    }];
    
    @weakify(self);
    [[self.cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.addBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
}

- (void)setCardArr:(NSMutableArray *)cardArr {
    _cardArr = cardArr;
    self.selectCardTableView.dataArr = _cardArr;
    [self.selectCardTableView reloadData];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"选择银行卡";
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _titleLabel;
}

- (UIButton *)cancleBtn {
    if (!_cancleBtn) {
        _cancleBtn = [[UIButton alloc] init];
        [_cancleBtn setImage:[UIImage imageNamed:@"pc_equipCancel"] forState:UIControlStateNormal];
    }
    return _cancleBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
        _lineView.alpha = 0.5;
    }
    return _lineView;
}

- (PCSelectCardTableView *)selectCardTableView {
    if (!_selectCardTableView) {
        _selectCardTableView = [[PCSelectCardTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    }
    return _selectCardTableView;
}

- (UIView *)selectFooterView {
    if (!_selectFooterView) {
        _selectFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 49)];
    }
    return _selectFooterView;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 13, 100, 24)];
        [_addBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
        [_addBtn setTitleColor:KHEXRGB(0x1A1A1A) forState:UIControlStateNormal];
        [_addBtn setImage:[UIImage imageNamed:@"pc_equipAdd"] forState:UIControlStateNormal];
        [_addBtn xs_layoutButtonWithButtonEdgeInsetsStyle:ButtonEdgeInsetsStyleLeft WithImageAndTitleSpace:10];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _addBtn;
}

@end
