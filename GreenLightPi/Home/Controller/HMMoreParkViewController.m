//
//  HMMoreParkViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/3.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMoreParkViewController.h"
#import "HMParkUsageViewController.h"
#import "HMMoreParkListView.h"

@interface HMMoreParkViewController ()
@property (nonatomic, strong) HMMoreParkListView *moreParkListView;
@end

@implementation HMMoreParkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self aty_setCenterNavItemtitle:@"更多家人盒子" titleColor:0x333333];
    [self.view addSubview:self.moreParkListView];
    self.moreParkListView.dataArr = [self.parkListArr mutableCopy];
    [self.moreParkListView reloadData];
    
    self.moreParkListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        HMParkUsageViewController *parkUsageVC = [[HMParkUsageViewController alloc] init];
        parkUsageVC.parkListArr = self.parkListArr;
        parkUsageVC.boxListArr = self.boxListArr;
        parkUsageVC.useLogModel = self.boxListArr[indexPath.row];
        parkUsageVC.pushType = self.pushType;
        [self.navigationController pushViewController:parkUsageVC animated:YES];
    };
}

- (HMMoreParkListView *)moreParkListView {
    if (!_moreParkListView) {
        _moreParkListView = [[HMMoreParkListView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - KBottomSafeHeight) style:UITableViewStylePlain];
    }
    return _moreParkListView;
}

@end
