//
//  PCSetViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCSetViewController.h"
#import "PCAcountAndPrivacyViewController.h"
#import "PCUserAgreementViewController.h"
#import "RLFirstOpenAppViewController.h"
#import "BaseNavigationViewController.h"
#import "PCFeedBackViewController.h"
#import "ATYAlertViewController.h"
#import "ATYAlertViewController.h"
#import "PCAboutViewController.h"
#import "PCSetListView.h"
#import "BaseFormModel.h"
#import "ATYToast.h"
#import "ATYCache.h"

@interface PCSetViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) PCSetListView *setListView;
@property (nonatomic, strong) UIButton *outLoginBtn;
@property (nonatomic, strong) NSMutableArray *dataArr;
@end

@implementation PCSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"设置" titleColor:0x333333];
    
    [self pc_creatSetListView];
    
    [KNotificationCenter addObserver:self selector:@selector(refreshSwitch) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)pc_creatSetListView {
    self.setListView = [[PCSetListView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.setListView];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        self.outLoginBtn.frame = CGRectMake(0, KSCREENH_HEIGHT - 67 - KBottomSafeHeight - KNavgationBarHeight, KSCREEN_WIDTH, 45);
        [self.view addSubview:self.outLoginBtn];
    }
    
    NSString *plistStr = NSLocalizedString(@"PCSet.plist", nil);
    [self pc_insertDataForArray: [BaseFormModel xs_getDataWithPlist:plistStr]];
    
    @weakify(self);
    self.setListView.pushSwitchClickBlock = ^{
        @strongify(self);
        [self switchButtonClicked];
    };
    
    self.setListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        if (indexPath.section == 0) {//账号和隐私
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                PCAcountAndPrivacyViewController *acountAndPrivacyVC = [[PCAcountAndPrivacyViewController alloc] init];
                [self.navigationController pushViewController:acountAndPrivacyVC animated:YES];
            } else {
//                [self goLogin];
                [self loginAction];
            }
            
        } else {
            switch (indexPath.row) {
                case 0://推送通知
                {
                    [self switchButtonClicked];
                }
                    break;
                case 1://清除缓存
                {
                    ATYAlertViewController *alertCtrl = [ATYAlertViewController alertControllerWithTitle:nil message:@"是否清除当前缓存内容？"];
                    alertCtrl.messageAlignment = NSTextAlignmentCenter;
                    ATYAlertAction *cancelAction = [ATYAlertAction actionWithTitle:@"取消" titleColor:0x1F1F1F handler:nil];
                    @weakify(self);
                    ATYAlertAction *doneAction = [ATYAlertAction actionWithTitle:@"确定" titleColor:0x44C08C handler:^(ATYAlertAction *action) {
                        @strongify(self);
                        [self pc_cleanHomeFile];
                        [ATYToast aty_bottomMessageToast:@"√缓存清除"];
                    }];
                    
                    [alertCtrl addAction:cancelAction];
                    [alertCtrl addAction:doneAction];
                    [self presentViewController:alertCtrl animated:NO completion:nil];
                }
                    break;
                case 2://用户协议
                {
                    PCUserAgreementViewController *userAgreementVC = [[PCUserAgreementViewController alloc] init];
                    [self.navigationController pushViewController:userAgreementVC animated:YES];
                }
                    break;
                case 3://意见反馈
                {
                    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                        PCFeedBackViewController *feedBackVC = [[PCFeedBackViewController alloc] init];
                        [self.navigationController pushViewController:feedBackVC animated:YES];
                    } else {
//                        [self goLogin];
                        [self loginAction];
                    }
                    
                }
                    break;
                case 4://关于
                {
                    PCAboutViewController *aboutVC = [[PCAboutViewController alloc] init];
                    [self.navigationController pushViewController:aboutVC animated:YES];
                }
                    break;
                case 5://推荐App给好友
                    
                    break;
                default:
                    break;
            }
        }
    };
    
    [[self.outLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        ATYAlertViewController *alertCtrl = [ATYAlertViewController alertControllerWithTitle:nil message:@"确定退出当前账号？"];
        alertCtrl.messageAlignment = NSTextAlignmentCenter;
        ATYAlertAction *cancel = [ATYAlertAction actionWithTitle:@"取消" titleColor:0x1F1F1F handler:nil];
        ATYAlertAction *done = [ATYAlertAction actionWithTitle:@"确定" titleColor:0x1F1F1F handler:^(ATYAlertAction *action) {
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            [userDefaults removeObjectForKey:PROJECT_TOKEN];
            [userDefaults removeObjectForKey:PROJECT_USER_ID];
            [userDefaults removeObjectForKey:PROJECT_BOXID];
            [ATYCache removeChache:PROJECT_USER];
            UIWindow *window = [UIApplication sharedApplication].keyWindow;
            window.rootViewController = [[BaseNavigationViewController alloc] initWithRootViewController:[[RLFirstOpenAppViewController alloc] init]];
        }];
        
        [alertCtrl addAction:cancel];
        [alertCtrl addAction:done];
        [self presentViewController:alertCtrl animated:NO completion:nil];
    }];
}

