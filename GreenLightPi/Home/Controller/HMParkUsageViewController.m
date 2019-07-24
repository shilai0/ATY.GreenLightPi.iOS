//
//  HMParkUsageViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/3.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMParkUsageViewController.h"
#import "MainTabBarViewController.h"
#import "HMMoreParkViewController.h"
#import "PCMyParkViewController.h"
#import "HMMainViewController.h"
#import "HMParkUsageListView.h"
#import "HMParkUsageHeadView.h"
#import "UserUseLogModel.h"
#import "HomeViewModel.h"
#import "LSPPageView.h"

@interface HMParkUsageViewController ()<LSPPageViewDelegate>
@property (nonatomic, strong) HMParkUsageListView *parkUsageListView;
@property (nonatomic, strong) HMParkUsageHeadView *parkHeadView;
@property (nonatomic, strong) NSMutableArray *childVcArray;
@property (nonatomic, strong) HomeViewModel *homeVM;
@end

@implementation HMParkUsageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self backAction];
    }];
    
    [self aty_setCenterNavItemtitle:@"独角兽乐园使用情况" titleColor:0x333333];
    
    [self aty_setRightNavItemImg:@"morePark" title:nil titleColor:0 rightBlock:^{
        @strongify(self);
        [self moreParkAction];
    }];
    
    if (!self.useLogModel) {
        [self requestData];
    }
}

#pragma mark -- 请求乐园使用详情数据
- (void)requestData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    //获取一家老小盒子使用情况数据
    [[self.homeVM.GetUserBoxListCommand execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            NSArray *dataArr = [UserUseLogModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
            NSMutableArray *parkArr = [[NSMutableArray alloc] init];
            NSMutableArray *boxArr = [[NSMutableArray alloc] init];
            @weakify(self);
            [dataArr enumerateObjectsUsingBlock:^(UserUseLogModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                @strongify(self);
                if (obj.useLogModels.count) {
                    [boxArr addObject:obj];
                    UseLogModel *model = [obj.useLogModels firstObject];
                    model.boxName = obj.boxName;
                    [parkArr addObject:model];
                }
                if (obj.userId == [[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID] integerValue]) {
                    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:obj.boxId] forKey:PROJECT_BOXID];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    self.useLogModel = obj;
                }
            }];
            self.parkListArr = parkArr;
            self.boxListArr = boxArr;
        }
    }];
}

- (void)setUseLogModel:(UserUseLogModel *)useLogModel {
    _useLogModel = useLogModel;
    NSMutableArray *titleArr = [[NSMutableArray alloc] init];
    [_useLogModel.useLogModels enumerateObjectsUsingBlock:^(UseLogModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [titleArr addObject:obj.date];
    }];
    for (int i = 0; i < titleArr.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        self.parkUsageListView = [[HMParkUsageListView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - 44) style:UITableViewStyleGrouped];
        self.parkUsageListView.tag = 10 + i;
        [vc.view addSubview:self.parkUsageListView];
        [self.childVcArray addObject:vc];
        UseLogModel *useModel = self.useLogModel.useLogModels[i];
        useModel.isOpen = NO;
        __block NSInteger longDuration;
        [useModel.useDetails enumerateObjectsUsingBlock:^(UseDetailModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (idx == 0) {
                longDuration = obj.duration;
            }
            obj.longDuration = longDuration;
        }];
        NSArray *detailArr = nil;
        if (useModel.useDetails.count > 3) {
            detailArr = [useModel.useDetails subarrayWithRange:NSMakeRange(0, 3)];
        } else {
            detailArr = useModel.useDetails;
        }
        self.parkUsageListView.dataArr = [[NSMutableArray alloc] initWithObjects:[[NSArray alloc] initWithObjects:useModel, nil],detailArr, nil];
        [self.parkUsageListView reloadData];
        [self currentListView:self.parkUsageListView currentModel:useModel];
    }
    if (titleArr.count > 0) {
        LSPTitleStyle *style = [[LSPTitleStyle alloc] init];
        style.index = 0;
        style.isAverage = YES;
        style.isNeedScale = YES;
        style.isShowBottomLine = YES;
        style.normalColor = KHEXRGB(0x646464);
        style.font = [UIFont boldSystemFontOfSize:14];
        LSPPageView *pageView = [[LSPPageView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) titles:titleArr style:style childVcs:self.childVcArray.mutableCopy parentVc:self];
        pageView.delegate = self;
        pageView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:pageView];
    }
}

