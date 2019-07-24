//
//  VTConst.h
//  clover
//
//  Created by clover on 19/01/02.
//  Copyright © 2019年 clover. All rights reserved.
//

#ifndef Const_h
#define Const_h

#pragma mark - 服务器地址

//#define SAVEIMAGE 0
#ifdef DEBUG

#define LOGD(...)\
{NSTimeInterval time_interval = [[NSDate date]timeIntervalSince1970];\
NSString *logoInfo = [NSString stringWithFormat:__VA_ARGS__];\
NSLog(__VA_ARGS__);\
[[NSNotificationCenter defaultCenter] postNotificationName:@"xk_log_noti" object: [NSString stringWithFormat:@"%.2f %@\n %@\n",time_interval,[NSThread currentThread],logoInfo]];}

//fprintf(stderr,"[%s:%d行] %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [logoInfo UTF8String]); \

#else

#define LOGD(...) ;

#endif

//weakself
#define WEAKSELF_SC __weak __typeof(&*self)weakSelf_SC = self;
#define APPVER  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define ROOT_AUDIOS @"sound.bundle"
#define SYS_STARTUP_QRCODE_SCAN_EF @"sys_startup_qrcode_scan_ef"
#define SYS_STARTUP_QRCODE_INVALID @"sys_startup_qrcode_invalid"
#define SYS_STARTUP_QRCODE_LIMIT @"sys_startup_qrcode_limit"
#define SYS_STARTUP_QRCODE_FALSE @"sys_startup_qrcode_false"
#define SYS_STARTUP_QRCODE_SUCCEED @"sys_startup_qrcode_succeed"
#define BGM_SYS_START @"bgm_sys_start"
#define SYS_BR_PROLOGUE @"sys_br_prologue"
#define SYS_BR_START @"sys_br_start"
#define SYS_BR_STARTCLEAN @"sys_br_startclean"
#define SYS_BR_SHOWCOVER1 @"sys_br_showcover1"
#define SYS_BR_SHOWCOVER2 @"sys_br_showcover2"
#define SYS_BR_SHOWCOVER3 @"sys_br_showcover3"
#define SYS_DOWNLOAD_BRPAGE @"sys_download_brpage"
#define BGM_SYS_DOWNLOAD @"bgm_sys_download"
#define SYS_RES_UPDATE_START @"sys_download_start"
#define SYS_RES_UPDATE_TIPS1 @"sys_download_tips1"
#define SYS_RES_UPDATE_TIPS2 @"sys_download_tips2"
#define SYS_RES_UPDATE_TIPS3 @"sys_download_tips3"
#define SYS_RES_UPDATE_TIPS4 @"sys_download_tips4"
#define SYS_RES_UPDATE_TIPS5 @"sys_download_tips5"
#define SYS_RES_UPDATE_TIPS6 @"sys_download_brpage"
#define SYS_RES_UPDATE_COMPLETE @"sys_download_ef_decompress"
#define SYS_NETWORK_DOWNLOADFAILED @"sys_network_downloadfailed"
#define SYS_BR_NEXTPAGE1 @"sys_br_nextpage1"
#define SYS_BR_NEXTPAGE2 @"sys_br_nextpage2"
#define SYS_BR_NEXTPAGE3 @"sys_br_nextpage3"
#define SYS_BR_NEXTPAGE4 @"sys_br_nextpage4"
#define SYS_BR_NEXTPAGE5 @"sys_br_nextpage5"
#define SYS_NETWORK_LICENSELOW @"sys_network_licenselow"
#define SYS_NETWORK_TIMEOUT @"sys_network_timeout"
#define SYS_STARTUP_LICENSE_FALSE @"sys_startup_license_false"
#define SYS_HTTPERROR_NPAGETIMEOUT @"sys_httperror_npagetimeout"
#define SYS_STARTUP_NETWORK_OFF @"sys_startup_network_off"
#define SYS_STARTUP_QRCODE_SCAN @"sys_startup_qrcode_scan"
#define SYS_NETWORK_DISCONNECTION @"sys_network_disconnection"
#define SYS_NETWORK_CONNECTED @"sys_network_connected"
#define SYS_STARTUP_QRCODEHELP @"sys_startup_qrcodehelp"
#define SYS_BR_EF_COVER @"sys_br_ef_cover"
#define SYS_NETWORK_UNSTABLE @"sys_network_unstable"
#define SYS_NETWORK_LOW @"sys_network_low"
#define SYS_NETWORK_LOWDATA @"sys_network_lowdata"
#endif /* Const_h */
