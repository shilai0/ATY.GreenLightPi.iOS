//
//  BabyListView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/14.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseTableView.h"

@interface BabyListView : BaseTableView
@property (nonatomic, copy)void(^deletBlock)(NSArray *dataArr,NSIndexPath *indexPath);
@end
