//
//  PCMainViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/21.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMainViewController.h"
#import "PCMainHeadView.h"
#import "PersonalCenterViewModel.h"
#import "PersonalCenterUserModel.h"
#import "PCAlreadyboughtCourseViewController.h"
#import "PCMyCollectViewController.h"
#import "PCEditPersonalInfoViewController.h"
#import "PCSetViewController.h"
#import "FileEntityModel.h"
#import "PCMainView.h"
#import "PCMainTopHeadView.h"
#import "BaseNavigationViewController.h"
#import "PCMyCashCouponViewController.h"
#import "RLFirstOpenAppViewController.h"
#import "HMSelectFamilyViewController.h"
#import "PCMyParkViewController.h"
#import "PCScanQRCodeViewController.h"
#import "XSYTapSound.h"
#import "PCSystemMessageViewController.h"
#import "PCActivityTipView.h"
#import "RLLoginRegisterViewModel.h"
#import "ATYAlertViewController.h"
#import "PCEquityCenterViewController.h"

@interface PCMainViewController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) PCMainHeadView *mainHeadView;
@property (nonatomic, strong) PCMainTopHeadView *mainTopHeadView;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, strong) PersonalCenterUserModel *personalCenterUserModel;
@property (nonatomic, strong) PCMainView *mainView;
@property (nonatomic, strong) UIButton *openParkBtn;
@property (nonatomic, strong) PCActivityTipView *activityTipView;
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegisterVM;
@property (nonatomic, copy) NSString *activityCode;

@end

@implementation PCMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHEXRGB(0xFFFFFF);
    [self pc_creatMainViews];
    [self pc_requestData];

    @weakify(self);
    [[KNotificationCenter rac_addObserverForName:CHANGEHEADIMAGE_CONTENT_NOTIFICATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        NSString *imagePath = [x.userInfo objectForKey:@"imagePath"];
        self.personalCenterUserModel.image.path = imagePath;
        self.mainHeadView.model = self.personalCenterUserModel;
        self.mainTopHeadView.model = self.personalCenterUserModel;
    }];
    
    [[KNotificationCenter rac_addObserverForName:TRANSFORMPARK_NOTIFICATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self pc_requestData];
    }];
    
}

