//
//  BaseViewModel.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self xs_initializesOperating];
    }
    return self;
}

#pragma mark -初始化操作(完成首次数据请求)
- (void)xs_initializesOperating {
    // 初始化操作
}

#pragma mark -懒加载
- (NSMutableArray *)dataTotalArr {
    if (_dataTotalArr == nil) {
        _dataTotalArr = [NSMutableArray array];
    }
    return _dataTotalArr;
}

@end
