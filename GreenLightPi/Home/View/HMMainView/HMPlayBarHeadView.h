//
//  HMPlayBarHeadView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/30.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@class MoreButton;
@interface HMPlayBarHeadView : BaseView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) MoreButton *moreBtn;
@end

NS_ASSUME_NONNULL_END
