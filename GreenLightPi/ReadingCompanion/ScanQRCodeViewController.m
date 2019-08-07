//
//  ScanQRCodeViewController.m
//  VTPictureBook
//
//  Created by 隔壁老王 on 2019/1/5.
//

#import "ScanQRCodeViewController.h"
#import "SGQRCode.h"
//#import "MBProgressHUD+SGQRCode.h"
#import "SGQRCodeScanView.h"
#import "CustomAlertView.h"
#import "QRCodeView.h"
#import "MainTabBarViewController.h"
#import "AppDelegate.h"
#import "VTPictureBookSDK.framework/Headers/VTSDKDelegate.h"
#import "VTPictureBookSDK.framework/Headers/VTAudioManager.h"
#import "VTPictureBookSDK.framework/Headers/VTGlobalObject.h"
#import "VTPictureBookSDK.framework/Headers/VTMainBLLObj.h"


@interface ScanQRCodeViewController ()<VTQRCodeDelegate>
@property (nonatomic, strong) SGQRCodeObtain *obtain;
@property (nonatomic, assign) BOOL isSelectedFlashlightBtn;

@property (nonatomic, assign) BOOL hasNetWork;
@property (nonatomic, strong) QRCodeView *qrview;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, assign) CGRect tempFrame;
@end

@implementation ScanQRCodeViewController

#pragma mark ---- life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.qrview];
    [self initData];
}

-(void)initData{
    self.obtain = [SGQRCodeObtain QRCodeObtain];
    [self setupQRCodeScan];
    _hasNetWork = YES;
    _isShow = NO;
    [VTAudioManager sendMessage:MSG_SCAN_TIPS];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidReachable) name:@"NetworkReachabilityStatusReachable" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkDidNotReachable) name:@"NetworkReachabilityStatusNotReachable" object:nil];
}



-(void)viewWillLayoutSubviews{
    self.qrview.frame = CGRectMake(0, 0, self.view.frame.size.width, KSCREENH_HEIGHT - KTabBarHeight);
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //开始扫描
    [self.obtain startRunningWithBefore:nil completion:nil];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [VTAudioManager sendMessage:MSG_START_SCAN];
    [self showScanImag];
    //开始刷新扫描界面
    [self.qrview.scanView addTimer];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //停止扫描
    [self.qrview.scanView removeTimer];
    [self.obtain stopRunning];
    [VTAudioManager sendMessage:MSG_PAUSE_ALLAUDIOS];
    [VTGlobalObject cancleAllTimer];
}

-(void)dealloc{
    [self removeScanningView];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"NetworkReachabilityStatusReachable" object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"NetworkReachabilityStatusNotReachable" object:nil];
}

#pragma mark --- NetworkReachabilityStatusReachable 通知
-(void)networkDidReachable{
    self.hasNetWork = YES;
}

#pragma mark --- NetworkReachabilityStatusNotReachable 通知

-(void)networkDidNotReachable{
    self.hasNetWork = NO;
}

#pragma mark -------VTQRCodeDelegate


- (void)scanSuccess:(NSDictionary *)result{
    [VTAudioManager sendMessage:MSG_SCAN_QRCODE_SUCCEED];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"authorize"];
    NSString *license = result[@"data"];
    [[NSUserDefaults standardUserDefaults] setValue:license forKey:@"license"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"custom_viewwillappear" object:nil];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
//    });
}

- (void)scanFail:(VTErrorCode)error{
    switch (error) {
        case VTErrorCode_LicenseEmpty:
        {
            [VTAudioManager sendMessage:MSG_SCAN_QRCODE_FALSE];
            CustomAlertView *alertView = [[CustomAlertView alloc]initWithTitle:@"温馨提示" message:@"认证失败\n请叫爸爸妈妈联系客服" submessage:nil confirmBtn:@"重新扫描" cancleBtn:@"退出"];
            alertView.resultIndex = ^(NSInteger index) {
                if (index == 100) {
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    MainTabBarViewController *tabViewController = (MainTabBarViewController *) appDelegate.window.rootViewController;
                    [tabViewController setSelectedIndex:0];
                    [VTAudioManager sendMessage:MSG_PAUSE_ALLAUDIOS];
                }else if (index == 101){
                    [self.obtain startRunningWithBefore:nil completion:nil];
                }
            };
            [alertView showAlertView:self.view];
        }
            break;
        case VTErrorCode_NumOfQRCodeUsedUp:
        {
            [VTAudioManager sendMessage:MSG_SCAN_QRCODE_LIMIT];
            CustomAlertView *alertView = [[CustomAlertView alloc]initWithTitle:@"温馨提示" message:@"授权设备超过上限!" submessage:@"请换一个新的激活码试试" confirmBtn:@"退出" cancleBtn:@"重新扫描"];
            alertView.resultIndex = ^(NSInteger index) {
                if (index == 100) {
                    [self.obtain startRunningWithBefore:nil completion:nil];
                }else if (index == 101){
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    MainTabBarViewController *tabViewController = (MainTabBarViewController *) appDelegate.window.rootViewController;
                    [tabViewController setSelectedIndex:0];
                    [VTAudioManager sendMessage:MSG_PAUSE_ALLAUDIOS];
                }
            };
            [alertView showAlertView:self.view];
        }
            break;
        case VTErrorCode_IllegalQRCode:
        {
            CustomAlertView *alertView = [[CustomAlertView alloc]initWithTitle:@"温馨提示" message:@"无效二维码" submessage:nil confirmBtn:nil cancleBtn:nil];
            [alertView showAlertView:self.view];
            [self showScanImag];
            [VTAudioManager sendMessage:MSG_SCAN_QRCODE_INVALID];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.obtain startRunningWithBefore:nil completion:nil];
                if (alertView) {
                    [alertView dismissAlertView];
                }
            });
        }
            break;
        default:
        {
            [VTAudioManager sendMessage:MSG_NETWORK_LOWDATA];
            [self.obtain startRunningWithBefore:nil completion:nil];
        }
            break;
    }
}


