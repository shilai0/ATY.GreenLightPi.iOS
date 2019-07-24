//
//  HMMyBabyViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/29.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMyBabyViewController.h"
#import "HMSelectFamilyViewController.h"
#import "HMBabyInfoViewController.h"
#import "HMMyBabyListView.h"
#import "HMMyBabyHeadView.h"
#import "HomeViewModel.h"
#import "BabyModel.h"

@interface HMMyBabyViewController ()
@property (nonatomic, strong) HMMyBabyListView *myBabyListView;
@property (nonatomic, strong) HomeViewModel *homeVM;
@property (nonatomic, strong) HMMyBabyHeadView *myBabyHeadView;
/**
 宝宝列表数组
 */
@property (nonatomic, strong) NSMutableArray *babyArr;
@end

@implementation HMMyBabyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHEXRGB(0xF7F7F7);
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"宝宝" titleColor:0x333333];
    
    [self creatMyBabyViews];
    [self requestMyBabyListData];
}

- (void)requestMyBabyListData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    params[@"userId"] = [userDefaults objectForKey:PROJECT_USER_ID];
    @weakify(self);
    //获取宝宝列表
    [[self.homeVM.getBabyListCommand execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            @strongify(self);
            self.babyArr = [BabyModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
            self.myBabyListView.dataArr = self.babyArr;
            [self.myBabyListView reloadData];
        }
    }];
}

- (void)creatMyBabyViews {
    [self.view addSubview:self.myBabyListView];
    self.myBabyListView.tableHeaderView = self.myBabyHeadView;

    [self.myBabyListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@(KNavgationBarHeight));
    }];
    
    @weakify(self);
    self.myBabyHeadView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0:
            {
                if (self.myBabyListView.dataArr.count > 2) {
                    [ATYToast aty_bottomMessageToast:@"您最多只可以添加三个宝宝哦！"];
                    return ;
                }
                HMBabyInfoViewController *babyInfoVC = [[HMBabyInfoViewController alloc] init];
                babyInfoVC.babyInfoType = BabyInfoTypeAdd;
                @weakify(self);
                babyInfoVC.saveBlock = ^{
                    @strongify(self);
                    [self requestMyBabyListData];
                };
                [self.navigationController pushViewController:babyInfoVC animated:YES];
            }
                break;
            case 1:
            {
                HMSelectFamilyViewController *selectFamilyVC = [[HMSelectFamilyViewController alloc] init];
                @weakify(self);
                selectFamilyVC.addBabyBlock = ^{
                    @strongify(self);
                    [self requestMyBabyListData];
                };
                [self.navigationController pushViewController:selectFamilyVC animated:YES];
            }
                break;
            default:
                break;
        }
    };
    
    self.myBabyListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        HMBabyInfoViewController *babyInfoVC = [[HMBabyInfoViewController alloc] init];
        babyInfoVC.babyModel = dataArr[indexPath.row];
        @weakify(self);
        babyInfoVC.saveBlock = ^{
            @strongify(self);
            [self requestMyBabyListData];
        };
        [self.navigationController pushViewController:babyInfoVC animated:YES];
    };
}

#pragma mark -- 懒加载

- (HMMyBabyListView *)myBabyListView {
    if (!_myBabyListView) {
        _myBabyListView = [[HMMyBabyListView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _myBabyListView;
}

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

- (HMMyBabyHeadView *)myBabyHeadView {
    if (!_myBabyHeadView) {
        _myBabyHeadView = [[HMMyBabyHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 119)];
    }
    return _myBabyHeadView;
}

@end
