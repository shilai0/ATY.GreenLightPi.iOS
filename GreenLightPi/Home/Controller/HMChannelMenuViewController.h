//
//  HMChannelMenuViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/8.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

@interface HMChannelMenuViewController : BaseViewController
/**
 点击菜单栏回调
 */
@property (nonatomic, strong)void(^clickMenuCellBlock)(NSString *menuStr);

/**
 我的频道
 */
@property (nonatomic, strong)NSMutableArray *myTagsArrM;

/**
 我的频道(默认)
 */
@property (nonatomic, strong)NSArray *myTagsDefault;

/**
 类方法创建VC
 
 @return ColumnMenuViewController
 */
+(HMChannelMenuViewController *)columnMenuViewController:(void(^)(NSString *menuStr))clickMenuCellBlock;
@end
