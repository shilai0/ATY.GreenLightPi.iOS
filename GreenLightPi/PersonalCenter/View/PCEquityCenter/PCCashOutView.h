//
//  PCCashOutView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/13.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface PCCashOutView : BaseView
@property (nonatomic, copy) NSString *cashOutValue;
@property (nonatomic, copy) NSString *bankNameStr;
@property (nonatomic, strong) UITextField *inputTextField;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *cashOutAllBtn;
@end

NS_ASSUME_NONNULL_END
