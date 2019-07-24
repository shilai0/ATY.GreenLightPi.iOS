//
//  HMMainSectionHeadView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/20.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMMainSectionHeadView : BaseView
@property (nonatomic, assign) BOOL display;//0: 不显示 1: 显示
@property (nonatomic, strong) NSDictionary *dataDic;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) UILabel *titleLabel;
@end

NS_ASSUME_NONNULL_END
