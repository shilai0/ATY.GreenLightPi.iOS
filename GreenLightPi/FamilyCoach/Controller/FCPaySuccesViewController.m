//
//  FCPaySuccesViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/10.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCPaySuccesViewController.h"
#import "FCPaySuccessView.h"

@interface FCPaySuccesViewController ()
@property (nonatomic, strong) FCPaySuccessView *paySuccessView;
@end

@implementation FCPaySuccesViewController

- (FCPaySuccessView *)paySuccessView {
    if (!_paySuccessView) {
        _paySuccessView = [[FCPaySuccessView alloc] init];
    }
    return _paySuccessView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHEXRGB(0x44C08C);
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"支付结果" titleColor:0x333333];
    
    [self fc_creatUI];
}

- (void)fc_creatUI {
    [self.view addSubview:self.paySuccessView];
    self.paySuccessView.model = self.model;
//    self.paySuccessView.cardModel = self.cardModel;
    [self.paySuccessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(16);
        make.right.equalTo(self.view.mas_right).offset(-16);
        make.top.equalTo(@(52 + KNavgationBarHeight));
        make.height.equalTo(@410);
    }];
    
    @weakify(self);
    self.paySuccessView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    };
}

@end
