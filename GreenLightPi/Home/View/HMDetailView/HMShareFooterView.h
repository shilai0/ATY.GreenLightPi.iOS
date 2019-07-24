//
//  HMShareFooterView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMShareFooterView : UICollectionReusableView
@property (nonatomic, copy) void(^bottomBtnBlock)(void);
@end
