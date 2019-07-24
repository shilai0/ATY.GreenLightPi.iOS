//
//  AliPayManager.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "AliPayManager.h"
#import "MainTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "FCPaySuccesViewController.h"
#import "FCPayFailViewController.h"

@implementation AliPayManager
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static AliPayManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[AliPayManager alloc] init];
    });
    return instance;
}

- (void)jumpToAppointedViewController:(NSDictionary *)resultDic {
    UIWindow *keyWindow  = [UIApplication sharedApplication].keyWindow;
    UIViewController *vc = keyWindow.rootViewController;
    if ([vc isKindOfClass:[BaseNavigationViewController class]]) {
        vc = [(BaseNavigationViewController *)vc visibleViewController];
    } else if ([vc isKindOfClass:[MainTabBarViewController class]]) {
        vc = [(MainTabBarViewController *)vc selectedViewController];
    }
    BaseNavigationViewController *navC = (BaseNavigationViewController *)vc;
    if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
        FCPaySuccesViewController *paySuccessVC = [[FCPaySuccesViewController alloc] init];
        paySuccessVC.model = self.model;
//        paySuccessVC.cardModel = self.cardModel;
        [navC pushViewController:paySuccessVC animated:YES];
    } else {
        FCPayFailViewController *payFailVC = [[FCPayFailViewController alloc] init];
        [navC pushViewController:payFailVC animated:YES];
    }
}

@end
