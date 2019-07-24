//
//  PCScanQRCodeViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/17.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface PCScanQRCodeViewController : BaseViewController

typedef void(^ScanQRCodeResult)(NSString *serialNumber);

@property (nonatomic, copy) void(^scanQRCodeSuccessBlock)(void);

/**
 *  通过闭包返回获取到的字符串
 *
 *  @param complete 含有扫描结果字符串的闭包
 *
 *  @return 返回一个当前对象
 */
- (instancetype)initWithComplete:(ScanQRCodeResult) complete;

@end

NS_ASSUME_NONNULL_END
