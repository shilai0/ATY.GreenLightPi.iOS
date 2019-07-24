//
//  PCEditPersonalInfoViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/24.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

@class PersonalCenterUserModel;
@interface PCEditPersonalInfoViewController : BaseViewController
@property (nonatomic, strong) PersonalCenterUserModel *personalUserModel;
@property (nonatomic, copy) void(^updateInfoBlock)(PersonalCenterUserModel *personalUserModel);
@end
