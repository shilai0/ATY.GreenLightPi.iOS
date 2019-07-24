//
//  HMParkUseRankCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/3.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class HMParkUseRankListView,UseLogModel;
@interface HMParkUseRankCell : UITableViewCell
@property (nonatomic, copy) void(^openOrCloseBlock)(BOOL isOpen);
@property (nonatomic, strong) HMParkUseRankListView *parkUseRankListView;
@property (nonatomic, strong) UseLogModel *model;
@end

NS_ASSUME_NONNULL_END
