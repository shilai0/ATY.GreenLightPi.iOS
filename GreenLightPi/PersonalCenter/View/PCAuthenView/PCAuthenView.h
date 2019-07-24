//
//  PCAuthenView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/1.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseTableView.h"

@class PCAuthenFooterView;
@interface PCAuthenView : BaseTableView
@property (nonatomic, strong) PCAuthenFooterView *authenFooterView;
@property (nonatomic, strong) UIImage *IdCardimage;
@end