- (void)pc_creatMainViews {
    self.mainView.tableHeaderView = self.mainHeadView;
    [self.view addSubview:self.mainView];
    [self.view addSubview:self.mainTopHeadView];
    self.mainTopHeadView.hidden = YES;
    
    self.mainView.dataArr = [[NSMutableArray alloc] initWithObjects:@[@{@"title":@"我的乐园"},@{@"title":@"我的家庭组"},@{@"title":@"我的课程"},@{@"title":@"我的收藏"},@{@"title":@"代金券"},],nil];
    
    [self.mainView reloadData];
    
    @weakify(self);
    self.mainHeadView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 1://设置
            {
                PCSetViewController *setVC = [[PCSetViewController alloc] init];
                [self.navigationController pushViewController:setVC animated:YES];
            }
                break;
            case 2://消息
            {
                if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                    PCSystemMessageViewController *messageCenterVC = [[PCSystemMessageViewController alloc] init];
                    [self.navigationController pushViewController:messageCenterVC animated:YES];
                } else {
//                    [self goLogin];
                    [self loginAction];
                }
            }
                break;
            case 3://个人信息
            {
                if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                    PCEditPersonalInfoViewController *editPersonalInfoVC = [[PCEditPersonalInfoViewController alloc] init];
                    editPersonalInfoVC.personalUserModel = self.personalCenterUserModel;
                    @weakify(self);
                    editPersonalInfoVC.updateInfoBlock = ^(PersonalCenterUserModel *personalUserModel) {
                        @strongify(self);
                        self.personalCenterUserModel = personalUserModel;
                        self.mainHeadView.model = self.personalCenterUserModel;
                    };
                    [self.navigationController pushViewController:editPersonalInfoVC animated:YES];
                } else {
//                    UIWindow *window = [UIApplication sharedApplication].keyWindow;
//                    window.rootViewController = [[BaseNavigationViewController alloc] initWithRootViewController:[[RLFirstOpenAppViewController alloc] init]];
                    [self loginAction];
                }
            }
                break;
            default:
                break;
        }
    };
        
    self.mainTopHeadView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 1://设置
            {
                PCSetViewController *setVC = [[PCSetViewController alloc] init];
                [self.navigationController pushViewController:setVC animated:YES];
            }
                break;
            case 2://消息
            {
                if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                    PCSystemMessageViewController *messageCenterVC = [[PCSystemMessageViewController alloc] init];
                    [self.navigationController pushViewController:messageCenterVC animated:YES];
                } else {
//                    [self goLogin];
                    [self loginAction];
                }
            }
                break;
            default:
                break;
        }
    };
    
    self.mainView.pushBlock = ^(NSArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
            switch (indexPath.section) {
                case 0:
                {
                    switch (indexPath.row) {
                        case 0://我的乐园
                        {
                            if (self.personalCenterUserModel.isActivation == 1) {
                                PCMyParkViewController *myParkVC = [[PCMyParkViewController alloc] init];
                                [self.navigationController pushViewController:myParkVC animated:YES];
                            } else {
                                [ATYToast aty_bottomMessageToast:@"您的账户还未开通独角兽乐园！"];
                            }
                            
                        }
                            break;
                        case 1://我的家庭组
                        {
                            HMSelectFamilyViewController *myFamilyVC = [[HMSelectFamilyViewController alloc] init];
                            myFamilyVC.pushFamilyType = PushFamilyTypeMyFamily;
                            [self.navigationController pushViewController:myFamilyVC animated:YES];
                        }
                            break;
                        case 2://我的课程
                        {
                            PCAlreadyboughtCourseViewController *alreadyBoughtVC = [[PCAlreadyboughtCourseViewController alloc] init];
                            [self.navigationController pushViewController:alreadyBoughtVC animated:YES];
                        }
                            break;
                        case 3://我的收藏
                        {
                            PCMyCollectViewController *myCollectVC = [[PCMyCollectViewController alloc] init];
                            [self.navigationController pushViewController:myCollectVC animated:YES];
                        }
                            break;
                        case 4://代金券
                        {
                            PCMyCashCouponViewController *myCashCouponVC = [[PCMyCashCouponViewController alloc] init];
                            myCashCouponVC.personalCenterModel = self.personalCenterUserModel;
                            [self.navigationController pushViewController:myCashCouponVC animated:YES];
                        }
                            break;
                        case 5://权益中心
                        {
                            PCEquityCenterViewController *equityCenterVC = [[PCEquityCenterViewController alloc] init];
                            [self.navigationController pushViewController:equityCenterVC animated:YES];
                        }
                            break;
                        default:
                            break;
                    }
                }
                    break;
                default:
                    break;
            }
        } else {
//            [self goLogin];
            [self loginAction];
        }
    };
    
    self.mainView.scrollBlock = ^(UIScrollView *scrollView) {
        @strongify(self);
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY > 66) {
            self.mainTopHeadView.hidden = NO;
        } else {
            self.mainTopHeadView.hidden = YES;
        }
    };
    
    // 下拉刷新数据请求指令
    self.mainView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.mainView.mj_header endRefreshing];
        [self.mainView.mj_footer endRefreshing];
        [self pc_requestData];
    }];
}

