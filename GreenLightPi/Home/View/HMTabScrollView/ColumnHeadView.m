//
//  ColumnHeadView.m
//  columnManager
//
//  Created by toro宇 on 2018/6/4.
//  Copyright © 2018年 yijie. All rights reserved.
//

#import "ColumnHeadView.h"

@implementation ColumnHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.editBtn.layer.cornerRadius = 5;
    self.editBtn.clipsToBounds = YES;
    [self.editBtn setTitleColor:KHEXRGB(0xFFA430) forState:UIControlStateNormal];
    self.editBtn.layer.borderWidth = 1;
    self.editBtn.layer.borderColor = [KHEXRGB(0x44C08C) CGColor];
    // Initialization code
}
- (IBAction)editBtn:(UIButton *)sender {
    if (self.editBtnBlock) {
        self.editBtnBlock();
    }
}


@end
