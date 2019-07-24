//
//  PCEquityProfitView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/9.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "BaseTableView.h"

typedef enum : NSUInteger {
    ProfitViewTypeProfit = 1,// ,收益列表
    ProfitViewTypeCashOutRecord,// ,提现记录列表
} ProfitViewType;

NS_ASSUME_NONNULL_BEGIN

@interface PCEquityProfitView : BaseTableView
@property (nonatomic, strong) void(^selectTimeBlock)(void);
@property (nonatomic, copy) NSString *selectTime;
@property (nonatomic, assign) ProfitViewType profitViewType;
@end

NS_ASSUME_NONNULL_END
