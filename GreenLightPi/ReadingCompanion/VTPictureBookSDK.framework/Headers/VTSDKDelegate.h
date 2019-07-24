//
//  VTSDKDelegate.h
//  VTPictureBook
//
//  Created by wantong_clover on 2019/1/11.
//

#ifndef VTSDKDelegate_h
#define VTSDKDelegate_h
#import <CoreMedia/CoreMedia.h>
#import "VTSDKCore.h"

@class VTSDKBookDataModel;
@protocol VTInitAPPStatusDelegate <NSObject>
@optional
-(void)onInitAPPSuccess;
-(void)onInitAPPFail:(VTErrorCode)error;
@end

//下载代理
@protocol VTResoureUpdateDelegate <NSObject>
@optional
- (void)resoureUpdatingWithProgress:(int)progress bookId:(int)bookId isForeground :(BOOL)isForeground;
- (void)resoureUpdateDidComplete:(int)bookId isForeground :(BOOL)isForeground;
- (void)resoureWillUpdate:(int)bookId isForeground :(BOOL)isForeground;
- (void)resoureUpdateFailed:(VTErrorCode)errCode bookId:(int)bookId isForeground :(BOOL)isForeground;
//所有的更新任务将退到后台
- (void)allUpdateTaskWillToBackgroud;
@end



//网络的代理
@protocol VTNetworkStatusDelegate <NSObject>
@optional
- (void)networkSatusWillChange:(VTNetworkStatusCode)status;
@end


//识别代理////////
@protocol VTRecognitionDelegate <NSObject>
@optional
- (void)recognitionWillStart;
- (void)recognitionFailed:(VTErrorCode)errCode;
- (void)recognitionSuccess:(VTSDKBookDataModel *)data;
@end
///////////////

//摄像头的代理类，所有的代理消息回调都是可选的
@protocol VTCameraDataDelegate <NSObject>
@optional
//摄像头的预览消息，返回图像buffer
- (void)onPreviewFrame:(CMSampleBufferRef)frameBuffer;
//摄像头失败的数据消息，返回失败错误代码
- (void)cameraOpenFailedWithError:(VTCameraErrorCode)errcode;
//摄像头已经打开的消息
- (void)cameraDidOpened;
//摄像头即将关闭的消息，应用收到此消息应当释放摄像头组件外部使用的资源
- (void)cameraWillClosed;
//摄像头已经关闭的消息
- (void)cameraDidClosed;
@end

//认读音频
@protocol VTAudioStatusDelegate <NSObject>
@optional
- (void)bookAudioWillPlay;
- (void)bookAudioDidFinish;
- (void)sysAudioWillPlay;
-(void)sysAudioDidFinish;
@end

@protocol VTQRCodeDelegate <NSObject>
@optional
- (void)scanSuccess:(NSDictionary *)result;
- (void)scanFail:(VTErrorCode)error;
@end

@protocol VTFeedbackDelegate<NSObject>
@optional
-(void)getFeedbackSuccess:(NSDictionary *)result;
-(void)getFeedbackFail:(VTErrorCode)error;
@end

//APP的代理
@protocol VTAppDelegate <NSObject>
@optional
- (void)appNeedUpdateWithInfo:(NSDictionary *)info;
@end

#endif /* VTSDKDelegate_h */
