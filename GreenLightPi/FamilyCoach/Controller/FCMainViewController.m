//
//  FCMainViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCMainViewController.h"
#import "FCMainListView.h"
#import "FamilyCoachViewModel.h"
#import "FcCoursesModel.h"
#import "FCCourseDetailViewController.h"
#import "FCMainListHeadView.h"
#import "UIButton+Common.h"
#import "ATYCache.h"
#import "FCAudioDetailViewController.h"
#import "FamilyIndexSectionView.h"
#import "AdModel.h"
#import "FileEntityModel.h"
#import "CommonSearchViewController.h"
#import "FCCourseListViewController.h"
#import "UserModel.h"

@interface FCMainViewController ()
@property (nonatomic, strong) FCMainListView *mainListView;
@property (nonatomic, strong) FCMainListHeadView *mainListHeadView;
@property (nonatomic, strong) FamilyCoachViewModel *familyCoachVM;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, strong) NSArray *homeCollegeArr;//居家学院
@property (nonatomic, strong) NSArray *openClassArr;//公开课
@property (nonatomic, strong) NSArray *magicianArr;//情绪魔法师
@property (nonatomic, strong) NSArray *eightStageArr;//家园共育八阶段
@property (nonatomic, strong) NSArray *adArr;//广告
@property (nonatomic, assign) NSInteger pageindex;
@end

@implementation FCMainViewController

- (FamilyCoachViewModel *)familyCoachVM {
    if (_familyCoachVM == nil) {
        _familyCoachVM = [[FamilyCoachViewModel alloc] init];
    }
    return _familyCoachVM;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fc_setNaView];
    [self fc_creatFcMainListView];
    [self fc_reaquestData];
}

- (void)fc_setNaView {
    UIView *headBackView = [UIView new];
    headBackView.backgroundColor = KHEXRGB(0xFFFFFF);
    [self.view addSubview:headBackView];
    
    self.searchButton = [[UIButton alloc] init];
    [self.searchButton setBackgroundColor:KHEXRGB(0xF2F2F2)];
    XSViewBorderRadius(self.searchButton, 16, 0, KHEXRGB(0xF2F2F2));
    [headBackView addSubview:self.searchButton];
    
    UIImageView *searchImageView = [[UIImageView alloc] init];
    searchImageView.image = [UIImage imageNamed:@"home_search"];
    [self.searchButton addSubview:searchImageView];
    
    UILabel *searchLabel = [[UILabel alloc] init];
    searchLabel.textColor = KHEXRGB(0x999999);
    searchLabel.font = [UIFont systemFontOfSize:12];
    searchLabel.text = @"搜索你想要的内容";
    [self.searchButton addSubview:searchLabel];
    
    [headBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@(KTopBarSafeHeight));
        make.height.equalTo(@85);
    }];
    
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(@29);
        make.height.equalTo(@35);
    }];
    
    [searchImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.centerY.equalTo(self.searchButton.mas_centerY);
        make.width.height.equalTo(@16);
    }];
    
    [searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchImageView.mas_right).offset(5);
        make.centerY.equalTo(self.searchButton.mas_centerY);
        make.height.equalTo(@12);
        make.width.equalTo(@150);
    }];
    
    @weakify(self);
    [[self.searchButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        CommonSearchViewController *searchVC = [[CommonSearchViewController alloc] init];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:searchVC];
        [self presentViewController:navController animated:YES completion:^{
            
        }];
    }];
}

