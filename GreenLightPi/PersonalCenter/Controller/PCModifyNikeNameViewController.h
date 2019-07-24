//
//  PCModifyNikeNameViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

@interface PCModifyNikeNameViewController : BaseViewController
@property (nonatomic, copy) NSString *nikeName;
@property (nonatomic, copy) void (^updateBlock)(NSString *nikeName);
@end
