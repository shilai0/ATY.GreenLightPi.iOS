//
//  HMParkUsageListView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/3.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMParkUsageListView : BaseTableView
@property (nonatomic, copy) void(^openOrCloseBlock)(BOOL isOpen);
@end

NS_ASSUME_NONNULL_END
