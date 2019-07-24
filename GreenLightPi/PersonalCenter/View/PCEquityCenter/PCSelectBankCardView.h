//
//  PCSelectBankCardView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/14.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN
@class PCSelectCardTableView;
@interface PCSelectBankCardView : BaseView
@property (nonatomic, strong) NSMutableArray *cardArr;
@property (nonatomic, strong) PCSelectCardTableView *selectCardTableView;
@end

NS_ASSUME_NONNULL_END
