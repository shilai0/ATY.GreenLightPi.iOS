//
//  PCMainCollectionViewCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/23.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCMainCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy) void(^cellBtnClick)(void);
@property (nonatomic, strong) NSDictionary *dic;
@end
