//
//  FCAudioPlayView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/15.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseView.h"

@class FcCoursesModel;
@interface FCAudioPlayView : BaseView
@property (nonatomic ,strong) FcCoursesModel *coursesModel;
@property (nonatomic, assign) NSInteger index;
@end
