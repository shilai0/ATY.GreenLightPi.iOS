//
//  FCPayFailViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/10.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCPayFailViewController.h"
#import "FCPayFailView.h"

@interface FCPayFailViewController ()
@property (nonatomic, strong) FCPayFailView *payFailView;
@end

@implementation FCPayFailViewController

- (FCPayFailView *)payFailView {
    if (!_payFailView) {
        _payFailView = [[FCPayFailView alloc] init];
    }
    return _payFailView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"支付结果" titleColor:0x333333];
    [self fc_creatUI];
}

- (void)fc_creatUI {
    [self.view addSubview:self.payFailView];
    
    [self.payFailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@(KNavgationBarHeight));
        make.height.equalTo(@243);
    }];
    
    @weakify(self);
    self.payFailView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    };
}

@end
