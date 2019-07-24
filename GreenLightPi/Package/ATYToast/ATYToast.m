//
//  ATYToast.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "ATYToast.h"
#import "FFToast.h"

@implementation ATYToast

/**
 默认提醒框
 
 @param defaultMessage 提示信息
 */
+ (void)aty_defaultToast:(NSString *)defaultMessage {
    if (defaultMessage.length <= 0) {
        return;
    }
    
    FFToast *toast = [[FFToast alloc]initToastWithTitle:@"" message:defaultMessage iconImage:[UIImage imageNamed:@"atyToast.bundle/fftoast_warning"]];
    toast.messageFont = [UIFont systemFontOfSize:17];
    toast.dismissToastAnimated = YES;
    toast.toastType = FFToastTypeDefault;
    toast.toastPosition = FFToastPositionDefault;
    [toast show];
}

/**
 警告提醒框
 
 @param warningMessage 警告信息
 */
+ (void)aty_warningToast:(NSString *)warningMessage {
    if (warningMessage.length <= 0) {
        return;
    }
    
    FFToast *toast = [[FFToast alloc]initToastWithTitle:@"" message:warningMessage iconImage:[UIImage imageNamed:@"atyToast.bundle/fftoast_warning"]];
    toast.messageFont = [UIFont systemFontOfSize:17];
    toast.dismissToastAnimated = YES;
    toast.toastType = FFToastTypeWarning;
    toast.toastPosition = FFToastPositionDefault;
    [toast show];
}

/**
 成功提醒框
 
 @param successMessage 成功信息
 */
+ (void)aty_successToast:(NSString *)successMessage {
    if (successMessage.length <= 0) {
        return;
    }
    
    FFToast *toast = [[FFToast alloc]initToastWithTitle:@"" message:successMessage iconImage:[UIImage imageNamed:@"atyToast.bundle/fftoast_success"]];
    toast.messageFont = [UIFont systemFontOfSize:17];
    toast.dismissToastAnimated = YES;
    toast.toastType = FFToastTypeSuccess;
    toast.toastPosition = FFToastPositionDefault;
    [toast show];
}

/**
 错误提醒框
 
 @param errorMessage 错误信息
 */
+ (void)aty_errorToast:(NSString *)errorMessage {
    if (errorMessage.length <= 0) {
        return;
    }
    
    FFToast *toast = [[FFToast alloc]initToastWithTitle:@"" message:errorMessage iconImage:[UIImage imageNamed:@"atyToast.bundle/fftoast_error"]];
    toast.messageFont = [UIFont systemFontOfSize:17];
    toast.dismissToastAnimated = YES;
    toast.toastType = FFToastTypeError;
    toast.toastPosition = FFToastPositionDefault;
    [toast show];
}

/**
 多信息提醒框(底部提醒框)
 
 @param moreMessage 信息
 */
+ (void)aty_bottomMessageToast:(NSString *)moreMessage {
    if (moreMessage.length <= 0) {
        return;
    }
    
    FFToast *toast = [[FFToast alloc]initToastWithTitle:nil message:moreMessage iconImage:nil];
    toast.messageFont = [UIFont systemFontOfSize:17];
    toast.dismissToastAnimated = YES;
    toast.toastType = FFToastTypeDefault;
    toast.toastPosition = FFToastPositionBottomWithFillet;
    [toast show];
}

@end
