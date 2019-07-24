//
//  AppDelegate.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/24.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "AppDelegate.h"
#import "MainTabBarViewController.h"
#import <UMCommon/UMCommon.h>
#import <UMCommonLog/UMCommonLogHeaders.h>
#import "BaseNavigationViewController.h"
#import <AlipaySDK/AlipaySDK.h>
#import "WXApiManager.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import "ATYCache.h"
#import "AliPayManager.h"
#import "TencentApiManager.h"
#import "ATYDataService.h"
#import "AutoUpdateView.h"
#import "JANALYTICSService.h"
#import <AdSupport/AdSupport.h>
#import "RLFirstOpenAppViewController.h"
#import "HMParkUsageViewController.h"
#import "RLFirstOpenAppViewController.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#import <UserNotifications/UserNotifications.h>


static NSString * const isNext = @"isNext";     // 是否是首次登录
static NSInteger seq = 0;


@interface AppDelegate ()<JPUSHRegisterDelegate>
@property (nonatomic, strong)TencentOAuth *tencentOAuth;
@property (nonatomic, strong) AutoUpdateView *updateView;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //设置window的根控制器
    [self aty_autoLogin];

    JANALYTICSLaunchConfig * config = [[JANALYTICSLaunchConfig alloc] init];
    config.appKey = @"fb347908f8126f1a8b8c28de";
    [JANALYTICSService setupWithConfig:config];
    [JANALYTICSService crashLogON];
    
    //注册微信
    [WXApi registerApp:@"wx057396c823ea22ae" enableMTA:YES];
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:@"101481786" andDelegate:[TencentApiManager sharedManager]];
    
    [NSThread sleepForTimeInterval:2.0];//设置启动页面时间
    
    //设置极光推送
    //Required
    //notice: 3.0.0 及以后版本注册可以这样写，也可以继续用之前的注册方式
    JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
    if (@available(iOS 12.0, *)) {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound|JPAuthorizationOptionProvidesAppNotificationSettings;
    } else {
        entity.types = JPAuthorizationOptionAlert|JPAuthorizationOptionBadge|JPAuthorizationOptionSound;
    }
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        // 可以添加自定义 categories
        // NSSet<UNNotificationCategory *> *categories for iOS10 or later
        // NSSet<UIUserNotificationCategory *> *categories for iOS8 and iOS9
    }
    [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
    
    // Required
    // init Push
    // notice: 2.1.5 版本的 SDK 新增的注册方法，改成可上报 IDFA，如果没有使用 IDFA 直接传 nil
    // 如需继续使用 pushConfig.plist 文件声明 appKey 等配置内容，请依旧使用 [JPUSHService setupWithOption:launchOptions] 方式初始化。
    [JPUSHService setupWithOption:launchOptions appKey:@"fb347908f8126f1a8b8c28de"
                          channel:@"App Store"
                 apsForProduction:YES];
    
    return YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    if([[url scheme] hasPrefix:@"tencent"]) {
        return [TencentOAuth HandleOpenURL:url];
    } else if([[url scheme] hasPrefix:@"wx"]) {
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [[AliPayManager sharedManager] jumpToAppointedViewController:resultDic];
        }];
    }
    
    if([[url scheme] hasPrefix:@"tencent"]) {
        return [TencentOAuth HandleOpenURL:url];
    }else if([[url scheme] hasPrefix:@"wx"]){
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [[AliPayManager sharedManager] jumpToAppointedViewController:resultDic];
        }];
    }
    if([[url scheme] hasPrefix:@"tencent"]) {
        return [TencentOAuth HandleOpenURL:url];
    }else if([[url scheme] hasPrefix:@"wx"]){
        return [WXApi handleOpenURL:url delegate:[WXApiManager sharedManager]];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    //检测版本更新
    [self updateVersion];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark -自动登录处理
- (void)aty_autoLogin {
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        NSLog(@"安装之后首次开启App");
        self.window.rootViewController = [[BaseNavigationViewController alloc] initWithRootViewController:[[RLFirstOpenAppViewController alloc] init]];
    } else {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_TOKEN]) {
            MainTabBarViewController *mainTabBarCtrl = [[MainTabBarViewController alloc] init];
            mainTabBarCtrl.isFirstRegister = NO;
            // 添加动画效果
            mainTabBarCtrl.view.layer.transform = CATransform3DMakeScale(1.3, 1.3, 0);
            [UIView animateWithDuration:0.35 animations:^{
                mainTabBarCtrl.view.layer.transform = CATransform3DIdentity;
                self.window.rootViewController = mainTabBarCtrl;
            }];
        } else {
            self.window.rootViewController = [[BaseNavigationViewController alloc]initWithRootViewController:[[RLFirstOpenAppViewController alloc]init]];
        }
  }
    
}

