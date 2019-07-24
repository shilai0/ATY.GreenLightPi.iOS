//
//  HMMoreParkViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/3.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"
#import "HMParkUsageViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class UserUseLogModel;
@interface HMMoreParkViewController : BaseViewController
@property (nonatomic, strong) NSMutableArray *parkListArr;
@property (nonatomic, strong) NSMutableArray *boxListArr;
@property (nonatomic, strong) UserUseLogModel *useLogModel;
@property (nonatomic, assign) PushType pushType;
@end

NS_ASSUME_NONNULL_END
