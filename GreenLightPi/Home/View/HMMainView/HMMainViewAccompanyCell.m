//
//  HMMainViewAccompanyCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/20.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMainViewAccompanyCell.h"
#import "HMAccompanyCollectionViewCell.h"

@implementation HMMainViewAccompanyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatHMMainViewAccompanyCellSubViews];
    }
    return self;
}

- (void)creatHMMainViewAccompanyCellSubViews {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 6, 0, 6);
    layout.itemSize = CGSizeMake((KSCREEN_WIDTH - 16*2 - 12)/2, 240*KHEIGHTSCALE);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[HMMainViewAccompanyCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[HMAccompanyCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([HMAccompanyCollectionViewCell class])];
    
    self.collectionView.backgroundColor = KHEXRGB(0xFFFFFF);
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    [self.contentView addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.contentView);
        make.left.equalTo(@10);
        make.right.equalTo(@(-10));
        make.height.equalTo(@(240*KHEIGHTSCALE));
    }];
}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
    self.collectionView.dataSource = dataSourceDelegate;
    self.collectionView.delegate = dataSourceDelegate;
    self.collectionView.indexPath = indexPath;
    [self.collectionView setContentOffset:self.collectionView.contentOffset animated:NO];
    [self.collectionView reloadData];
}

@end
