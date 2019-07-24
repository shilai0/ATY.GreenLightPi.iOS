//
//  PCSystemMessageViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCSystemMessageViewController.h"
#import "PCSystemMessageView.h"
#import "PersonalCenterViewModel.h"
#import "PCMessageModel.h"

@interface PCSystemMessageViewController ()
@property (nonatomic, strong) PCSystemMessageView *systemMessageView;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@end

@implementation PCSystemMessageViewController

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

- (PCSystemMessageView *)systemMessageView {
    if (!_systemMessageView){
        _systemMessageView = [[PCSystemMessageView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStyleGrouped];
    }
    return _systemMessageView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0x333333 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"系统通知" titleColor:0x333333];
    
    [self pc_creatSystemMesageUI];
    [self pc_requestMessageData];
}

- (void)pc_creatSystemMesageUI {
    [self.view addSubview:self.systemMessageView];
}

- (void)pc_requestMessageData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    @weakify(self);
    [[self.personalCenterVM.GetUserMessage execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            PCMessageModel *model = [PCMessageModel mj_objectWithKeyValues:x[@"Data"]];
            self.systemMessageView.dataArr = [model.sysMessageList mutableCopy];
            [self.systemMessageView reloadData];
        }
    }];
}

@end
