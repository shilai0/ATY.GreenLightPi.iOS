//
//  FCCourseListViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/9/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCCourseListViewController.h"
#import "FamilyCoachViewModel.h"
#import "FCAudioListView.h"
#import "FcCoursesModel.h"
#import "FCAudioDetailViewController.h"
#import "FCCourseDetailViewController.h"
#import "FileEntityModel.h"

@interface FCCourseListViewController ()
@property (nonatomic, copy) NSNumber *fcModuleType;
@property (nonatomic, strong) FamilyCoachViewModel *familyCoachVM;
@property (nonatomic, strong) FCAudioListView *audioListView;
@property (nonatomic, strong) NSMutableArray *listData;
@property (nonatomic, strong) UIImageView *emImageView;
@property (nonatomic, strong) UILabel *emLabel;
@property (nonatomic, copy) NSString *navTitle;
@end

@implementation FCCourseListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    switch (self.classType) {
        case 0:
            self.navTitle = @"亲子沟通三步曲";
            self.fcModuleType = [NSNumber numberWithInteger:3];
            break;
        case 1:
            self.navTitle = @"家园共育八阶段";
            self.fcModuleType = [NSNumber numberWithInteger:4];
            break;
        case 2:
            self.navTitle = @"从游戏中培养孩子的能力";
            self.fcModuleType = [NSNumber numberWithInteger:1];
            break;
        case 3:
            self.navTitle = @"公开课";
            self.fcModuleType = [NSNumber numberWithInteger:2];
            break;
        default:
            break;
    }
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:self.navTitle titleColor:0x333333];
    
    [self requestData];
    
    [self creatUI];
}

- (void)creatEMUI {
    [self.view addSubview:self.emImageView];
    [self.view addSubview:self.emLabel];
    
    [self.emImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(@(134*KHEIGHTSCALE));
        make.width.height.equalTo(@125);
    }];
    
    [self.emLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.emImageView.mas_bottom).offset(6);
        make.height.equalTo(@15);
        make.width.equalTo(@200);
    }];
}

- (void)creatUI {
    [self.view addSubview:self.audioListView];
    @weakify(self);
    self.audioListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        FcCoursesModel *courseModel = dataArr[indexPath.row];
        if ([courseModel.coursesType integerValue] == 3) {
            FCAudioDetailViewController *audioDetailVC = [[FCAudioDetailViewController alloc] init];
            audioDetailVC.courses_id = courseModel.courses_id;
            [self.navigationController pushViewController:audioDetailVC animated:YES];
        } else if ([courseModel.coursesType integerValue] == 2) {
            FCCourseDetailViewController *courseDetailVC = [[FCCourseDetailViewController alloc] init];
            courseDetailVC.course_id = courseModel.courses_id;
            courseDetailVC.coverImageStr = courseModel.image.path;
            [self.navigationController pushViewController:courseDetailVC animated:YES];
        }
    };
}

- (void)requestData {
    NSMutableDictionary *params1 = [[NSMutableDictionary alloc] init];
    params1[@"fcModuleType"] = self.fcModuleType;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        params1[@"currentId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    } else {
        params1[@"currentId"] = [NSNumber numberWithInteger:0];
    }
    __block NSInteger pageindex = 1;
    params1[@"pageindex"] = [NSNumber numberWithInteger:1];
    params1[@"pagesize"] = [NSNumber numberWithInteger:8];
    @weakify(self);
    [[self.familyCoachVM.GetOpenClassCoursesCommand execute:params1] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            self.listData = [FcCoursesModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
            self.audioListView.dataArr = self.listData;
            [self.audioListView reloadData];
            pageindex = 2;
        }
    }];
    
    // 下拉刷新数据请求指令
    self.audioListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        params1[@"pageindex"] = [NSNumber numberWithInteger:1];
        @strongify(self);
        [self.audioListView.mj_header endRefreshing];
        [self.audioListView.mj_footer endRefreshing];
        [[self.familyCoachVM.GetAudioCoursesCommand execute:params1] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if (x != nil) {
                self.listData = [FcCoursesModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
                self.audioListView.dataArr = self.listData;
                [self.audioListView reloadData];
                pageindex = 2;
            }
        }];
    }];
    
    // 上拉加载更多数据指令
    self.audioListView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        params1[@"pageindex"] = [NSNumber numberWithInteger:pageindex];
        @strongify(self);
        
        [[self.familyCoachVM.GetAudioCoursesCommand execute:params1] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            [self.audioListView.mj_footer endRefreshing];
            if (x != nil) {
                self.listData = [FcCoursesModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
                NSMutableArray *oldArr = self.audioListView.dataArr;
                NSMutableArray *allDataArr = [NSMutableArray arrayWithArray:oldArr];
                [allDataArr addObjectsFromArray:self.listData];
                self.audioListView.dataArr = allDataArr;
                [self.audioListView reloadData];
                pageindex ++;
            }
        }];
        
    }];
    
}

- (UIImageView *)emImageView {
    if (!_emImageView) {
        _emImageView = [[UIImageView alloc] init];
        _emImageView.image = [UIImage imageNamed:@"em_default"];
    }
    return _emImageView;
}

- (UILabel *)emLabel {
    if (!_emLabel) {
        _emLabel = [[UILabel alloc] init];
        _emLabel.textColor = KHEXRGB(0x999999);
        _emLabel.font = [UIFont systemFontOfSize:14];
        _emLabel.text = @"本课程即将上线，敬请期待";
        _emLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _emLabel;
}

- (FamilyCoachViewModel *)familyCoachVM {
    if (!_familyCoachVM) {
        _familyCoachVM = [[FamilyCoachViewModel alloc] init];
    }
    return _familyCoachVM;
}

- (FCAudioListView *)audioListView {
    if (!_audioListView) {
        self.audioListView = [[FCAudioListView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight + 8, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - 8) style:UITableViewStylePlain];
    }
    return _audioListView;
}

@end
