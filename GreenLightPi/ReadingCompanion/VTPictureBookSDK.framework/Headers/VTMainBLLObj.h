//
//  VTMainBLL.h
//  VTPictureBook
//
//  Created by wantong_clover on 2019/1/8.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "VTSDKDelegate.h"


NS_ASSUME_NONNULL_BEGIN
@class VTCameraView;
@interface VTMainBLLObj : NSObject

@property (nonatomic, weak) id<VTCameraDataDelegate> cameraDelegate;
@property (nonatomic, weak) id<VTRecognitionDelegate> recognitionDelegate;
@property (nonatomic, weak) id<VTResoureUpdateDelegate> resoureUpdateDelegate;
@property (nonatomic, weak) id<VTAudioStatusDelegate> audioStatusDelegate;
@property (nonatomic, weak) id<VTInitAPPStatusDelegate> loginDelegate;
@property (nonatomic, strong) VTCameraView * cameraView;
//必须要先调这个
-(void)initAppWithLicense:(NSString *)license;

//开启摄像头的预览,开启后会调用回调
-(void)openCameraWithCameraPosition:(VTCameraPosition)position;

//关闭摄像头，关闭后预览不会回调
-(void)closeCamera;

//开始识别，开启识别后会调用
-(void)startRecognition;

//停止识别，停止识别后会调用
-(void)stopRecognition;

-(void)applicationDidEnterBackground;

-(void)applicationWillEnterForeground;

+(void)getQRcodeAuthResult:(NSString *)code Callback:(id<VTQRCodeDelegate>) delegate;

-(UIView *)getCameraPreView;

-(BOOL)playBookAudio;

+(void)getFeedbackResult:(NSData *)image Callback:(id<VTFeedbackDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
