//
//  PCParentCenterCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/12.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class BaseFormView,BaseDetailFormModel;
@interface PCParentCenterCell : UITableViewCell
@property (nonatomic, strong) BaseFormView *formView;
@property (nonatomic, strong) BaseDetailFormModel *detailModel;
@end
NS_ASSUME_NONNULL_END
