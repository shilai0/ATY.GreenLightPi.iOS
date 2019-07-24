//
//  PCMainCollectionView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/23.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCMainCollectionView : UICollectionView
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, copy) void(^pushBlock)(NSArray *dataArr,NSIndexPath *indexPath);
@end
