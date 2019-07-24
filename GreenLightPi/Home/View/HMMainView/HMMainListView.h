//
//  HMMainListView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/21.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseTableView.h"

NS_ASSUME_NONNULL_BEGIN

@class HMMainSectionHeadView;
@interface HMMainListView : BaseTableView
@property (nonatomic, strong) HMMainSectionHeadView *sectionOneHeadView;
@property (nonatomic, strong) void(^parentingBlock)(NSMutableArray *dataArr, NSIndexPath *index);
@end

NS_ASSUME_NONNULL_END
