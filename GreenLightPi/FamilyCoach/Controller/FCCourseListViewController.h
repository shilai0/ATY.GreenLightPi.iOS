//
//  FCCourseListViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/9/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,ClassType){
    ClassTypehomeCollege = 0, //居家学院三步曲
    ClassTypeEightStage,//家园共育八阶段
    ClassTypemagician,//从游戏中培养孩子的能力
    ClassTypeopenClass,//公开课
};

@interface FCCourseListViewController : BaseViewController
@property (nonatomic, assign) ClassType classType;
@end
