//
//  HMDetailViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/26.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

@interface HMDetailViewController : BaseViewController
/**
 页面H5链接
 */
@property (nonatomic, strong) NSString *urlString;
@property (nonatomic, copy) NSNumber *aid;
@property (nonatomic, copy) NSString *contentHtmlStr;
@property (nonatomic, copy) NSString *titleStr;
@property (nonatomic, copy) NSString *contentStr;
/**
 封面地址
 */
@property (nonatomic, copy) NSString *urlStr;
/**
 首页0，一家老小3
 */
@property (nonatomic, assign) NSInteger moduleType;
@end
