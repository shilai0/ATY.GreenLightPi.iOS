//
//  XTitleStyle.m
//  PageViewDemo
//  https://github.com/MrLSPBoy/PageViewController
//  Created by Object on 17/7/11.
//  Copyright © 2017年 Object. All rights reserved.
//

#import "LSPTitleStyle.h"

@implementation LSPTitleStyle

- (instancetype)init{
    if (self = [super init]) {
        
        self.isTitleViewScrollEnable = YES;
        self.isContentViewScrollEnable = YES;
        self.normalColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        self.selectedColor = KHEXRGB(0x44C08C);
        self.font = [UIFont boldSystemFontOfSize:16.0];
        self.titleMargin = 0.0;
        self.isShowBottomLine = YES;
        self.bottomLineColor = KHEXRGB(0x44C08C);
        self.bottomLineH = 3.0;
        self.isNeedScale = NO;
        self.scaleRange = 1.3;
        self.isShowCover = NO;
        self.coverBgColor = KHEXRGB(0x44C08C);
        self.coverMargin = 0.0;
        self.coverH = 25.0;
        self.coverRadius = 5;
        self.bottomLineW = 20;
        self.adjacentMargin = 17;
        self.index = 0;
        self.isAverage = NO;
        self.isShowMoreBtn = NO;
    }
    return self;
}

@end
