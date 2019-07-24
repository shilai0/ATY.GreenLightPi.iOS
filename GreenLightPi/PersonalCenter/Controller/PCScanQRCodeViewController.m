//
//  PCScanQRCodeViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/17.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCScanQRCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanView.h"

#define previewRect CGRectMake((KSCREEN_WIDTH - 250) / 2, (KSCREENH_HEIGHT - 250 - 100)/2, 250, 250)

@interface PCScanQRCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) AVCaptureDevice *device;

@property (strong, nonatomic) AVCaptureDeviceInput *input;

@property (strong, nonatomic) AVCaptureMetadataOutput *output;

@property (strong, nonatomic) AVCaptureSession *session;

@property (strong, nonatomic) AVCaptureVideoPreviewLayer *preview;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) ScanView *scanView;

@property (strong, nonatomic) ScanQRCodeResult complete;
@end

@implementation PCScanQRCodeViewController

- (instancetype)initWithComplete:(ScanQRCodeResult)complete {
    self = [super init];
    if (self) {
        self.complete = complete;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_session && ![_session isRunning]) {
        [_session startRunning];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.scanView];
    self.navView.hidden = YES;
    [self setupCamera];
}

-(ScanView *)scanView {
    
    if (!_scanView) {
        
        CGRect rect = previewRect;
        _scanView = [[ScanView alloc] initWithFrame:rect];
        _scanView.backgroundColor = [UIColor clearColor];
        [_scanView sweepAnimation];
    }
    return _scanView;
}

//添加背景照片
- (void)addBgImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - 64)];
    imageView.image = [UIImage imageNamed:@"scan_code_box"];
    [self.view addSubview:imageView];
}

- (void)setupCamera
{
    @weakify(self);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        // Device
        @strongify(self);
        self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
        // Input
        self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
            
        // Output
        self.output = [[AVCaptureMetadataOutput alloc]init];
        //    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
            
        // Session
        self.session = [[AVCaptureSession alloc]init];
        [self.session setSessionPreset:AVCaptureSessionPresetHigh];
        if ([self.session canAddInput:self.input])
        {
            [self.session addInput:self.input];
        }
            
        if ([self.session canAddOutput:self.output])
        {
            [self.session addOutput:self.output];
        }
            
        // 条码类型 AVMetadataObjectTypeQRCode
        self.output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
            
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            // Preview
            self.preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
            self.preview.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT);
            //_preview.frame = CGRectMake(0, 0, WIDTH, HEIGHT - 64);
            self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
            //            _preview.frame = self.view.bounds;
            [self.view.layer insertSublayer:self.preview atIndex:0];
                
            //            CGRect rect = CGRectMake((WIDTH - 250) / 2, (HEIGHT - 250 - 72)/2, 250, 250);
            self.output.rectOfInterest = [self.preview metadataOutputRectOfInterestForRect:previewRect];
                
            UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT)];
            //UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 64)];
            maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
            [self.view addSubview:maskView];
                
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [maskView addGestureRecognizer:tap];
                
            UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT)];
                [rectPath appendPath:[[UIBezierPath bezierPathWithRoundedRect:previewRect cornerRadius:1] bezierPathByReversingPath]];
                
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            shapeLayer.path = rectPath.CGPath;
                
            maskView.layer.mask = shapeLayer;
                
            UILabel *explainLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCREENH_HEIGHT/2 + 110, KSCREEN_WIDTH, 13)];
            explainLabel.text = @"将二维码放入取景框中即可自动扫描";
            explainLabel.textColor = [UIColor whiteColor];
            explainLabel.font = [UIFont systemFontOfSize:13];
            explainLabel.textAlignment = NSTextAlignmentCenter;
            [self.view addSubview:explainLabel];
                
            // Start
            [self.session startRunning];
        });
    });
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.timer invalidate];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if (metadataObjects != nil && [metadataObjects count] > 0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        self.complete(stringValue);
        
        if (self.scanQRCodeSuccessBlock) {
            self.scanQRCodeSuccessBlock();
        }
        
        [ATYToast aty_bottomMessageToast:@"扫描成功"];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    [_session stopRunning];
    [self.timer invalidate];
    NSLog(@"%@",stringValue);
    
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
