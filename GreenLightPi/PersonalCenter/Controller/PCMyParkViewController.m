//
//  PCMyParkViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/11.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCMyParkViewController.h"
#import "PCParentCenterViewController.h"
#import "HMParkUsageViewController.h"
#import "PCTranformViewController.h"
#import "PCMyParkListView.h"

@interface PCMyParkViewController ()
@property (nonatomic, strong) PCMyParkListView *myParkListView;
@end

@implementation PCMyParkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0
                      leftBlock:^{
                          @strongify(self);
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
    
    [self aty_setCenterNavItemtitle:@"我的乐园" titleColor:0x333333];
    
    [self.view addSubview:self.myParkListView];
    self.myParkListView.dataArr = [[NSMutableArray alloc] initWithArray:@[@{@"title":@"使用统计",@"imageName":@"statistics"},@{@"title":@"家长中心",@"imageName":@"parentCenter"},@{@"title":@"权限转移",@"imageName":@"permissionTransfer"}]];
    [self.myParkListView reloadData];
    
    self.myParkListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        switch (indexPath.section) {
            case 0:
            {
                HMParkUsageViewController *parkUsageVC = [[HMParkUsageViewController alloc] init];
                parkUsageVC.pushType = PersonalCenter;
                [self.navigationController pushViewController:parkUsageVC animated:YES];
            }
                break;
            case 1:
            {
                PCParentCenterViewController *parentCenterVC = [[PCParentCenterViewController alloc] init];
                [self.navigationController pushViewController:parentCenterVC animated:YES];
            }
                break;
            case 2:
            {
                PCTranformViewController *tranformVC = [[PCTranformViewController alloc] init];
                [self.navigationController pushViewController:tranformVC animated:YES];
            }
                break;
            default:
                break;
        }
    };
}

- (PCMyParkListView *)myParkListView {
    if (!_myParkListView) {
        _myParkListView = [[PCMyParkListView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStyleGrouped];
    }
    return _myParkListView;
}

@end