- (void)fc_reaquestData {
    dispatch_group_t fcgroup =   dispatch_group_create();
    
    NSMutableDictionary *adParams = [[NSMutableDictionary alloc] init];
    adParams[@"type"] = [NSNumber numberWithInteger:2];
    @weakify(self);
    dispatch_group_enter(fcgroup);
    [[self.familyCoachVM.GetAdByTypeCommand execute:adParams] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            AdModel *adModel = [AdModel mj_objectWithKeyValues:x[@"Data"]];
            NSMutableArray *adMuArr = [[NSMutableArray alloc] init];
            [adModel.filelist enumerateObjectsUsingBlock:^(FileEntityModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [adMuArr addObject:obj.path];
            }];
            self.adArr = adMuArr;
        }
        dispatch_group_leave(fcgroup);
    }];
    
    //亲子沟通三步曲
    NSMutableDictionary *params1 = [[NSMutableDictionary alloc] init];
    params1[@"fcModuleType"] = [NSNumber numberWithInteger:3];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        params1[@"currentId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    } else {
        params1[@"currentId"] = [NSNumber numberWithInteger:0];
    }
    params1[@"pageindex"] = @0;
    params1[@"pagesize"] = @3;
    dispatch_group_enter(fcgroup);
    [[self.familyCoachVM.GetHomeCoursesCommand execute:params1] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            self.homeCollegeArr = [FcCoursesModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
        }
        dispatch_group_leave(fcgroup);
    }];

    //从游戏中培养孩子的能力
    NSMutableDictionary *params2 = [[NSMutableDictionary alloc] init];
    params2[@"fcModuleType"] = [NSNumber numberWithInteger:1];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        params2[@"currentId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    } else {
        params2[@"currentId"] = [NSNumber numberWithInteger:0];
    }
    params2[@"pageindex"] = @0;
    params2[@"pagesize"] = @3;
    dispatch_group_enter(fcgroup);
    [[self.familyCoachVM.GetMagicianCoursesCommand execute:params2] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            self.magicianArr = [FcCoursesModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
        }
        dispatch_group_leave(fcgroup);
    }];
    
    //公开课
    NSMutableDictionary *params3 = [[NSMutableDictionary alloc] init];
    params3[@"fcModuleType"] = [NSNumber numberWithInteger:2];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        params3[@"currentId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    } else {
        params3[@"currentId"] = [NSNumber numberWithInteger:0];
    }
    params3[@"pageindex"] = @0;
    params3[@"pagesize"] = @3;
    dispatch_group_enter(fcgroup);
    [[self.familyCoachVM.GetOpenClassCoursesCommand execute:params3] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            self.openClassArr = [FcCoursesModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
        }
        dispatch_group_leave(fcgroup);
    }];
    
    //家园共育八阶段
    NSMutableDictionary *params4 = [[NSMutableDictionary alloc] init];
    params4[@"fcModuleType"] = [NSNumber numberWithInteger:4];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        params4[@"currentId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    } else {
        params4[@"currentId"] = [NSNumber numberWithInteger:0];
    }
    params4[@"pageindex"] = @0;
    params4[@"pagesize"] = @3;
    dispatch_group_enter(fcgroup);
    [[self.familyCoachVM.GeteEightStageCoursesCommand execute:params4] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            self.eightStageArr = [FcCoursesModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
        }
        dispatch_group_leave(fcgroup);
    }];
    
    dispatch_group_notify(fcgroup, dispatch_get_main_queue(), ^{
        self.mainListHeadView.bannerArr = self.adArr;
        if (NilOrNull(self.homeCollegeArr)) {
            self.homeCollegeArr = @[];
        }
        if (NilOrNull(self.eightStageArr)) {
            self.eightStageArr = @[];
        }
        if (NilOrNull(self.openClassArr)) {
            self.openClassArr = @[];
        }
        if (NilOrNull(self.magicianArr)) {
            self.magicianArr = @[];
        }
        
        NSMutableArray *dataArr = [[NSMutableArray alloc] initWithObjects:self.homeCollegeArr,self.eightStageArr,self.magicianArr,self.openClassArr,nil];
        self.mainListView.dataArr = dataArr;
        [self.mainListView reloadData];
    });
    
    // 下拉刷新数据请求指令
    self.mainListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.mainListView.mj_header endRefreshing];
        [self.mainListView.mj_footer endRefreshing];
        [self fc_reaquestData];
    }];
}

- (void)fc_creatFcMainListView {
    self.mainListView = [[FCMainListView alloc] initWithFrame:CGRectMake(0, 85+KTopBarSafeHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - 85 - KTabBarHeight - KTopBarSafeHeight) style:UITableViewStyleGrouped];
    self.mainListHeadView = [[FCMainListHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 136*KHEIGHTSCALE + 8)];
    self.mainListView.tableHeaderView = self.mainListHeadView;
    [self.view addSubview:self.mainListView];

    @weakify(self);
    
    self.mainListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        FcCoursesModel *model = dataArr[indexPath.section][indexPath.row];
        
        if ([model.coursesType integerValue] == 2) {
            FCCourseDetailViewController *courseDetailVC = [[FCCourseDetailViewController alloc] init];
            courseDetailVC.course_id = model.courses_id;
            courseDetailVC.coverImageStr = model.image.path;
            [self.navigationController pushViewController:courseDetailVC animated:YES];
        } else if ([model.coursesType integerValue] == 3) {
            FCAudioDetailViewController *audioDetailVC = [[FCAudioDetailViewController alloc] init];
            audioDetailVC.courses_id = model.courses_id;
            [self.navigationController pushViewController:audioDetailVC animated:YES];
        }
    };
    
    self.mainListView.headzeroview.moreBtnBlock = ^{
        @strongify(self);
        FCCourseListViewController *courseListVC = [[FCCourseListViewController alloc] init];
        courseListVC.classType = ClassTypehomeCollege;
        [self.navigationController pushViewController:courseListVC animated:YES];
    };
    
    self.mainListView.headoneview.moreBtnBlock = ^{
        @strongify(self);
        FCCourseListViewController *courseListVC = [[FCCourseListViewController alloc] init];
        courseListVC.classType = ClassTypeEightStage;
        [self.navigationController pushViewController:courseListVC animated:YES];
    };
    
    self.mainListView.headtwoview.moreBtnBlock = ^{
        @strongify(self);
        FCCourseListViewController *courseListVC = [[FCCourseListViewController alloc] init];
        courseListVC.classType = ClassTypemagician;
        [self.navigationController pushViewController:courseListVC animated:YES];
    };
    
    self.mainListView.headthreeview.moreBtnBlock = ^{
        @strongify(self);
        FCCourseListViewController *courseListVC = [[FCCourseListViewController alloc] init];
        courseListVC.classType = ClassTypeopenClass;
        [self.navigationController pushViewController:courseListVC animated:YES];
    };
    
//    self.mainListView.switchBlock = ^{
//        @strongify(self);
//        [self fc_switchData];
//    };
}

@end
