//
//  BaseFormCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseFormCell.h"
#import "BaseFormModel.h"
#import "BaseFormView.h"

@implementation BaseFormCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self me_creatSubViews];
    }
    return self;
}

#pragma mark -创建并添加子视图
- (void)me_creatSubViews {
    self.formView = [BaseFormView new];
    [self.contentView addSubview:self.formView];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    [self.contentView addSubview:lineView];
    
    [self.formView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.bottom.equalTo(self);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(@15);
        make.right.equalTo(@0);
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

@end
