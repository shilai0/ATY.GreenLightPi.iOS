//
//  PCChangePassWordViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCChangePassWordViewController.h"
#import "PCChangePassWordView.h"
#import "PersonalCenterViewModel.h"

@interface PCChangePassWordViewController ()
@property (nonatomic, strong) PCChangePassWordView *changePassWordView;
@property (nonatomic, copy) NSString *oldPassWordStr;
@property (nonatomic, copy) NSString *nowPassWordStr;
@property (nonatomic, copy) NSString *surePassWordStr;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@end

@implementation PCChangePassWordViewController

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

- (PCChangePassWordView *)changePassWordView {
    if (!_changePassWordView) {
        _changePassWordView = [PCChangePassWordView new];
    }
    return _changePassWordView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"修改密码" titleColor:0x333333];
    
    [self aty_setRightNavItemImg:@"" title:@"确定" titleColor:0x44C08C rightBlock:^{
        @strongify(self);
        [self pc_changePassword];
    }];
    [self pc_creatChangePassWordViews];
}

- (void)pc_creatChangePassWordViews {
    [self.view addSubview:self.changePassWordView];
    
    [self.changePassWordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(KNavgationBarHeight));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(KSCREEN_WIDTH - KNavgationBarHeight));
    }];
    
    @weakify(self);
    self.changePassWordView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        if (index == 0) {
            self.oldPassWordStr = content1;
        } else if (index == 1) {
            self.nowPassWordStr = content1;
        } else if (index == 2) {
            self.surePassWordStr = content1;
        }
    };
}

- (void)pc_changePassword {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"oldPassword"] = self.oldPassWordStr;
    params[@"newPassword"] = self.nowPassWordStr;
    
    if (StrEmpty(self.oldPassWordStr)) {
        [ATYToast aty_bottomMessageToast:@"请输入旧的密码"];
        return;
    }
    
    if (StrEmpty(self.nowPassWordStr)) {
        [ATYToast aty_bottomMessageToast:@"请输入新的密码"];
        return;
    }

    if (![self.nowPassWordStr isEqualToString:self.surePassWordStr]) {
        [ATYToast aty_bottomMessageToast:@"请重新确认新的密码"];
        return;
    }
    
    @weakify(self);
    [[self.personalCenterVM.ChangePassword execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            [ATYToast aty_bottomMessageToast:@"密码修改成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
