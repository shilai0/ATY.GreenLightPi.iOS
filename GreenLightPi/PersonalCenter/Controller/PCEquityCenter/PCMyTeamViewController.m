//
//  PCMyTeamViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/10.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCMyTeamViewController.h"
#import "PCMyTeamHeadView.h"
#import "PCMyTeamVIew.h"
#import "PersonalCenterViewModel.h"
#import "MyTeamModel.h"

@interface PCMyTeamViewController ()
@property (nonatomic, strong) PCMyTeamHeadView *myTeamHeadView;
@property (nonatomic, strong) PCMyTeamVIew *myTeamView;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@end

@implementation PCMyTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0
                      leftBlock:^{
                          @strongify(self);
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
    
    [self aty_setCenterNavItemtitle:@"我的团队" titleColor:0x333333];
    [self creatMyTeamViews];
    [self getMyTeamData:0];
}

- (void)creatMyTeamViews {
    [self.view addSubview:self.myTeamHeadView];
    [self.myTeamHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@(KNavgationBarHeight));
        make.height.equalTo(@50);
    }];
    
    //UserGrade (string, optional): 用户分销等级 //A联合创始人 B城市合伙人 C推广合伙人 D消费代言人 E普通用户c
    if ([self.userLevel isEqualToString:@"A"]) {
        self.myTeamHeadView.userLevelArr = @[@"城市合伙人",@"推广合伙人"];
    } else if ([self.userLevel isEqualToString:@"B"]) {
        self.myTeamHeadView.userLevelArr = @[@"推广合伙人",@"消费代言人"];
    } else if ([self.userLevel isEqualToString:@"C"]) {
        self.myTeamHeadView.userLevelArr = @[@"消费代言人"];
    }
    
    [self.view addSubview:self.myTeamView];
    
    @weakify(self);
    self.myTeamHeadView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        if ([self.userLevel isEqualToString:@"A"]) {
            [self getMyTeamData:index + 2];
        } else if ([self.userLevel isEqualToString:@"B"]) {
            [self getMyTeamData:index + 3];
        } else if ([self.userLevel isEqualToString:@"C"]) {
            [self getMyTeamData:index + 4];
        }
    };
    
}

- (void)getMyTeamData:(NSInteger)userLevel {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    if (userLevel != 0) {
        params[@"userLevel"] = [NSNumber numberWithInteger:userLevel];
    } else {
        if ([self.userLevel isEqualToString:@"A"]) {
            params[@"userLevel"] = [NSNumber numberWithInteger:2];
        } else if ([self.userLevel isEqualToString:@"B"]) {
            params[@"userLevel"] = [NSNumber numberWithInteger:3];
        } else if ([self.userLevel isEqualToString:@"C"]) {
            params[@"userLevel"] = [NSNumber numberWithInteger:4];
        }
    }
    params[@"pageIndex"] = [NSNumber numberWithInteger:1];
    params[@"pageSize"] = [NSNumber numberWithInteger:8];
    @weakify(self);
    [[self.personalCenterVM.GetMyTeamForApp execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            NSMutableArray *dataArr = [MyTeamModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
            self.myTeamView.dataArr = dataArr;
            [self.myTeamView reloadData];
        }
    }];
}

- (PCMyTeamHeadView *)myTeamHeadView {
    if (!_myTeamHeadView) {
        _myTeamHeadView = [[PCMyTeamHeadView alloc] init];
    }
    return _myTeamHeadView;
}

- (PCMyTeamVIew *)myTeamView {
    if (!_myTeamView) {
        _myTeamView = [[PCMyTeamVIew alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight + 50, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - 50) style:UITableViewStylePlain];
    }
    return _myTeamView;
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

@end
