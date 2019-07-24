//
//  HMMainViewAccompanyCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/20.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMMainViewAccompanyCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@interface HMMainViewAccompanyCell : UITableViewCell
@property (nonatomic, strong) HMMainViewAccompanyCollectionView *collectionView;
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;
@end
