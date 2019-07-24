//
//  PCSetListView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseTableView.h"

@interface PCSetListView : BaseTableView
@property (nonatomic, copy) void(^pushSwitchClickBlock)(void);
@end
