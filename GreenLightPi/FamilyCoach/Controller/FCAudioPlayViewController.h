//
//  FCAudioPlayViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/20.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

@class FcCoursesModel;
@interface FCAudioPlayViewController : BaseViewController
@property (nonatomic, strong) FcCoursesModel *coursesModel;
@property (nonatomic, assign) NSInteger index;
@end
