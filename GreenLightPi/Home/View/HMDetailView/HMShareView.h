//
//  HMShareView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HMShareFooterView;
@interface HMShareView : UICollectionView
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, copy) void(^clickCellBlock)(NSArray *dataArr,NSIndexPath *indexPath);
@property (nonatomic, strong) HMShareFooterView *footerView;
@property (nonatomic, assign) BOOL isWonderfulMoment;
@end
