//
//  PCSystemMessageViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

@interface PCSystemMessageViewController : BaseViewController
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy) void(^updateStatusBlock)(void);
@end
