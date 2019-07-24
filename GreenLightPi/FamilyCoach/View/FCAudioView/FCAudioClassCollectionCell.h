//
//  FCAudioClassCollectionCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/18.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FcClassifyModel;
@interface FCAudioClassCollectionCell : UICollectionViewCell
@property (nonatomic, strong) FcClassifyModel *classModel;
@property (nonatomic, copy) void(^btnBlock)(void);
@end
