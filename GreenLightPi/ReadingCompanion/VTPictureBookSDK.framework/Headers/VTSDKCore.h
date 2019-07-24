//
//  VTSDKCore.h
//  VTPictureBook
//
//  Created by wantong_clover on 2019/1/8.
//

#ifndef VTSDKCore_h
#define VTSDKCore_h

#define CACHEMAXSIZE 500

typedef NS_ENUM(NSInteger, VTCameraPosition) {
    VTCameraPositionUnspecified = 0,      //未指定
    VTCameraPositionBack  = 1,            //后置摄像头
    VTCameraPositionFront = 2             //前置摄像头
};

typedef NS_ENUM(NSInteger, VTErrorCode) {
    
    VTErrorCode_Success ,                                               //没有错误
    VTErrorCode_Unknown ,                                            //未知错误
    VTErrorCode_NoNetwork,
    VTErrorCode_Canceled,
    VTErrorCode_ParamsError,
    VTErrorCode_Timeout,
    VTErrorCode_NoError,
    VTErrorCode_InvalidToken = 1000,
    VTErrorCode_InvalidLicense = 1001,                                  //未通过License校验//Token失效
    VTErrorCode_NoPage = 10000,                              //图片中没有任何书页
    VTErrorCode_ServerError = 50004,                          //服务器内部错误
    VTErrorCode_DownloadFailed = 4000,
    VTErrorCode_BadNetwork = 3000,
    VTErrorCode_LowNetwork = 3001,
    VTErrorCode_WeakNetwork = 3002,
    VTErrorCode_IllegalQRCode = 70001,
    VTErrorCode_NumOfQRCodeUsedUp = 70002,
    VTErrorCode_LicenseEmpty = 70003,//网络连接错误
    
};

typedef NS_ENUM(NSInteger, VTCameraErrorCode) {
    VTCameraErrorCode_NoPermission = 3                                  //没有摄像头访问权限
};

//typedef NS_ENUM(NSInteger, VTRecognitionErrorCode) {
//    VTRecognitionErrorCode_NoPage = 10000,                              //图片中没有任何书页
//    VTRecognitionErrorCode_ServerError = 50004,                          //服务器内部错误
//    VTRecognitionErrorCode_BadNetwork = 3000,
//    VTRecognitionErrorCode_LowNetwork = 3001,
//    VTRecognitionErrorCode_WeakNetwork = 3002
//};

typedef NS_ENUM(NSInteger, VTNetworkStatusCode) {
    VTNetworkReachabilityStatusUnknown = 2000,                              //未知网络
    VTNetworkReachabilityStatusNotReachable ,                        //网络断开
    VTNetworkReachabilityStatusReachableViaWWAN,                     //移动网络
    VTNetworkReachabilityStatusReachableViaWiFi                           //wifi网络
};

typedef NS_ENUM(NSInteger,VTLogLevel){
    VTLogError,
    VTLogWarn,
    VTLogInfo,
    VTLogVerbose
};

#endif /* VTSDKCore_h */
