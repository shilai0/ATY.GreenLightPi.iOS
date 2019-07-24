//
//  PCMainCollectionView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/23.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMainCollectionView.h"
#import "PCMainCollectionViewCell.h"

@interface PCMainCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@end

@implementation PCMainCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if ([super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = KHEXRGB(0xF7F7F7);
        [self registerClass:[PCMainCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([PCMainCollectionViewCell class])];
    }
    return self;
}

#pragma mark -- collectionViewDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PCMainCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PCMainCollectionViewCell class]) forIndexPath:indexPath];
    cell.dic = self.dataArr[indexPath.item];
    @weakify(self);
    cell.cellBtnClick = ^{
        @strongify(self);
        if (self.pushBlock) {
            self.pushBlock(self.dataArr, indexPath);
        }
    };
    return cell;
}

#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(KSCREEN_WIDTH/3,97);
}

#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//（上、左、下、右）
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"section:%ld item%ld",indexPath.section,indexPath.item);
}

@end
