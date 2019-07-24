//
//  PCAuthenFooterView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/1.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseView.h"

@interface PCAuthenFooterView : BaseView
@property (nonatomic, copy) void(^addBtnBlock)(void);
@property (nonatomic, strong) UIImage *IdCardimage;
@end
