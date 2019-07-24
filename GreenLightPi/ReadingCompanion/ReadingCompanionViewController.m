//
//  ReadingCompanionViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/3.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "ReadingCompanionViewController.h"
#import "RightView.h"
#import "VTAnimationManager.h"
#import "XSYTapSound.h"
#import "VTPictureBookSDK.framework/Headers/VTAudioManager.h"
#import "VTPictureBookSDK.framework/Headers/VTMainBLLObj.h"
#import "VTPictureBookSDK.framework//Headers/VTConst.h"
#import "VTPictureBookSDK.framework/Headers/VTGlobalObject.h"

@interface ReadingCompanionViewController ()<VTInitAPPStatusDelegate,VTCameraDataDelegate,VTResoureUpdateDelegate,VTAudioStatusDelegate,VTRecognitionDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) RightView *rightV;
@property (nonatomic, assign) BOOL isEnable;
@property (nonatomic, strong) VTMainBLLObj *mainBll;
@end

@implementation ReadingCompanionViewController

{
    BOOL isNetworkReachability;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self isCameraAvailable]) {
        //检测是否有摄像头
        UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        }];
        
        [alertC addAction:alertA];
        [self presentViewController:alertC animated:YES completion:nil];
        return;
    }
    
    [self isCanUseSystemCamera];
    
//    NSString *license = @"NzUxMzdDMTQyRTY3NUM1QzhDOEQyQzA1ODE2MkJFOTBFM0FGRjE2RDZGRTU2MTBDOTE4RTJGNzU3RTQ5QjhENTAwRkZFNkM2MjMzNEY3NkU2NjhDNjMzRUQ5MjFFRDkzNkQ2NTdFNzg0RTA1RkE0Q0E2MTdDMTc1NDFGQURCNjI2RTU2MUQ3MjYwQzk1RjNCOEQyRkEyREIwQzFCNzM1NTZBMkU4MDQ2RjU5MUIwQ0U0NDUzNUJBRDkwRTg2QTBBMTRBQUI2OTEzMzkxMENFMEQwRTQ2ODYzRDg5RTEyQjEzMzA0REREMDJBMTc5RUYxRTY5RjJGMTBGN0MxOTkwNTlCQkJDODg0N0FGQ0Q5MzlFMjZEN0Q0MkM2NTkyQjA4QzQ2RjdFMEIwMTUwNEE5NTRGRDNBNTlFN0U2NzM1RjYzOTJBMzgyMUVDOUQyNENEQUQ4OEYwMTM5MDBENDc0RjQwRjJDQkE5Q0JBNDA5RDlEMkJGQ0QwQjE5NjQxNTQ1QjNFMUE5REM2MTVBQjQ2MjRENjQ0QzZBOEQzREZGRUVBOUQzRTFDMDlGRERFODU0Q0M1RTgzREI1NkEwMzlCRDFEQzFFNDIyMTA5RDQ2MjAwOTI4MTc3QjZBMzNEOTk1NjQzNjJDMTY1NjlBNzU3OTc2RTI4ODU2NUIwRDY0NEJCRUM1MTNBMjE2MUQxRDRDNzhEMzMyNEVDMjI1RjIwRjNGODlGREVFN0E4NTM0NTNGOTEwRENDNTM5RTVENTE2";
//    [self.mainBll initAppWithLicense:license];
    
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.cameraView = [self.mainBll getCameraPreView];
    [self.view addSubview:self.rightV];
    [self.rightV addPreview:self.cameraView];
    [self initBtnEvent];
    isNetworkReachability = YES;
    
    BOOL isAuthorizd =  [[NSUserDefaults standardUserDefaults] boolForKey:@"authorize"];
    NSString *license = [[NSUserDefaults standardUserDefaults] stringForKey:@"license"];
    if (!isAuthorizd || !license) {
        Class targetClass = NSClassFromString(@"ScanQRCodeViewController");
        UIViewController *target = [[targetClass alloc] init];
        target.modalPresentationStyle = UIModalPresentationCurrentContext;
        [self presentViewController:target animated:YES completion:nil];
        return;
    } else {
        _isEnable = YES;
        [self.mainBll initAppWithLicense:license];
//        self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
//        self.cameraView = [self.mainBll getCameraPreView];
//        [self.view addSubview:self.rightV];
//        [self.rightV addPreview:self.cameraView];
//        [self initBtnEvent];
//        isNetworkReachability = YES;
        
        
        
//        [self customViewWillAppear];
    self.mainBll.resoureUpdateDelegate = self;
    self.mainBll.audioStatusDelegate = self;
    self.mainBll.loginDelegate = self;
    self.mainBll.recognitionDelegate = self;
    self.mainBll.cameraDelegate = self;
//    self.animationManager = [VTAnimationManager sharedManager];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentVController) name:@"custom_viewwillappear" object:nil];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mainBll openCameraWithCameraPosition:VTCameraPositionFront];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mainBll startRecognition];
        });
    });
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [VTAudioManager sendMessage:MSG_PAUSE_ALLAUDIOS];
    [[VTAnimationManager sharedManager] changeAnimation:2 andType:-2];
    [VTGlobalObject cancleAllTimer];
    [self.mainBll stopRecognition];
}

