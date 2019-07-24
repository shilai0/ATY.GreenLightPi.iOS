//
//  FCPurchaseCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FCPurchaseModel;
@interface FCPurchaseCell : UITableViewCell
@property (nonatomic, strong) UIButton *logolBtn;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) FCPurchaseModel *model;
@property (nonatomic, copy) void(^selectBtnBlock)(void);
@end
