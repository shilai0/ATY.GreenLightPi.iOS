//
//  PCBussinessMessageCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BusinessMessageModel;
@interface PCBussinessMessageCell : UITableViewCell
@property (nonatomic, strong) BusinessMessageModel *model;
@end