-(void)customViewWillAppear{
    self.mainBll.cameraDelegate = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mainBll openCameraWithCameraPosition:VTCameraPositionFront];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.mainBll startRecognition];
        });
    });
}

#pragma mark ----- VTRecognitionDelegate -----

-(void)recognitionFailed:(VTErrorCode)errCode{
//    if (self.isNetworkReachability) {
        if (errCode == VTErrorCode_Timeout || errCode == VTErrorCode_ServerError) {
            [VTAudioManager sendMessage:MSG_NETWORK_TIMEOUT];
        }else if(errCode == VTErrorCode_BadNetwork){
            [VTAudioManager sendMessage:MSG_NETWORK_TIMEOUT];
        }else if (errCode == VTErrorCode_LowNetwork){
            [VTAudioManager sendMessage:MSG_NETWORK_LOW];
        }
//    }
}

-(void)recognitionSuccess:(VTSDKBookDataModel *)data{
    [self updateSubview:data];
}

#pragma mark -------VTCameraDataDelegate---
- (void)cameraDidOpened{
    
}

-(void)onPreviewFrame:(CMSampleBufferRef)frameBuffer{
//    NSData *imageData = [self imageMat2Data:[self imageBuff2Mat:frameBuffer]];
//    [VTMainBLLObj getFeedbackResult:imageData Callback:self];
}

-(void)cameraOpenFailedWithError:(NSError *)error {
    
}


#pragma mark ------- VTResoureUpdateDelegate --------

- (void)resoureUpdatingWithProgress:(int)progress bookId:(int)bookId isForeground:(BOOL)isForeground{
    if(isForeground){
//        [self.animationManager changeAnimation:progress andType:-3];
//        if (self.right) {
            [self updateProgress:progress];
//        }
    }
}

- (void)resoureUpdateDidComplete:(int)bookId isForeground:(BOOL)isForeground{
    if(isForeground){
        [VTAudioManager sendMessage:MSG_RES_DOWNLOAD_END];
//        if (self.right) {
            self.state = VTPreviewStateReadStart;
//        }
        [self updateComplete];
    }
}

- (void)resoureWillUpdate:(int)bookId isForeground:(BOOL)isForeground{
    if(isForeground){
        [VTAudioManager sendMessage:MSG_RES_DOWNLOAD_START];
//        if (self.right) {
            self.state = VTPreviewStateDownloadStart;
//        }
    }
}

- (void)resoureUpdateFailed:(VTErrorCode)errCode bookId:(int)bookId isForeground:(BOOL)isForeground{
    if(isForeground){
//        if (self.isNetworkReachability ) {
            if ( errCode == VTErrorCode_DownloadFailed) {
                [VTAudioManager sendMessage:MSG_RES_DOWNLOAD_FAIL];
            }else if (errCode == VTErrorCode_Timeout || errCode == VTErrorCode_ServerError){
                [VTAudioManager sendMessage:MSG_NETWORK_TIMEOUT];
            }
//        }
        [self updateComplete];
    }
}

- (void)allUpdateTaskWillToBackgroud{
    //这个地方要取消掉下载的提示语音
    [VTAudioManager sendMessage:MSG_CANCLE_DOWNLOAD_TIPS];
}

-(void)updateComplete{
//    if(self.isNetworkReachability){
//        [self.animationManager changeAnimation:2 andType:-2];
//    }
}

#pragma mark --- VTInitAPPStatusDelegate ---
-(void)onInitAPPSuccess{
//    self.initLicenseSuccess = true;
    float welcomeTime = ceil([VTAudioManager audioSoundDuration:SYS_BR_PROLOGUE]);
    [self.mainBll openCameraWithCameraPosition:VTCameraPositionFront];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(welcomeTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mainBll startRecognition];
    });
    [VTAudioManager sendMessage:MSG_WELCOME_GUIDE];
}

-(void)onInitAPPFail:(VTErrorCode) error{
//    self.initLicenseSuccess = false;
//    if (error == VTErrorCode_InvalidLicense) {
//        NSLog(@"onInitAPPFail -- VTErrorCode_InvalidLicense");
//        [VTAudioManager sendMessage:MSG_LICENSE_CHECK_FAIL];
//    }else if (error == VTErrorCode_Timeout){
//        NSLog(@"onInitAPPFail -- VTErrorCode_NetError");
//        [VTAudioManager sendMessage:MSG_NETWORK_CONNECT_FAIL];
//    }
}