#pragma mark -- requestData
- (void)pc_requestData {
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    if (user_id) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"userId"] = user_id;
        params[@"currentUserId"] = user_id;
        @weakify(self);
        [[self.personalCenterVM.GetPersonalCenterUser execute:params] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if (x != nil) {
                self.personalCenterUserModel = [PersonalCenterUserModel mj_objectWithKeyValues:x[@"Data"]];
                self.mainHeadView.model = self.personalCenterUserModel;
                self.mainTopHeadView.model = self.personalCenterUserModel;
                
//                if ([self.personalCenterUserModel.UserGrade isEqualToString:@"D"] || [self.personalCenterUserModel.UserGrade isEqualToString:@"E"]) {
//                    self.mainView.dataArr = [[NSMutableArray alloc] initWithObjects:@[@{@"title":@"我的乐园"},@{@"title":@"我的家庭组"},@{@"title":@"我的课程"},@{@"title":@"我的收藏"},@{@"title":@"代金券"},],nil];
//                } else {
                    self.mainView.dataArr = [[NSMutableArray alloc] initWithObjects:@[@{@"title":@"我的乐园"},@{@"title":@"我的家庭组"},@{@"title":@"我的课程"},@{@"title":@"我的收藏"},@{@"title":@"代金券"},@{@"title":@"权益中心"},],nil];
//                }
                [self.mainView reloadData];
                
//                if (self.personalCenterUserModel.isActivation == 0) {
                    [self.view addSubview:self.openParkBtn];
                    @weakify(self);
                    [[self.openParkBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                        @strongify(self);
                        [self scanQRCodeOpenPark];
                    }];
                    CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KBottomSafeHeight - KTabBarHeight - 128);
                    self.mainView.frame = frame;
//                }
                
            }
        }];
    } else {
        [self.view addSubview:self.openParkBtn];
        @weakify(self);
        [[self.openParkBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self scanQRCodeOpenPark];
        }];
        CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KBottomSafeHeight - KTabBarHeight - 128);
        self.mainView.frame = frame;
    }
    
}

#pragma mark -- dealloc
- (void)dealloc {
    [KNotificationCenter removeObserver:self];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent; //返回白色
}

#pragma mark -- 立即登录
//- (void)goLogin {
//
//    ATYAlertViewController *alertCtrl = [ATYAlertViewController alertControllerWithTitle:nil message:@"需要登录才能获取相关信息哦"];
//    alertCtrl.messageAlignment = NSTextAlignmentCenter;
//    ATYAlertAction *cancel = [ATYAlertAction actionWithTitle:@"暂不" titleColor:0x1F1F1F handler:nil];
//    ATYAlertAction *done = [ATYAlertAction actionWithTitle:@"去登录" titleColor:0x00D399 handler:^(ATYAlertAction *action) {
//        UIWindow *window = [UIApplication sharedApplication].keyWindow;
//        window.rootViewController = [[BaseNavigationViewController alloc] initWithRootViewController:[[RLFirstOpenAppViewController alloc] init]];
//    }];
//
//    [alertCtrl addAction:cancel];
//    [alertCtrl addAction:done];
//    [self presentViewController:alertCtrl animated:NO completion:nil];
//
//}

#pragma mark -- 开通乐园
- (void)scanQRCodeOpenPark {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        self.activityTipView = [[PCActivityTipView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT)];
        [[UIApplication sharedApplication].keyWindow addSubview:self.activityTipView];
        self.activityTipView.backView1.hidden = NO;
        @weakify(self);
        self.activityTipView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
            @strongify(self);
            switch (index) {
                case 0://给自己激活
                {
                    if (self.personalCenterUserModel.isActivation == 1) {
                        [ATYToast aty_bottomMessageToast:@"您已激活独角兽乐园！"];
                        return ;
                    }
                    [self.activityTipView removeFromSuperview];
                    self.activityTipView = nil;
                    [self openScanQRCodeActionIsOther:NO];
                }
                    break;
                case 1://给别人激活
                {
                    self.activityTipView.backView1.hidden = YES;
                    self.activityTipView.backView2.hidden = NO;
                }
                    break;
                case 2://暂不激活
                {
                    [self.activityTipView removeFromSuperview];
                    self.activityTipView = nil;
                }
                    break;
                case 3://获取验证码(给别人激活)
                {
                    [self getCodeForActivityBoxWithPhone:content1];
                }
                    break;
                case 4://立即激活(给别人激活)
                {
                    if (![ATYUtils isNumText:self.activityTipView.phoneTextField.text]) {
                        [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码"];
                        return;
                    }
                    if (![ATYUtils checkCodeNumber:self.activityTipView.codeTextField.text]) {
                        [ATYToast aty_bottomMessageToast:@"请输入正确的验证码"];
                        return;
                    }
                    [self.activityTipView removeFromSuperview];
                    self.activityTipView = nil;
                    [self openScanQRCodeActionIsOther:YES];
                }
                    break;
                case 5://放弃激活(给别人激活)
                {
                    [self.activityTipView removeFromSuperview];
                    self.activityTipView = nil;
                }
                    break;
                default:
                    break;
            }
        };
    } else {
//        [self goLogin];
        [self loginAction];
    }
}

