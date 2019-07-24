//
//  FCAudioClassCollectionCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/18.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCAudioClassCollectionCell.h"
#import "FcCoursesModel.h"

@interface FCAudioClassCollectionCell()
@property (nonatomic, strong) UIButton *itemBtn;
@end

@implementation FCAudioClassCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self fc_creartAudioClassCell];
    }
    return self;
}

- (void)fc_creartAudioClassCell {
    self.itemBtn = [UIButton new];
    [self.itemBtn setTitleColor:KHEXRGB(0x646464) forState:UIControlStateNormal];
    self.itemBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:self.itemBtn];
    
    [self.itemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    @weakify(self);
    [[self.itemBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.btnBlock) {
            self.btnBlock();
        }
    }];
}

- (void)setClassModel:(FcClassifyModel *)classModel {
    _classModel = classModel;
    [self.itemBtn setTitle:_classModel.classifyName forState:UIControlStateNormal];
    if (_classModel.isSelected) {
        [self.itemBtn setBackgroundColor:KHEXRGB(0x44C08C)];
        [self.itemBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
    }
}

@end
