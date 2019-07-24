//
//  ATYToast.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATYToast : NSObject

/**
 默认提醒框
 
 @param defaultMessage 提示信息
 */
+ (void)aty_defaultToast:(NSString *)defaultMessage;

/**
 警告提醒框
 
 @param warningMessage 警告信息
 */
+ (void)aty_warningToast:(NSString *)warningMessage;

/**
 成功提醒框
 
 @param successMessage 成功信息
 */
+ (void)aty_successToast:(NSString *)successMessage;

/**
 错误提醒框
 
 @param errorMessage 错误信息
 */
+ (void)aty_errorToast:(NSString *)errorMessage;

/**
 多信息提醒框
 
 @param moreMessage 信息
 */
+ (void)aty_bottomMessageToast:(NSString *)moreMessage;

@end
