//
//  PCAlreadyboughtCourseViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/26.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCAlreadyboughtCourseViewController.h"
#import "PCAlreadyBoughtCourseListView.h"
#import "PersonalCenterViewModel.h"
#import "FcCoursesModel.h"
#import "FCCourseDetailViewController.h"
#import "FCAudioDetailViewController.h"
#import "FileEntityModel.h"

@interface PCAlreadyboughtCourseViewController ()
@property (nonatomic, strong) PCAlreadyBoughtCourseListView *alreadyBoughtListView;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@end

@implementation PCAlreadyboughtCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"订阅课程" titleColor:0x333333];
    
    [self pc_requestData];
    [self pc_creatListView];
}

- (void)pc_requestData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    @weakify(self);
    [[self.personalCenterVM.GetOrderCourses execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            NSArray *dataArr = [FcCoursesModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
            self.alreadyBoughtListView.dataArr = [dataArr mutableCopy];
            [self.alreadyBoughtListView reloadData];
        }
    }];
}

- (void)pc_creatListView {
    [self.view addSubview:self.alreadyBoughtListView];
    
    @weakify(self);
    self.alreadyBoughtListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        FcCoursesModel *courseModel = dataArr[indexPath.row];
        if ([courseModel.coursesType integerValue] == 2) {
            FCCourseDetailViewController *detailVC = [[FCCourseDetailViewController alloc] init];
            detailVC.course_id = courseModel.courses_id;
            detailVC.coverImageStr = courseModel.image.path;
            [self.navigationController pushViewController:detailVC animated:YES];
        } else if ([courseModel.coursesType integerValue] == 3) {
            FCAudioDetailViewController *detailVC = [[FCAudioDetailViewController alloc] init];
            detailVC.courses_id = courseModel.courses_id;
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    };
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

- (PCAlreadyBoughtCourseListView *)alreadyBoughtListView {
    if (!_alreadyBoughtListView) {
        _alreadyBoughtListView = [[PCAlreadyBoughtCourseListView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStylePlain];
    }
    return _alreadyBoughtListView;
}

@end