#pragma mark ---- private methods

-(void)showScanImag{
    int height = self.qrview.imageV.frame.size.height;
    _tempFrame = self.qrview.imageV.frame;
    [UIView animateWithDuration:2.0 delay:0 usingSpringWithDamping:1.f initialSpringVelocity:5.f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        if (!_isShow) {
            _tempFrame.origin.y -=height;
            _isShow = YES;
        }else{
            _tempFrame.origin.y +=height;
            _isShow = NO;
        }
        self.qrview.imageV.frame = _tempFrame;
    } completion:^(BOOL finished) {
        
        [VTGlobalObject scheduledDispatchTimerWithName:@"SCAN_GUILD" delay:15 timeInterval:15 queue:dispatch_get_main_queue() repeatCounts:1 action:^{
            if (_isShow) {
                [self showScanImag];
            }
        }];
    }];
}

- (void)setupQRCodeScan {
    __weak __typeof(self) weakSelf = self;
    
    SGQRCodeObtainConfigure *configure = [SGQRCodeObtainConfigure QRCodeObtainConfigure];
    configure.sampleBufferDelegate = YES;
    [self.obtain establishQRCodeObtainScanWithController:self configure:configure];
    [self.obtain setBlockWithQRCodeObtainScanResult:^(SGQRCodeObtain *obtain, NSString *result) {
        
        if (result) {
            if (weakSelf.hasNetWork) {
                [VTAudioManager sendMessage:MSG_SCAN_RESULT_EF];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                    [MBProgressHUD SG_hideHUDForView:weakSelf.view];
                    [MBProgressHUD hideHUD];

                });
//                [MBProgressHUD SG_showMBProgressHUDWithModifyStyleMessage:@"正在处理..." toView:weakSelf.view];
                [MBProgressHUD showWarnMessage:@"正在处理"];

                [obtain stopRunning];
                [weakSelf confirmQRCode:result];
            }
        }
    }];
    [self.obtain setBlockWithQRCodeObtainScanBrightness:^(SGQRCodeObtain *obtain, CGFloat brightness) {
        if (brightness < - 1) {
            [weakSelf.qrview addflashlightBtn];
            [weakSelf.qrview.flashlightBtn addTarget:weakSelf action:@selector(flashlightAction:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            if (weakSelf.isSelectedFlashlightBtn == NO) {
                [weakSelf removeFlashlightBtn];
            }
        }
    }];
}

- (void)removeFlashlightBtn {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.obtain closeFlashlight];
        self.isSelectedFlashlightBtn = NO;
        self.qrview.flashlightBtn.selected = NO;
        [self.qrview.flashlightBtn removeFromSuperview];
        self.qrview.flashlightBtn = nil;
    });
}

-(void)confirmQRCode:(NSString *)code{
    [VTMainBLLObj getQRcodeAuthResult:code Callback:self];
}

-(void)initAlertView:(NSString *)text confirmBtnTitle:(NSString *)confirmText cancelBtnTitle:(NSString *)cancleText{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:text preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [alertC dismissViewControllerAnimated:YES completion:nil];
    });
}

- (void)removeScanningView {
    [self.qrview.scanView removeTimer];
    [self.qrview.scanView removeFromSuperview];
}


#pragma mark ---- event methods 闪光灯按钮

- (void)flashlightAction:(UIButton *)button {
    if (button.selected == NO) {
        [self.obtain openFlashlight];
        self.isSelectedFlashlightBtn = YES;
        button.selected = YES;
    } else {
        [self removeFlashlightBtn];
    }
}

#pragma mark --- VC methods override

-(BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

#pragma mark ---- getters and setters

-(QRCodeView *)qrview{
    if (_qrview == nil) {
        _qrview = [[QRCodeView alloc]init];
    }
    return _qrview;
}

@end
