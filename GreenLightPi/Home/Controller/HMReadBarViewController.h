//
//  HMReadBarViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/29.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class HomeModel;
@interface HMReadBarViewController : BaseViewController
@property (nonatomic, strong) HomeModel *homeModel;
@property (nonatomic, copy) NSString *urlString;
@end

NS_ASSUME_NONNULL_END
