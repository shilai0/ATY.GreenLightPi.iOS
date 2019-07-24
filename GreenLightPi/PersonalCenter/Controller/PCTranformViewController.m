//
//  PCTranformViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/12.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCTranformViewController.h"
#import "PersonalCenterViewModel.h"
#import "ATYAlertViewController.h"
#import "PCTransformView.h"
#import "FamilyApiModel.h"
#import "HomeViewModel.h"

@interface PCTranformViewController ()
@property (nonatomic, strong) PCTransformView *tranformListView;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, strong) HomeViewModel *homeVM;
@end

@implementation PCTranformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"转移乐园权限" titleColor:0x333333];
    
    [self.view addSubview:self.tranformListView];
    [self requestMyFamilyData];
    
    self.tranformListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        FamilyMemberApiModel *memberModel = dataArr[indexPath.row];
        ATYAlertViewController *alertCtrl = [ATYAlertViewController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"确定把权限转移给%@？",memberModel.relationRemark]];
        alertCtrl.messageAlignment = NSTextAlignmentCenter;
        ATYAlertAction *cancel = [ATYAlertAction actionWithTitle:@"取消" titleColor:0x1F1F1F handler:nil];
        ATYAlertAction *done = [ATYAlertAction actionWithTitle:@"确定" titleColor:0x1F1F1F handler:^(ATYAlertAction *action) {
            [self transformPark:memberModel];
        }];
        
        [alertCtrl addAction:cancel];
        [alertCtrl addAction:done];
        [self presentViewController:alertCtrl animated:NO completion:nil];
    };
    
}

- (void)requestMyFamilyData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    [[self.homeVM.GetFamilyMemberCommand execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            @weakify(self);
            NSArray *familyArr = [FamilyApiModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
            [familyArr enumerateObjectsUsingBlock:^(FamilyApiModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                @strongify(self);
                if (obj.userId == [[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID] integerValue]) {
                    NSMutableArray *memberArr = [[NSMutableArray alloc] initWithArray:obj.familyMembers];
                    [memberArr enumerateObjectsUsingBlock:^(FamilyMemberApiModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (obj.userId == [[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID] integerValue]) {
                            [memberArr removeObject:obj];
                            *stop = YES;
                        }
                    }];
                    self.tranformListView.dataArr = memberArr;
                    [self.tranformListView reloadData];
                }
            }];
        }
    }];
}

#pragma mark -- 转移权限
- (void)transformPark:(FamilyMemberApiModel *)memberModel {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"boxId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_BOXID];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"targetUserId"] = [NSNumber numberWithInteger:memberModel.userId];
    @weakify(self);
    [[self.personalCenterVM.TransferBox execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            [ATYToast aty_bottomMessageToast:@"转移权限成功！"];
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:PROJECT_BOXID];
            [KNotificationCenter postNotificationName:TRANSFORMPARK_NOTIFICATION object:nil];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } else {
            [ATYToast aty_bottomMessageToast:@"转移权限操作失败！"];
        }
    }];
}

- (PCTransformView *)tranformListView {
    if (!_tranformListView) {
        _tranformListView = [[PCTransformView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStyleGrouped];
        _tranformListView.isTransform = YES;
    }
    return _tranformListView;
}

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

@end
