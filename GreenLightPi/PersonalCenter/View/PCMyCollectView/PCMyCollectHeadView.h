//
//  PCMyCollectHeadView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/26.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseView.h"

@interface PCMyCollectHeadView : BaseView
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, copy) void(^selectBlock)(NSInteger index);
@property (nonatomic, assign) NSInteger selectedIndex;
@end
