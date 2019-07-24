//
//  PCParentCenterCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/12.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCParentCenterCell.h"
#import "BaseFormModel.h"
#import "BaseFormView.h"

@interface PCParentCenterCell()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation PCParentCenterCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = KHEXRGB(0xF7F7F7);
        [self creatParentCenterCellViews];
    }
    return self;
}

- (void)creatParentCenterCellViews {
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.formView];
    [self.backView addSubview:self.lineView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.bottom.equalTo(self.contentView);
        make.height.equalTo(@64);
    }];
    
    [self.formView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backView);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.backView);
        make.height.equalTo(@1);
    }];
}

- (void)setDetailModel:(BaseDetailFormModel *)detailModel {
    _detailModel = detailModel;
    
    self.formView.isNeed = _detailModel.isNeed;
    self.formView.title = _detailModel.title;
    self.formView.placeholder = _detailModel.placeholder;
    
    self.formView.text = _detailModel.text;
    self.formView.isEdit = _detailModel.isEdit;
    self.formView.isShowAddImg = _detailModel.isShowAddImg;
    self.formView.isShowArrow = _detailModel.isShowArrow;
    self.formView.keyBordType = _detailModel.keyBordType;
    self.formView.textColor = 0x808080;
    
    @weakify(self);
    self.formView.didTextBlock = ^(NSString *text){
        @strongify(self);
        self.detailModel.text = text;
    };
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
    }
    return _backView;
}

- (BaseFormView *)formView {
    if (!_formView) {
        _formView = [[BaseFormView alloc] init];
    }
    return _formView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

@end
