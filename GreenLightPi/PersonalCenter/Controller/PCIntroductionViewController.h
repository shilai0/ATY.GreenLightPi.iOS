//
//  PCIntroductionViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

@interface PCIntroductionViewController : BaseViewController
@property (nonatomic, copy) NSString *introductionStr;
@property (nonatomic, copy) void (^updateBlock)(NSString *introductionStr);
@end
