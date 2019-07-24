//
//  HMManageFamilyViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/19.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMManageFamilyViewController.h"
#import "HMSelectFamilyViewController.h"
#import "ATYAlertViewController.h"
#import "PCTransformView.h"
#import "FamilyApiModel.h"
#import "HomeViewModel.h"

@interface HMManageFamilyViewController ()
@property (nonatomic, strong) PCTransformView *tranformListView;
@property (nonatomic, strong) HomeViewModel *homeVM;
@property (nonatomic, strong) UIButton *deleteBtn;
@end

@implementation HMManageFamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"管理家人" titleColor:0x333333];
    
    [self.view addSubview:self.tranformListView];
    self.tranformListView.dataArr = self.familyMemberArr;
    [self.tranformListView reloadData];
    [self.tranformListView setEditing:YES];
    
    [self.view addSubview:self.deleteBtn];
    self.deleteBtn.hidden = YES;
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(@(-KBottomSafeHeight));
        make.height.equalTo(@49);
    }];
    
    self.tranformListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        NSArray *indexPaths = [self.tranformListView indexPathsForSelectedRows];
        if (indexPaths.count > 0) {
            self.deleteBtn.hidden = NO;
            [self.deleteBtn setTitle:[NSString stringWithFormat:@"移除此家人（%lu）",indexPaths.count] forState:UIControlStateNormal];
        } else {
            self.deleteBtn.hidden = YES;
        }
    };
    
    [[self.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        
        ATYAlertViewController *alertCtrl = [ATYAlertViewController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"确定移除此家人？"]];
        alertCtrl.messageAlignment = NSTextAlignmentCenter;
        ATYAlertAction *cancel = [ATYAlertAction actionWithTitle:@"取消" titleColor:0x1F1F1F handler:nil];
        ATYAlertAction *done = [ATYAlertAction actionWithTitle:@"确定" titleColor:0x1F1F1F handler:^(ATYAlertAction *action) {
            [self deleteFamilyMemberAction];
        }];
        
        [alertCtrl addAction:cancel];
        [alertCtrl addAction:done];
        [self presentViewController:alertCtrl animated:NO completion:nil];
    }];
}

#pragma mark -- 删除家庭成员
- (void)deleteFamilyMemberAction {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSArray *indexPaths = [self.tranformListView indexPathsForSelectedRows];
    NSMutableArray *selectArr = [[NSMutableArray alloc] init];
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        FamilyMemberApiModel *model = self.tranformListView.dataArr[obj.row];
        [selectArr addObject:[NSNumber numberWithInteger:model.userId]];
    }];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    FamilyMemberApiModel *defaultModel = [self.familyMemberArr firstObject];
    params[@"familyId"] = [NSNumber numberWithInteger:defaultModel.familyId];
    params[@"quitUserIds"] = selectArr;
    @weakify(self);
    [[self.homeVM.QuitCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[HMSelectFamilyViewController class]]) {
                    [KNotificationCenter postNotificationName:DELETEFAMILYMEMBER_NOTIFICATION object:nil userInfo:nil];
                    HMSelectFamilyViewController *familyVC = (HMSelectFamilyViewController *)vc;
                    [self.navigationController popToViewController:familyVC animated:YES];
                }
            }
        }
    }];
}

- (PCTransformView *)tranformListView {
    if (!_tranformListView) {
        _tranformListView = [[PCTransformView alloc] initWithFrame:CGRectMake(0, 72, KSCREEN_WIDTH, KSCREENH_HEIGHT - 72 - KBottomSafeHeight) style:UITableViewStyleGrouped];
    }
    return _tranformListView;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] init];
        [_deleteBtn setBackgroundColor:KHEXRGB(0xFF7976)];
        [_deleteBtn setTitle:@"移除此家人（1）" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _deleteBtn;
}

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

@end
