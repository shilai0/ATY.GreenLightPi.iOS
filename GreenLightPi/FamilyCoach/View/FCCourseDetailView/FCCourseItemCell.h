//
//  FCCourseItemCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/21.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FcCoursesModel,FcCoursesDetailModel;
@interface FCCourseItemCell : UITableViewCell
@property (nonatomic, strong) FcCoursesDetailModel *courseDetailModel;
@property (nonatomic, strong) FcCoursesModel *courseModel;
@end
