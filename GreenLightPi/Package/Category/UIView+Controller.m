//
//  UIView+Controller.m
//  SFYWeibo
//
//  Created by xsy on 15/11/23.
//  Copyright (c) 2015年 com.xinshiyun. All rights reserved.
//

#import "UIView+Controller.h"

@implementation UIView (Controller)

- (UIViewController *)xs_viewController {
    
    UIResponder *next = self.nextResponder;
    
    while (next != nil) {
        
        //判断下一个响应者是否为控制器
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return (UIViewController *)next;
        }
        
        next = next.nextResponder;
    }
    
    return nil;
}

@end
