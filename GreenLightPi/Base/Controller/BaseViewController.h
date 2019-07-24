//
//  BaseViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickFinshBlock)(void);

@interface BaseViewController : UIViewController

@property (nonatomic, strong) UIView *navView;

/** 是否开启监听网络状态 */
@property (assign, nonatomic) BOOL isStart;

/** 是否是模态视图 */
@property (assign, nonatomic) BOOL isModel;

/**
 左边返回
 
 @param itemImg 按钮图片（不传 默认为灰色）
 @param title 按钮文字内容
 @param titleColor 按钮文字颜色（传 0 默认0x999999）
 @param leftBlock 点击事件
 */
- (void)aty_setLeftNavItemImg:(NSString *)itemImg title:(NSString *)title titleColor:(NSInteger)titleColor leftBlock:(clickFinshBlock)leftBlock;

/**
 中间标题
 
 
 @param title 文字内容
 @param titleColor 文字颜色（传 0 默认0x999999）
 */
- (void)aty_setCenterNavItemtitle:(NSString *)title titleColor:(NSInteger)titleColor;

/**
 右边Item
 
 @param itemImg 按钮图片（可为空）
 @param title 按钮文字内容
 @param titleColor 按钮文字颜色（传 0 默认0x999999）
 @param rightBlock 点击事件
 */
- (void)aty_setRightNavItemImg:(NSString *)itemImg title:(NSString *)title titleColor:(NSInteger)titleColor rightBlock:(clickFinshBlock)rightBlock;

/**
 登录方法
 */
- (void)loginAction;

/**
 注册方法
 */
- (void)registAction;

- (NSInteger)seq;

@end
