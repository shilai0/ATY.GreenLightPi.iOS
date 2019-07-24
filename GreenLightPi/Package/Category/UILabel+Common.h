//
//  UILabel+Common.h
//  OnlineJudge
//
//  Created by 张兆卿 on 2017/8/16.
//  Copyright © 2017年 江苏新视云科技股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Common)

/**
 *  改变行间距
 */
+ (void)xs_changeLineSpaceForLabel:(UILabel *)label space:(float)space;

/**
 *  改变字间距
 */
+ (void)xs_changeWordSpaceForLabel:(UILabel *)label space:(float)space;

/**
 *  改变行间距和字间距
 */
+ (void)xs_changeSpaceForLabel:(UILabel *)label lineSpace:(float)lineSpace wordSpace:(float)wordSpace;



@end
