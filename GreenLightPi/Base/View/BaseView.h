//
//  BaseView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseView : UIView

/**
 * 单纯的点击事件回调
 * index : 按钮在整个页面中的序号（从上至下，从左至右，从0开始）
 * content1: 需要传递的参数1
 * content2: 需要传递的参数2
 */
@property (copy, nonatomic) void(^atyClickActionBlock)(NSInteger index, NSString *content1, NSString *content2);

@end
