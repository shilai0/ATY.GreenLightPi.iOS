
//
//  Configuration.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#ifndef Configuration_h
#define Configuration_h

/** 获取通知中心 */
#define KNotificationCenter [NSNotificationCenter defaultCenter]

/** 是否是iPhone X */
#define XSISiPhoneX ([[UIScreen mainScreen] bounds].size.width >= 375.0f && [[UIScreen mainScreen] bounds].size.height >= 812.0f && XSIS_IPHONE)
#define XSIS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** 状态栏高度 */
#define KStatusBarHeight (CGFloat)(XSISiPhoneX?(44):(20))
/** 导航栏高度 */
#define KNavgationHeight (44)
/** 状态栏和导航栏总高度 */
#define KNavgationBarHeight (CGFloat)(XSISiPhoneX?(88):(64))
/** TabBar高度 */
#define KTabBarHeight (CGFloat)(XSISiPhoneX?(49+34):(49))
// 顶部安全区域远离状态栏高度
#define KTopBarSafeHeight (CGFloat)(XSISiPhoneX?(24):(0))
// 底部安全区域远离高度
#define KBottomSafeHeight (CGFloat)(XSISiPhoneX?(34):(0))

/** 颜色十六进制 */
#define KHEXRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0] // 十六进制转换

#define KHEXRGBA(rgbValue,al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al] // 十六进制转换

//字体大小-系统--standard
#define FONT(X) [UIFont systemFontOfSize:X]

/* 字符串是否为空 */
#define StrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""]))

/* 是否为空或是[NSNull null] */
#define NilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) || ([(_ref) isEqual:@"null"]) || ([(_ref) isEqual:@"(null)"]))

/** 随机色 */
#define KRANDOMCOLOR [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

#define UIColorFromRGBA(r,g,b,a)            [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UIColorFromRGB(r,g,b)               UIColorFromRGBA(r,g,b,1.0)

// 设备屏幕尺寸(支持横竖屏)
/** 屏幕宽度 */
#define KSCREEN_WIDTH ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.width)
/** 屏幕高度 */
#define KSCREENH_HEIGHT ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale:[UIScreen mainScreen].bounds.size.height)
/** 屏幕尺寸 */
#define KSCREEN_SIZE ([[UIScreen mainScreen] respondsToSelector:@selector(nativeBounds)]?CGSizeMake([UIScreen mainScreen].nativeBounds.size.width/[UIScreen mainScreen].nativeScale,[UIScreen mainScreen].nativeBounds.size.height/[UIScreen mainScreen].nativeScale):[UIScreen mainScreen].bounds.size)

// 适配比例(以iPhone 6为基准)
#define KWIDTHSCALE (KSCREEN_WIDTH / 375.0)
#define KHEIGHTSCALE (KSCREENH_HEIGHT / 667.0)

#define KAutoSizeWidth(Width) ((Width / 375.0) * KSCREEN_WIDTH)
#define KAutoSizeHeight(Height) ((Height / 667.0) * KSCREENH_HEIGHT)

#define SCREENAPPLYHEIGHT(x) KSCREENH_HEIGHT / 667.0 * (x)
#define SCREENAPPLYSPACE(x) KSCREEN_WIDTH / 375.0 * (x)

/** 在屏幕比例基础上再次比例, 大于0.86, 否则大屏反而变小 */
#define KWIDTHRATE(rate) (KWIDTHSCALE > 1 ? KWIDTHSCALE*rate : KWIDTHSCALE)
#define KHEIGHTRATE(rate) (KHEIGHTSCALE > 1 ? KHEIGHTSCALE*rate: KHEIGHTSCALE)

/** 设置View的圆角和边框 */
#define XSViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

/** 获取主窗口 */
#define KWindow [[UIApplication sharedApplication] keyWindow]
#define KAppdelegate (AppDelegate*)[UIApplication sharedApplication].delegate

/**
 友盟appkey  5b0b684ef43e483808000027
 */
#define UMengAppKey @"5b0b684ef43e483808000027"

/**
 QQ
 APP ID：101481786
 APP Key：c77307be0aa5ff52514dabece7d399fe
 */
#define QQAPPID @"101481786"
#define QQAPPKey @"c77307be0aa5ff52514dabece7d399fe"

/**
 七牛云域名
 pl238grlp.bkt.clouddn.com
 file.aiteyou.net
 */
#define kQNinterface @"file.aiteyou.net"

/** 打印输出语句 */
#ifdef DEBUG    // 处于开发阶段
#define ATYLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else   // 处于发布阶段
#define ATYLog(...)
#endif

#endif /* Configuration_h */
