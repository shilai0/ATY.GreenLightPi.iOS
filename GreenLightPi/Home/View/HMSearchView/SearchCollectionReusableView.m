//
//  SearchCollectionReusableView.m
//  CYSearchDemo
//
//  Created by toro宇 on 2018/6/21.
//  Copyright © 2018年 CodeYu. All rights reserved.
//

#import "SearchCollectionReusableView.h"

@interface SearchCollectionReusableView()
@end
@implementation SearchCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *lineV = [[UIView alloc] init];
        [self addSubview:lineV];
        _lineView = lineV;
        [lineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.right.equalTo(@(-16));
            make.height.equalTo(@1);
            make.top.equalTo(self);
        }];
        lineV.backgroundColor = KHEXRGB(0xE7E7E7);
        
        UILabel *lab = [[UILabel alloc] init];
        [self addSubview:lab];
        _titleLab = lab;
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(20);
            make.top.equalTo(lineV.mas_bottom);
            make.bottom.equalTo(self);
            make.width.equalTo(@80);
        }];
        lab.textColor = KHEXRGB(0x646464);
        lab.font = [UIFont systemFontOfSize:13];
        
        UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:deleteBtn];
        _deleteBtn = deleteBtn;
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-16);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(16, 16));
        }];
        [deleteBtn setImage:[UIImage imageNamed:@"search_del"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(deleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)deleteBtn:(UIButton *)btn
{
    if (self.deleteBtnBlock) {
        self.deleteBtnBlock();
    }
}

@end
