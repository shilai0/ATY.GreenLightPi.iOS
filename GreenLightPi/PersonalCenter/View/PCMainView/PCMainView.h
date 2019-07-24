//
//  PCMainView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/10/23.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseTableView.h"

@interface PCMainView : BaseTableView
@property (nonatomic, copy) void(^scrollBlock)(UIScrollView *scrollView);
@end
