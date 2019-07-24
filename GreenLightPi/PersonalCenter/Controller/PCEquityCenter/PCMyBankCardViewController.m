//
//  PCMyBankCardViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/10.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCMyBankCardViewController.h"
#import "PCMyBankCardView.h"
#import "PersonalCenterViewModel.h"
#import "MyCardModel.h"
#import "PCAddBankCardViewController.h"
#import "ATYCache.h"

@interface PCMyBankCardViewController ()
@property (nonatomic, strong) PCMyBankCardView *myBankCardView;
@property (nonatomic, strong) UIView *footerBackView;
@property (nonatomic, strong) UIButton *addBankBtn;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@end

@implementation PCMyBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0
                      leftBlock:^{
                          @strongify(self);
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
    
    [self aty_setCenterNavItemtitle:@"我的银行卡" titleColor:0x333333];
    [self creatMyBankCardViews];
    [self requestMyCardData];
    [[KNotificationCenter rac_addObserverForName:ADDBANKSUCCESS_NOTIFICATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self requestMyCardData];
    }];
}

- (void)creatMyBankCardViews {
    [self.view addSubview:self.myBankCardView];
    [self.footerBackView addSubview:self.addBankBtn];
    self.myBankCardView.tableFooterView = self.footerBackView;
    
    @weakify(self);
    [[self.addBankBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        PCAddBankCardViewController *addBankCardVC = [[PCAddBankCardViewController alloc] init];
        [self.navigationController pushViewController:addBankCardVC animated:YES];
    }];
    
}

- (void)requestMyCardData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    @weakify(self);
    [[self.personalCenterVM.GetMyBankCard execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            NSMutableArray *dataArr = [MyCardModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
            self.myBankCardView.dataArr = dataArr;
            [ATYCache saveDataCache:dataArr forKey:BANKCARDARR];
            [self.myBankCardView reloadData];
        }
    }];
}

- (void)dealloc {
    [KNotificationCenter removeObserver:self];
}

- (PCMyBankCardView *)myBankCardView {
    if (!_myBankCardView) {
        _myBankCardView = [[PCMyBankCardView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStylePlain];
    }
    return _myBankCardView;
}

- (UIView *)footerBackView {
    if (!_footerBackView) {
        _footerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 100)];
    }
    return _footerBackView;
}

- (UIButton *)addBankBtn {
    if (!_addBankBtn) {
        _addBankBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 30, KSCREEN_WIDTH - 30, 49)];
        [_addBankBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        [_addBankBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
        [_addBankBtn setTitleColor:KHEXRGB(0xF37065) forState:UIControlStateNormal];
        _addBankBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        XSViewBorderRadius(_addBankBtn, 8, 1, KHEXRGB(0xF37065));
    }
    return _addBankBtn;
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

@end
