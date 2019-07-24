//
//  HMShareCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMShareCell : UICollectionViewCell
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, copy) void(^itemBtnBlock)(void);
@property (nonatomic, strong) UIButton *itemButton;
@end
