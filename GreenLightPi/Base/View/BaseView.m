//
//  BaseView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KHEXRGB(0xF1F1F1);
    }
    return self;
}

@end
