//
//  PCMyCollectBottomView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMyCollectBottomView.h"

@interface PCMyCollectBottomView ()
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *selectAllBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@end

@implementation PCMyCollectBottomView

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

- (UIButton *)selectAllBtn {
    if (!_selectAllBtn) {
        _selectAllBtn = [[UIButton alloc] init];
        [_selectAllBtn setTitle:@"全选" forState:UIControlStateNormal];
        [_selectAllBtn setTitleColor:KHEXRGB(0x646464) forState:UIControlStateNormal];
        _selectAllBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_selectAllBtn setImage:[UIImage imageNamed:@"fc_normal"] forState:UIControlStateNormal];
        [_selectAllBtn setImage:[UIImage imageNamed:@"fc_selected"] forState:UIControlStateSelected];
    }
    return _selectAllBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setBackgroundColor:KHEXRGB(0xFF632A)];
        [_deleteBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    }
    return _deleteBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self pc_creatCollectBottomViews];
    }
    return self;
}

- (void)pc_creatCollectBottomViews {
    [self addSubview:self.lineView];
    [self addSubview:self.selectAllBtn];
    [self addSubview:self.deleteBtn];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [self.selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@14);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@65);
        make.height.equalTo(@25);
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.equalTo(self);
        make.top.equalTo(@1);
        make.width.equalTo(@126);
    }];
    
    @weakify(self);
    [[self.selectAllBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.selectAllBtn.selected = !self.selectAllBtn.selected;
            self.atyClickActionBlock(0, [NSString stringWithFormat:@"%@",[NSNumber numberWithBool:self.selectAllBtn.selected]], nil);
        }
    }];
    
    [[self.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
}

@end
