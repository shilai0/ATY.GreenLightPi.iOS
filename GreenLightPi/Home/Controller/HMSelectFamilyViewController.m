//
//  HMSelectFamilyViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/29.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMSelectFamilyViewController.h"
#import "HMFamilyDetailViewController.h"
#import "MainTabBarViewController.h"
#import "HMBabyInfoViewController.h"
#import "HMSelectFamilyListView.h"
#import "HMNOFamilyTipView.h"
#import "FamilyApiModel.h"
#import "HomeViewModel.h"
#import "AppDelegate.h"


@interface HMSelectFamilyViewController ()
@property (nonatomic, strong) HMSelectFamilyListView *selectFamilyListView;
@property (nonatomic, strong) HomeViewModel *homeVM;
@property (nonatomic, strong) HMNOFamilyTipView *noFamilyTipView;
@end

@implementation HMSelectFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self aty_setLeftNavItemImg:nil title:@"关闭" titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    if (self.pushFamilyType == PushFamilyTypeDefault) {
        [self aty_setCenterNavItemtitle:@"选择家庭" titleColor:0x333333];
    } else {
        [self aty_setCenterNavItemtitle:@"我的家庭组" titleColor:0x333333];
    }
    
    [self.view addSubview:self.selectFamilyListView];
    [self.view addSubview:self.noFamilyTipView];
    self.selectFamilyListView.hidden = YES;
    self.noFamilyTipView.hidden = YES;
    [self.selectFamilyListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@(KNavgationBarHeight));
    }];
    [self requestMyFamilyMemberData];
    
    self.selectFamilyListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        HMFamilyDetailViewController *familyDetailVC = [[HMFamilyDetailViewController alloc] init];
        FamilyApiModel *familyModel = dataArr[indexPath.row];
        NSArray *nameArr = [[NSArray alloc] initWithObjects:@"妈妈",@"爸爸",@"爷爷",@"奶奶",@"外公",@"外婆", nil];
        NSArray *relationArr = [[NSArray alloc] initWithObjects:@"mother",@"father",@"grandpa",@"grandma",@"grandFather",@"grandMother", nil];

        NSMutableArray *modelArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < nameArr.count; i ++) {
            FamilyMemberApiModel *memberModel = [[FamilyMemberApiModel alloc] init];
            memberModel.relationRemark = nameArr[i];
            memberModel.relationCode = relationArr[i];
            memberModel.familyId = familyModel.familyId;
            [modelArr addObject:memberModel];
        }
        
        [familyModel.familyMembers enumerateObjectsUsingBlock:^(FamilyMemberApiModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.relationCode isEqualToString:@"mother"]) {
                [modelArr enumerateObjectsUsingBlock:^(FamilyMemberApiModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.relationCode isEqualToString:@"mother"]) {
                        [modelArr removeObject:obj];
                    }
                }];
            }
            
            if ([obj.relationCode isEqualToString:@"father"]) {
                [modelArr enumerateObjectsUsingBlock:^(FamilyMemberApiModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.relationCode isEqualToString:@"father"]) {
                        [modelArr removeObject:obj];
                    }
                }];
            }
            
            if ([obj.relationCode isEqualToString:@"grandpa"]) {
                [modelArr enumerateObjectsUsingBlock:^(FamilyMemberApiModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.relationCode isEqualToString:@"grandpa"]) {
                        [modelArr removeObject:obj];
                    }
                }];
            }
            
            if ([obj.relationCode isEqualToString:@"grandma"]) {
                [modelArr enumerateObjectsUsingBlock:^(FamilyMemberApiModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.relationCode isEqualToString:@"grandma"]) {
                        [modelArr removeObject:obj];
                    }
                }];
            }
            
            if ([obj.relationCode isEqualToString:@"grandFather"]) {
                [modelArr enumerateObjectsUsingBlock:^(FamilyMemberApiModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.relationCode isEqualToString:@"grandFather"]) {
                        [modelArr removeObject:obj];
                    }
                }];
            }
            
            if ([obj.relationCode isEqualToString:@"grandMother"]) {
                [modelArr enumerateObjectsUsingBlock:^(FamilyMemberApiModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj.relationCode isEqualToString:@"grandMother"]) {
                        [modelArr removeObject:obj];
                    }
                }];
            }
            
        }];
        
        familyDetailVC.dataArray = [[NSMutableArray alloc] initWithObjects:familyModel.familyMembers,modelArr, nil];
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID] integerValue] == familyModel.userId) {
            familyDetailVC.isCreater = YES;
        } else {
            familyDetailVC.isCreater = NO;
        }
        [self.navigationController pushViewController:familyDetailVC animated:YES];
    };
    
    self.noFamilyTipView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0://添加宝宝
            {
                HMBabyInfoViewController *babyInfoVC = [[HMBabyInfoViewController alloc] init];
                if (self.pushFamilyType == 0) {
                    babyInfoVC.babyInfoType = BabyInfoTypeSelectAdd;
                } else {
                    babyInfoVC.babyInfoType = BabyInfoTypeMyFamilyAdd;
                }
                @weakify(self);
                babyInfoVC.saveBlock = ^{
                    @strongify(self);
                    if (self.addBabyBlock) {
                        self.addBabyBlock();
                    }
                };
                [self.navigationController pushViewController:babyInfoVC animated:YES];
            }
                break;
            case 1://激活盒子
            {
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                MainTabBarViewController *tabViewController = (MainTabBarViewController *) appDelegate.window.rootViewController;
                [tabViewController setSelectedIndex:3];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
                break;
            default:
                break;
        }
    };
    
    //接收移除家庭成员的通知，重新请求我的家庭组数据
    [[KNotificationCenter rac_addObserverForName:DELETEFAMILYMEMBER_NOTIFICATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self requestMyFamilyMemberData];
    }];
}

- (void)requestMyFamilyMemberData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    @weakify(self);
    [[self.homeVM.GetFamilyMemberCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            self.selectFamilyListView.dataArr = [FamilyApiModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
            [self.selectFamilyListView reloadData];
            if (self.selectFamilyListView.dataArr.count > 0) {
                self.selectFamilyListView.hidden = NO;
                self.noFamilyTipView.hidden = YES;
            } else {
                self.selectFamilyListView.hidden = YES;
                self.noFamilyTipView.hidden = NO;
            }
        }
    }];
}

- (HMSelectFamilyListView *)selectFamilyListView {
    if (!_selectFamilyListView) {
        _selectFamilyListView = [[HMSelectFamilyListView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _selectFamilyListView;
}

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

- (HMNOFamilyTipView *)noFamilyTipView {
    if (!_noFamilyTipView) {
        _noFamilyTipView = [[HMNOFamilyTipView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight)];
    }
    return _noFamilyTipView;
}

- (void)dealloc {
    [KNotificationCenter removeObserver:self];
}

@end
