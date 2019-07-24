//
//  FCAudioClassCollectionView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/18.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FCAudioClassCollectionView : UICollectionView
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, copy) void(^clickCellBlock)(NSArray *dataArr,NSIndexPath *index);
@end
