//
//  FCEvaluateViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/21.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

@class FcCoursesModel;
@interface FCEvaluateViewController : BaseViewController
@property (nonatomic, strong) FcCoursesModel *coursesModel;
@property (nonatomic, copy) void(^evaluateBlock)(void);
@end
