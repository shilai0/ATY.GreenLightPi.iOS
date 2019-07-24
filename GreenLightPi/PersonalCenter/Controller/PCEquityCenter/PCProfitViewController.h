//
//  PCProfitViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/9.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

typedef enum : NSUInteger {
    ProfitTypeDirectSaleIncome = 1,//直销奖励 ,
    ProfitTypeFissionIncome,//裂变奖励 ,
    ProfitTypeTeamIncome,//团队奖励 ,
    ProfitTypeDevelopIncome,//发展奖励 ,
    ProfitTypeCityIncome,//城市奖励 ,
} ProfitType;


NS_ASSUME_NONNULL_BEGIN

@interface PCProfitViewController : BaseViewController
@property (nonatomic, assign) ProfitType profitType;
@end

NS_ASSUME_NONNULL_END
