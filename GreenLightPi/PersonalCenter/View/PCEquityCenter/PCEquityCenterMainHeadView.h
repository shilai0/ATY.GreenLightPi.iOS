//
//  PCEquityCenterMainHeadView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/6.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN
@class IncomeCenterModel;
@interface PCEquityCenterMainHeadView : BaseView
@property (nonatomic, strong) IncomeCenterModel *incomeModel;
@property (nonatomic, copy) void(^profitClickBlock)(NSArray *profitArr,NSInteger index);
@end

NS_ASSUME_NONNULL_END
