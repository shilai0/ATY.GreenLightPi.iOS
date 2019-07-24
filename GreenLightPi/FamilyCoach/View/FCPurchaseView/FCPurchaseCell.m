//
//  FCPurchaseCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCPurchaseCell.h"
#import "FCPurchaseModel.h"

@interface FCPurchaseCell ()

@end

@implementation FCPurchaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self fc_purchaseContentView];
        self.backgroundColor = KHEXRGB(0xF7F7F7);
    }
    return self;
}

- (void)fc_purchaseContentView {
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:backView];
    
    self.logolBtn = [UIButton new];
    [self.logolBtn setTitle:@"微信支付" forState:UIControlStateNormal];
    [self.logolBtn setTitleColor:KHEXRGB(0x333333) forState:UIControlStateNormal];
    [backView addSubview:self.logolBtn];
    
    self.selectedBtn = [UIButton new];
    [backView addSubview:self.selectedBtn];
    
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
    }];
    
    [self.logolBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@10);
        make.bottom.equalTo(@(-10));
        make.width.equalTo(@120);
    }];
    
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.top.equalTo(@11);
        make.width.height.equalTo(@24);
    }];
    
    @weakify(self);
    [[self.selectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.selectBtnBlock) {
            self.selectBtnBlock();
        }
    }];
}

- (void)setModel:(FCPurchaseModel *)model {
    _model = model;
    [self.logolBtn setTitle:_model.title forState:UIControlStateNormal];
    [self.logolBtn setImage:[UIImage imageNamed:_model.imageName] forState:UIControlStateNormal];
    if (!_model.isSelect) {
        [self.selectedBtn setBackgroundImage:[UIImage imageNamed:@"fc_normal"] forState:UIControlStateNormal];
    } else {
        [self.selectedBtn setBackgroundImage:[UIImage imageNamed:@"fc_selected"] forState:UIControlStateNormal];
    }
}

@end
