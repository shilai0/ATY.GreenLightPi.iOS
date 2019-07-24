//
//  FCCourseDetailViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

//@class FcCoursesModel;
@interface FCCourseDetailViewController : BaseViewController
//@property (nonatomic, strong) FcCoursesModel *coursesModel;
@property (nonatomic, strong) NSMutableArray <NSURL *>*assetURLs;
@property (nonatomic, copy) NSNumber *course_id;
@property (nonatomic, copy) NSString *coverImageStr;
@end