- (void)currentListView:(HMParkUsageListView *)parkUsageListView currentModel:(UseLogModel *)useModel{
    @weakify(parkUsageListView);
    parkUsageListView.openOrCloseBlock = ^(BOOL isOpen){
        @strongify(parkUsageListView);
        if (isOpen) {
            parkUsageListView.dataArr = [[NSMutableArray alloc] initWithObjects:[[NSArray alloc] initWithObjects:useModel, nil],useModel.useDetails, nil];
        } else {
           parkUsageListView.dataArr = [[NSMutableArray alloc] initWithObjects:[[NSArray alloc] initWithObjects:useModel, nil],[useModel.useDetails subarrayWithRange:NSMakeRange(0, 3)], nil];
        }
        [parkUsageListView reloadData];
    };
}

#pragma mark -- 返回
- (void)backAction {
    switch (self.pushType) {
        case 0:
        {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[HMMainViewController class]]) {
                    HMMainViewController *vc = (HMMainViewController *)controller;
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }
            break;
        case 1:
        {
            MainTabBarViewController *mainTabBarVC = [[MainTabBarViewController alloc] init];
            mainTabBarVC.isFirstRegister = NO;
            // 添加动画效果
            mainTabBarVC.view.layer.transform = CATransform3DMakeScale(1.3, 1.3, 0);
            [UIView animateWithDuration:0.35 animations:^{
                mainTabBarVC.view.layer.transform = CATransform3DIdentity;
                UIWindow *window = [UIApplication sharedApplication].keyWindow;
                window.rootViewController = mainTabBarVC;
            }];
        }
            break;
        case 2:
        {
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[PCMyParkViewController class]]) {
                    PCMyParkViewController *vc = (PCMyParkViewController *)controller;
                    [self.navigationController popToViewController:vc animated:YES];
                }
            }
        }
            break;
        default:
            break;
    }
}

#pragma mark -- 更多
- (void)moreParkAction {
    HMMoreParkViewController *moreParkVC = [[HMMoreParkViewController alloc] init];
    moreParkVC.parkListArr = self.parkListArr;
    moreParkVC.useLogModel = self.useLogModel;
    moreParkVC.pushType = self.pushType;
    moreParkVC.boxListArr = self.boxListArr;
    [self.navigationController pushViewController:moreParkVC animated:YES];
}

#pragma mark - LSPPageViewDelegate
- (void)pageViewScollEndView:(LSPPageView *)pageView WithIndex:(NSInteger)index {
    UIViewController *vc = self.childVcArray[index];
    HMParkUsageListView *currentUsageListView = [vc.view viewWithTag:(10 + index)];
    [currentUsageListView reloadData];
}

- (HMParkUsageHeadView *)parkHeadView {
    if (!_parkHeadView) {
        _parkHeadView = [[HMParkUsageHeadView alloc] init];
    }
    return _parkHeadView;
}

- (NSMutableArray *)childVcArray {
    if (!_childVcArray) {
        _childVcArray = [[NSMutableArray alloc] init];
    }
    return _childVcArray;
}

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

- (NSMutableArray *)parkListArr {
    if (!_parkListArr) {
        _parkListArr = [[NSMutableArray alloc] init];
    }
    return _parkListArr;
}

- (NSMutableArray *)boxListArr {
    if (!_boxListArr) {
        _boxListArr = [[NSMutableArray alloc] init];
    }
    return _boxListArr;
}

@end