#pragma mark --VTAudioStatusDelegate--
-(void)bookAudioDidFinish{
    
//    [self.animationManager changeAnimation:2 andType:-2];
    [VTAudioManager sendMessage: MSG_PAGETURN_WARNING_PLAY];
//    if(self.right){
        self.state = VTPreviewStateReadEnd;
//    }
}

-(void)bookAudioWillPlay{
    [VTAudioManager sendMessage:MSG_CANCEL_PAGETURN_WARNING_PLAY];
//    [self.animationManager changeAnimation:3 andType:-2];
//    if (self.right) {
        self.state = VTPreviewStateReadStart;
//    }
}

#pragma mark -----app override

-(BOOL)shouldAutorotate{
    return NO;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}




#pragma mark -----private methods-----
-(void)initBtnEvent{
    __weak __typeof(self)weakSelf = self;
    self.rightV.btnAction = ^(UIButton * btn) {
        //        if (!weakSelf.isEnable) {
        //            return ;
        //        }
        switch (btn.tag) {
            case 1000:
                if (weakSelf.state == VTPreviewStateReadStart) {
                    if (!btn.isSelected) {
                        [VTAudioManager sendMessage:MSG_PAUSE_ALLAUDIOS];
                        [[VTAnimationManager sharedManager] changeAnimation:2 andType:-2];
                    }else{
                        [VTAudioManager sendMessage:MSG_RESTART_ALLAUDIOS];
                        [[VTAnimationManager sharedManager] changeAnimation:3 andType:-2];
                    }
                    btn.selected = !btn.isSelected;
                    if (btn.isSelected) {
                        weakSelf.rightV.playBtnName.text =@"播放";
                    }else{
                        weakSelf.rightV.playBtnName.text =@"暂停";
                    }
                }
                break;
            case 1001:
                [VTAudioManager sendMessage:MSG_STOP_ALLAUDIOS];
                [weakSelf.mainBll playBookAudio];
                [weakSelf.rightV changeUI:4];
                break;
            default:
                break;
        }
        //        if (weakSelf.isEnable) {
        //            weakSelf.isEnable = NO;
        //        }
        //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //            weakSelf.isEnable = YES;
        //        });
    };
}

-(void) updateSubview:(VTSDKBookDataModel *)model{
    [_rightV updateViews:model];
}

-(void) updateProgress:(CGFloat) progress{
    if( _rightV.progressView.isHidden) _rightV.progressView.hidden = NO;
    _rightV.progressView.value = progress*0.01;
    if (progress == 100) {
        [_rightV.progressView reset];
    }
}

#pragma  ------网络监听--------

-(void)networkDidNotReachable{
    isNetworkReachability = NO;
}

-(void)networkDidReachable{
    isNetworkReachability = YES;
}

#pragma mark ----getter and setter-----

-(void)setState:(VTPreviewState)state{
    _state = state;
    [_rightV changeUI:state];
}

-(void)setCameraView:(UIView *)cameraView{
    _cameraView = cameraView;
}

-(RightView *)rightV{
    if (_rightV == nil) {
        _rightV = [[RightView alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KTabBarHeight)];
    }
    return _rightV;
}

-(VTMainBLLObj *)mainBll{
    if (_mainBll == nil) {
        _mainBll = [[VTMainBLLObj alloc]init];
    }
    return _mainBll;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"custom_viewwillappear" object:nil];
}

#pragma mark -- 检测是否有相机权限
- (void)isCanUseSystemCamera{
    if (![XSYTapSound ifCanUseSystemCamera]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"一家老小”已禁用相机" message:@"请在iPhone的“设置”选项中,允许“一家老小”访问你的相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alertView show];
        
        [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber * _Nullable x) {
            if ([x isEqual:@1]) {
                [ATYUtils openSystemSettingView];
            }
        }];
    }
}

#pragma mark -- 检测摄像头是否可用
- (BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera];
}

#pragma mark -- 通知
-(void)presentVController{
    _isEnable = YES;
    NSString *license = [[NSUserDefaults standardUserDefaults] stringForKey:@"license"];
    [self.mainBll initAppWithLicense:license];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    self.cameraView = [self.mainBll getCameraPreView];
    [self.view addSubview:self.rightV];
    [self.rightV addPreview:self.cameraView];
    [self initBtnEvent];
    isNetworkReachability = YES;
    //        [self customViewWillAppear];
    self.mainBll.resoureUpdateDelegate = self;
    self.mainBll.audioStatusDelegate = self;
    self.mainBll.loginDelegate = self;
    self.mainBll.recognitionDelegate = self;
    self.mainBll.cameraDelegate = self;
    [self customViewWillAppear];
}

@end
