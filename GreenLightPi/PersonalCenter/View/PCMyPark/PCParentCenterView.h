//
//  PCParentCenterView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/12.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseFormTableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PCParentCenterView : BaseFormTableView
@property (nonatomic, copy) void(^openOrCloseSwitchBlock)(BOOL isOpen);
@property (nonatomic, assign) BOOL isOpen;
@end

NS_ASSUME_NONNULL_END