- (void)openScanQRCodeActionIsOther:(BOOL)isOther {
    if (![XSYTapSound ifCanUseSystemCamera]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"一家老小”已禁用相机" message:@"请在iPhone的“设置”选项中,允许“一家老小”访问你的相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alertView show];
        
        [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber * _Nullable x) {
            if ([x isEqual:@1]) {
                [ATYUtils openSystemSettingView];
            }
        }];
    } else {
        @weakify(self);
        PCScanQRCodeViewController *scanVC = [[PCScanQRCodeViewController alloc] initWithComplete:^(NSString *serialNumber) {
            NSLog(@"扫描到的二维码为------：%@",serialNumber);
            @strongify(self);
            [self  activityBoxActionStr:serialNumber isOther:isOther];
        }];
        [self.navigationController pushViewController:scanVC animated:YES];
    }
}

#pragma mark -- 激活盒子乐园获取验证码（给别人激活）
- (void)getCodeForActivityBoxWithPhone:(NSString *)phone {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = phone;
    params[@"smsType"] = [NSNumber numberWithInteger:10];
    @weakify(self);
    [[self.loginRegisterVM.getVerificationCodeCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            self.activityCode = x[@"Data"];
            [ATYToast aty_bottomMessageToast:@"验证码发送成功"];
        }
    }];
}

#pragma mark -- 激活盒子乐园
- (void)activityBoxActionStr:(NSString *)guidStr isOther:(BOOL)isOther{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"guidStr"] = guidStr;
    
    if (isOther) {
        params[@"phone"] = self.activityTipView.phoneTextField.text;
        params[@"smsCode"] = self.activityTipView.codeTextField.text;
    }
    
    [[self.personalCenterVM.AppActivityBox execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            NSString *str = x[@"Msg"][@"message"];
            if (str.length > 0) {
                [ATYToast aty_bottomMessageToast:str];
            } else {
                [ATYToast aty_bottomMessageToast:@"激活成功，请在盒子完成登录！"];
            }
            
        }
    }];
}

#pragma mark -- 懒加载
- (PCMainView *)mainView {
    if (!_mainView) {
        _mainView = [[PCMainView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KBottomSafeHeight - KTabBarHeight) style:UITableViewStyleGrouped];
        if (@available(iOS 11.0, *)) {
            _mainView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _mainView;
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

- (PCMainHeadView *)mainHeadView {
    if (!_mainHeadView) {
        _mainHeadView = [[PCMainHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 184)];
    }
    return _mainHeadView;
}

- (PCMainTopHeadView *)mainTopHeadView {
    if (!_mainTopHeadView) {
        _mainTopHeadView = [[PCMainTopHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 66)];
    }
    return _mainTopHeadView;
}

- (UIButton *)openParkBtn {
    if (!_openParkBtn) {
        _openParkBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, KSCREENH_HEIGHT - 128 - KTabBarHeight, KSCREEN_WIDTH, 128)];
        [_openParkBtn setBackgroundImage:[UIImage imageNamed:@"PC_activation"] forState:UIControlStateNormal];
        [_openParkBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
    }
    return _openParkBtn;
}

- (RLLoginRegisterViewModel *)loginRegisterVM {
    if (!_loginRegisterVM) {
        _loginRegisterVM = [[RLLoginRegisterViewModel alloc] init];
    }
    return _loginRegisterVM;
}


@end