#pragma mark -- 系统通知
- (void)switchButtonClicked {
    // 跳转到系统设置
    NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:settingURL options:[NSDictionary dictionary] completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:settingURL];
    }
}

- (void)refreshSwitch {
    [self.setListView reloadData];
}

#pragma mark -- 插入数据
- (void)pc_insertDataForArray:(NSMutableArray *)dataArr {
    BaseFormModel *model = [dataArr objectAtIndex:1];
    BaseDetailFormModel *vaModel = [model.itemsArr objectAtIndex:1];
    CGFloat sumData = [self pc_calculateDataCapacity];
    vaModel.text = [NSString stringWithFormat:@"%.1fMB",sumData/1024.0/1024.0];
    self.dataArr = dataArr;
    self.setListView.dataArr = dataArr;
    [self.setListView reloadData];
}

#pragma mark -- 清除缓存
- (void)pc_cleanHomeFile {
    // 获取当前缓存内容的大小
    // 取得沙盒路径
    NSString *homeFile = NSHomeDirectory();
    
    // 文件管理者
    NSFileManager *fileManger = [NSFileManager defaultManager];
    
    // 1.删除缓存文件
    NSString *filePath = [homeFile stringByAppendingPathComponent:@"Library/Caches/com.aiteyou.TheWholeFamily"];
    [fileManger removeItemAtPath:filePath error:nil];
    
    // 2.创建沙盒路径下的缓存文件夹
    [fileManger createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    BaseFormModel *model = [self.dataArr objectAtIndex:1];
    BaseDetailFormModel *vaModel = [model.itemsArr objectAtIndex:1];
    CGFloat sumData = [self pc_calculateDataCapacity];
    vaModel.text = [NSString stringWithFormat:@"%.1fMB",sumData/1024.0/1024.0];
    // 重新计算沙盒路径下的缓存内容大小
    [self.setListView reloadData];
}

/* 计算当前沙盒内文件的大小 */
- (CGFloat)pc_calculateDataCapacity {
    // 取得沙盒路径
    NSString *homeFile = NSHomeDirectory();
    
    // 文件管理者
    NSFileManager *fileManger = [NSFileManager defaultManager];
    
    NSString *filePath = [homeFile stringByAppendingPathComponent:@"Library/Caches/com.aiteyou.TheWholeFamily"];
    
    ATYLog(@"filePath:%@",filePath);
    
    // 获取filePath文件路径下的所有文件名
    NSArray *fileNmaeArr = [fileManger subpathsAtPath:filePath];
    
    long long sum = 0;
    for (NSString *fileName in fileNmaeArr) {
        NSString *file = [filePath stringByAppendingPathComponent:fileName];
        // 获取文件信息
        NSDictionary *dict = [fileManger attributesOfItemAtPath:file error:nil];
        // 获取文件的大小
        long long size = [[dict objectForKey:NSFileSize]longLongValue];
        
        sum += size;
    }
    
    return sum;
}

#pragma mark -- 立即登录
//- (void)goLogin {
//    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//    window.rootViewController = [[BaseNavigationViewController alloc] initWithRootViewController:[[RLFirstOpenAppViewController alloc] init]];
//}

#pragma mark -- 懒加载
- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (UIButton *)outLoginBtn {
    if (!_outLoginBtn) {
        _outLoginBtn = [UIButton new];
        [_outLoginBtn setTitle:@"退出登录" forState:UIControlStateNormal];
        [_outLoginBtn setTitleColor:KHEXRGB(0xFF5D5D) forState:UIControlStateNormal];
        _outLoginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_outLoginBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
    }
    return _outLoginBtn;
}

- (void)dealloc {
    [KNotificationCenter removeObserver:self];
}

@end
