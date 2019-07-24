//
//  AudioManager.h
//  Unity-iPhone
//
//  Created by 隔壁老王 on 2019/1/10.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    MSG_WELCOME_GUIDE = 1000,
    MSG_FENGMIAN_TIPS,
    MSG_FENGMIAN_TIPS_5,
    MSG_DOWMLOAD_PAGETURN,
    MSG_RES_DOWNLOAD_START,
    MSG_RES_DOWNLOAD_END,
    MSG_RES_DOWNLOAD_FAIL,
    MSG_CANCLE_DOWNLOAD_TIPS,
    MSG_START_DOWNLOAD_TIPS,
    MSG_PAGETURN_WARNING_PLAY,
    MSG_CANCEL_PAGETURN_WARNING_PLAY,
    MSG_NETWORK_CONNECT_FAIL,
    MSG_NETWORK_LOWDATA,
    MSG_LICENSE_CHECK_FAIL,
    MSG_SERVER_MAINTENANCE,
    MSG_NETWORK_UNAVAILABLE,
    MSG_NETWORK_TIMEOUT,
    MSG_UPDATE_START,
    MSG_START_SCAN,
    MSG_NETWORK_DISCONNECT,
    MSG_CANCLE_NETWORK_DISCONNECT,
    MSG_NETWORK_CONNECTED,
    MSG_NETWORK_LOW,
    MSG_PAUSE_ALLAUDIOS,
    MSG_RESTART_ALLAUDIOS,
    MSG_STOP_ALLAUDIOS,
    MSG_SCAN_RESULT_EF,
    MSG_SCAN_QRCODE_INVALID,
    MSG_SCAN_QRCODE_LIMIT,
    MSG_SCAN_QRCODE_FALSE,
    MSG_SCAN_QRCODE_SUCCEED,
    MSG_SCAN_TIPS,
    MSG_BTN_EF
    
} AudioMessageType;

@protocol VTAudioStatusDelegate;
@interface VTAudioManager : NSObject

@property (nonatomic, weak) id<VTAudioStatusDelegate> delegate;
+(instancetype)shared;
+(void)sendMessage:(AudioMessageType) message;
+(void)playBookAudioWithPageId:(NSNumber *)pageId audioDatas:(NSMutableArray *)audioDatas path:(NSString *)filepath pageType:(NSNumber *)pageType;
+(void)playBookAudioWithPageId:(NSNumber *)pageId audioDatas:(NSMutableArray *)audioDatas path:(NSString *)filepath pageType:(NSNumber *)pageType networkStatus:(NSNumber *)networkStatus;
+(float)audioSoundDuration:(NSString *)audioName;

@end

NS_ASSUME_NONNULL_END
