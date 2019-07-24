//
//  HMMainViewParentingCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/20.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeModel;
@interface HMMainViewParentingCell : UITableViewCell
@property (nonatomic, strong) NSArray *parentingArr;
@property (nonatomic, strong) HomeModel *homeModel;
@property (nonatomic, copy) void(^singleBlock)(NSInteger singleIndex);
@end

