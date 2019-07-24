//
//  BaseViewModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseViewModel : NSObject

/* 上拉加载, 综合所有数据 */
@property (strong, nonatomic) NSMutableArray *dataTotalArr;

/** 初始化操作(完成首次数据请求) */
- (void)xs_initializesOperating;

@end
