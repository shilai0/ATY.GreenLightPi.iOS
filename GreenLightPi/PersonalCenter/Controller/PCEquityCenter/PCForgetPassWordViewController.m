//
//  PCForgetPassWordViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/16.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCForgetPassWordViewController.h"
#import "PCForgetPassWordView.h"
#import "PCRebindToRetrievePWViewController.h"
#import "PCAddBankCardViewController.h"
#import "MyCardModel.h"

@interface PCForgetPassWordViewController ()
@property (nonatomic, strong) PCForgetPassWordView *forgetPassWordView;
@end

@implementation PCForgetPassWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0
                      leftBlock:^{
                          @strongify(self);
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
    [self aty_setCenterNavItemtitle:@"找回密码" titleColor:0x333333];
    
    [self creatForgetPassWordViews];
}

- (void)creatForgetPassWordViews {
    [self.view addSubview:self.forgetPassWordView];
    self.forgetPassWordView.selectBankModel = self.selectBankModel;
    
    @weakify(self);
    self.forgetPassWordView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        switch (indexPath.section) {
            case 0:
            {//重新绑定以找回密码
                PCRebindToRetrievePWViewController *rebindToRetrievePWVC = [[PCRebindToRetrievePWViewController alloc] init];
                rebindToRetrievePWVC.selectBankModel = self.selectBankModel;
                [self.navigationController pushViewController:rebindToRetrievePWVC animated:YES];
            }
                break;
            case 1:
            {//添加新卡以找回密码
                PCAddBankCardViewController *addNewCardToRetrievePWVC = [[PCAddBankCardViewController alloc] init];
                addNewCardToRetrievePWVC.addBankCardType = AddBankCardTypeForRessetPassword;
                [self.navigationController pushViewController:addNewCardToRetrievePWVC animated:YES];
            }
                break;
            default:
                break;
        }
    };
}

- (PCForgetPassWordView *)forgetPassWordView {
    if (!_forgetPassWordView) {
        _forgetPassWordView = [[PCForgetPassWordView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStyleGrouped];
    }
    return _forgetPassWordView;
}

@end
