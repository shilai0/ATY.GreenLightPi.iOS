//
//  PCCashOutResultViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/16.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCCashOutResultViewController.h"
#import "PCCashOutResultVIew.h"
#import "PCCashOutResultHeadView.h"
#import "PCMyCashOutRecordViewController.h"

@interface PCCashOutResultViewController ()
@property (nonatomic, strong) PCCashOutResultVIew *cashOutResultView;
@property (nonatomic, strong) PCCashOutResultHeadView *cashOutResultHeadView;
@property (nonatomic, strong) UIView *cashOutFooterView;
@property (nonatomic, strong) UIButton *cashOutFinishBtn;
@end

@implementation PCCashOutResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0
                      leftBlock:^{
                          @strongify(self);
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
    [self aty_setCenterNavItemtitle:@"提现结果" titleColor:0x333333];
    [self creatCashOutResultViews];
}

- (void)creatCashOutResultViews {
    [self.view addSubview:self.cashOutResultView];
    self.cashOutResultView.tableHeaderView = self.cashOutResultHeadView;
    [self.cashOutFooterView addSubview:self.cashOutFinishBtn];
    self.cashOutResultView.tableFooterView = self.cashOutFooterView;
    self.cashOutResultView.dataArr = [[NSMutableArray alloc] initWithObjects:@{@"title":@"提现金额",@"value":[NSString stringWithFormat:@"%.2f",[self.cashoutValue floatValue]]},@{@"title":@"提现方式",@"value":self.bankName}, nil];
    [self.cashOutResultView reloadData];
    
    @weakify(self);
    [[self.cashOutFinishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        PCMyCashOutRecordViewController *myCashOutRecordVC = [[PCMyCashOutRecordViewController alloc] init];
        [self.navigationController pushViewController:myCashOutRecordVC animated:YES];
    }];
}

- (PCCashOutResultVIew *)cashOutResultView {
    if (!_cashOutResultView) {
        _cashOutResultView = [[PCCashOutResultVIew alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStylePlain];
    }
    return _cashOutResultView;
}

- (PCCashOutResultHeadView *)cashOutResultHeadView {
    if (!_cashOutResultHeadView) {
        _cashOutResultHeadView = [[PCCashOutResultHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 170)];
    }
    return _cashOutResultHeadView;
}

- (UIView *)cashOutFooterView {
    if (!_cashOutFooterView) {
        _cashOutFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 80)];
    }
    return _cashOutFooterView;
}

- (UIButton *)cashOutFinishBtn {
    if (!_cashOutFinishBtn) {
        _cashOutFinishBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 20, KSCREEN_WIDTH - 120, 50)];
        [_cashOutFinishBtn setBackgroundImage:[UIImage imageNamed:@"finished"] forState:UIControlStateNormal];
        [_cashOutFinishBtn setTitle:@"完成" forState:UIControlStateNormal];
        [_cashOutFinishBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _cashOutFinishBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _cashOutFinishBtn;
}

@end
