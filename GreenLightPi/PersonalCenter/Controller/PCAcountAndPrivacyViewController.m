//
//  PCAcountAndPrivacyViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCAcountAndPrivacyViewController.h"
#import "PCAcountAndPrivacyView.h"
#import "BaseFormModel.h"
#import "PCChangePhoneNoViewController.h"
#import "PCChangePassWordViewController.h"

@interface PCAcountAndPrivacyViewController ()
@property (nonatomic, strong) PCAcountAndPrivacyView *acountAndPrivacyView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation PCAcountAndPrivacyViewController

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"账号和隐私" titleColor:0x333333];
    [self pc_creatAcountAndPrivacyView];
}

- (void)pc_creatAcountAndPrivacyView {
    self.acountAndPrivacyView = [[PCAcountAndPrivacyView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.acountAndPrivacyView];
    
    NSString *plistStr = NSLocalizedString(@"PCAcountAndPrivacy.plist", nil);
    [self pc_insertTelephoneData: [BaseFormModel xs_getDataWithPlist:plistStr]];
    
    @weakify(self);
    self.acountAndPrivacyView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        switch (indexPath.row) {
            case 0://更换手机号码
            {
                PCChangePhoneNoViewController *changePhoneNoVC = [[PCChangePhoneNoViewController alloc] init];
                [self.navigationController pushViewController:changePhoneNoVC animated:YES];
            }
                break;
            case 1://修改密码
            {
                PCChangePassWordViewController *changePassWordVC = [[PCChangePassWordViewController alloc] init];
                [self.navigationController pushViewController:changePassWordVC animated:YES];
            }
                break;
            default:
                break;
        }
    };
}

- (void)pc_insertTelephoneData:(NSMutableArray *)dataArr {
    BaseFormModel *model = [dataArr firstObject];
    BaseDetailFormModel *vaModel = [model.itemsArr firstObject];
    vaModel.text = [[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_PHONE] stringByReplacingCharactersInRange:NSMakeRange(3, 5)  withString:@"*****"];
    self.dataArr = dataArr;
    self.acountAndPrivacyView.dataArr = dataArr;
    [self.acountAndPrivacyView reloadData];
}

@end