#pragma mark -- 版本更新
- (void)updateVersion {
    [ATYDataService getWithUrl:@"https://itunes.apple.com/cn/lookup?id=1427034417" params:nil isReadCache:NO success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *resultArr = responseObject[@"results"];
        
        NSDictionary *messageDic = resultArr.firstObject;
        NSString *appStoreVersion = messageDic[@"version"];
        
        NSDictionary *inforDic = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [inforDic objectForKey:@"CFBundleShortVersionString"];
        
        if ([currentVersion compare:appStoreVersion options:NSLiteralSearch] == NSOrderedAscending) {
        self.updateView.versionStr = appStoreVersion;
        self.updateView.releaseNotes = messageDic[@"releaseNotes"];
            
        [self.updateView removeFromSuperview];
        [KWindow.rootViewController.view addSubview:self.updateView];
            
            @weakify(self);
            self.updateView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
                @strongify(self);
                if (index == 1) {
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:messageDic[@"trackViewUrl"]]];
                } else {
                    [self.updateView removeFromSuperview];
                }
            };
        }
    
    } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
        
    }];
    
}

#pragma mark -- 极光推送
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    /// Required - 注册 DeviceToken
    [JPUSHService registerDeviceToken:deviceToken];
    [JPUSHService registrationIDCompletionHandler:^(int resCode, NSString *registrationID) {
        NSLog(@"resCode : %d,registrationID: %@",resCode,registrationID);
    }];
}

//实现注册 APNs 失败接口（可选）
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    //Optional
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}

#pragma mark- JPUSHRegisterDelegate
// iOS 12 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(UNNotification *)notification{
    if (notification && [notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //从通知界面直接进入应用
    }else{
        //从通知设置界面进入应用
    }
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger))completionHandler {
    // Required
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    completionHandler(UNNotificationPresentationOptionAlert); // 需要执行这个方法，选择是否提醒用户，有 Badge、Sound、Alert 三种类型可以选择设置
}

// iOS 10 Support
- (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    // Required
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [JPUSHService handleRemoteNotification:userInfo];
    }
    [self jumpToViewControllerUserInfo:userInfo];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    [JPUSHService setBadge:0];
    completionHandler();  // 系统要求执行这个方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // Required, iOS 7 Support
    [self jumpToViewControllerUserInfo:userInfo];
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // Required, For systems with less than or equal to iOS 6
    [self jumpToViewControllerUserInfo:userInfo];
    [JPUSHService handleRemoteNotification:userInfo];
}

#pragma mark -- 推送消息跳转
- (void)jumpToViewControllerUserInfo:(NSDictionary *)userInfo {
    NSInteger type = [userInfo[@"type"] integerValue];
    if (type == 1) {//跳转到盒子使用详情
        if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
            MainTabBarViewController *mainTabVC = (MainTabBarViewController *)self.window.rootViewController;
            mainTabVC.selectedIndex = 0;
            [KNotificationCenter postNotificationName:PUSHMESSAGE_NOTIFICATION object:nil userInfo:nil];
        } else {
            RLFirstOpenAppViewController *loginVC = [[RLFirstOpenAppViewController alloc] init];
            loginVC.isJPush = YES;
            self.window.rootViewController = [[BaseNavigationViewController alloc]initWithRootViewController:loginVC];
        }
    }
}

- (NSInteger)seq {
    return ++ seq;
}

//点击App图标，使App从后台恢复至前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

//按Home键使App进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application{
    [application setApplicationIconBadgeNumber:0];
    [application cancelAllLocalNotifications];
}

- (AutoUpdateView *)updateView {
    if (!_updateView) {
        self.updateView = [[AutoUpdateView alloc] initWithFrame:KWindow.rootViewController.view.bounds];
    }
    return _updateView;
}

@end
