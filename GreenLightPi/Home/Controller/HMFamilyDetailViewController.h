//
//  HMFamilyDetailViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/9.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HMFamilyDetailViewController : BaseViewController
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) BOOL isCreater;//是否是家庭组创建者
@end

NS_ASSUME_NONNULL_END
