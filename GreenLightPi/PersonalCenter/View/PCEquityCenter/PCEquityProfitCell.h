//
//  PCEquityProfitCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/9.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class IncomeModel,MyTeamModel,MyBillDetailModel;
@interface PCEquityProfitCell : UITableViewCell
@property (nonatomic, strong) IncomeModel *incomeModel;
@property (nonatomic, strong) MyTeamModel *myTeamModel;
@property (nonatomic, strong) MyBillDetailModel *myBillDetailModel;
@end

NS_ASSUME_NONNULL_END
