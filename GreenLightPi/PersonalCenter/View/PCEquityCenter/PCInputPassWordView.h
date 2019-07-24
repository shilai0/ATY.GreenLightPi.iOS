//
//  PCInputPassWordView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/15.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN
@class PCSetCashOutPassWordView;
@interface PCInputPassWordView : BaseView
@property (nonatomic, strong) PCSetCashOutPassWordView *passWordView;
@property (nonatomic, copy) NSString *cashoutValue;
@end
NS_ASSUME_NONNULL_END
