//
//  MoreButton.m
//  FamilyDemo
//
//  Created by luckyCoderCai on 2018/6/23.
//  Copyright © 2018年 DYL. All rights reserved.
//

#import "MoreButton.h"

@implementation MoreButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        self.titleLabel.font = FONT(12);
        [self setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width - 15, (contentRect.size.height - 15)/2.0, 15, 15);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    return CGRectMake(contentRect.size.width - 30 - 15 - 5, (contentRect.size.height - 15)/2.0, 30, 15);
}

@end
