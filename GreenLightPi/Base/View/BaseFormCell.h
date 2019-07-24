//
//  BaseFormCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BaseFormView;
@class BaseDetailFormModel;
@interface BaseFormCell : UITableViewCell
@property (nonatomic, strong) BaseFormView *formView;
@property (nonatomic, strong) BaseDetailFormModel *detailModel;
@end
