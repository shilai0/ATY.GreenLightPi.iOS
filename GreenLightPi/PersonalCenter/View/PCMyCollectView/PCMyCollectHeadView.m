//
//  PCMyCollectHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/26.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMyCollectHeadView.h"

@interface PCMyCollectHeadView ()
@property (nonatomic, strong) UIImageView *seperatImageView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *switchBackView;
@property (nonatomic, strong) UIButton *switchBtn;
@property (nonatomic, strong) UIButton *selectBtn;
@end

@implementation PCMyCollectHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)setTitleArr:(NSArray *)titleArr {
    _titleArr = titleArr;
    [self pc_creatHeadView:_titleArr];
}

- (void)pc_creatHeadView:(NSArray *)titleArr {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.seperatImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 8)];
    self.seperatImageView.backgroundColor = KHEXRGB(0xF7F7F7);
    [self addSubview:self.seperatImageView];
    
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, KSCREEN_WIDTH, 56)];
    self.backImageView.backgroundColor = KHEXRGB(0xFFFFFF);
    self.backImageView.userInteractionEnabled = YES;
    [self addSubview:self.backImageView];
    
    self.switchBackView = [[UIImageView alloc] initWithFrame:CGRectMake((KSCREEN_WIDTH - 120)/2, 16, 120, 32)];
    self.switchBackView.userInteractionEnabled = YES;
    XSViewBorderRadius(self.switchBackView, 4, 1, KHEXRGB(0x44C08C));
    [self addSubview:self.switchBackView];
    
    for (int i = 0; i < titleArr.count; i ++) {
        self.switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(60 * i, 0, 60, 32)];
        if (i == self.selectedIndex) {
            self.selectBtn = self.switchBtn;
            self.selectBtn.selected = YES;
        }
        self.switchBtn.tag = 100 + i;
        [self.switchBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [self.switchBtn setTitleColor:KHEXRGB(0x44C08C) forState:UIControlStateNormal];
        [self.switchBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateSelected];
        [self.switchBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        [self.selectBtn setBackgroundColor:KHEXRGB(0x44C08C)];
        [self.switchBackView addSubview:self.switchBtn];
        [self.switchBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)btnClick:(UIButton *)btn{
    if(btn != self.selectBtn) {
        self.selectBtn.selected=NO;
        btn.selected=YES;
        [self.selectBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        [btn setBackgroundColor:KHEXRGB(0x44C08C)];
        self.selectBtn= btn;
    } else {
        self.selectBtn.selected=YES;
    }
    
    if (self.selectBlock) {
        self.selectBlock(btn.tag - 100);
    }
}


@end
