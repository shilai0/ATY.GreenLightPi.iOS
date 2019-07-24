//
//  BabyInfoViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

@interface BabyInfoViewController : BaseViewController
@property (nonatomic, assign) BOOL isAdd;
@property (nonatomic, copy) void(^saveBabyInfoBlock)(NSMutableArray *dataArr,NSDictionary *params);
@property (nonatomic, strong) NSMutableDictionary *dataParams;//当前显示宝宝信息
@end
