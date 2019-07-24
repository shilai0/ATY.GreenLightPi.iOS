//
//  FCCourseItemListView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/21.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseTableView.h"
@class FcCoursesModel;
@interface FCCourseItemListView : BaseTableView
@property (nonatomic, strong) FcCoursesModel *courseModel;
@end
