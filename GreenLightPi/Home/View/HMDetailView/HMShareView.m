//
//  HMShareView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HMShareView.h"
#import "HMShareCell.h"

@interface HMShareView ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation HMShareView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if ([super initWithFrame:frame collectionViewLayout:layout]) {
        self.userInteractionEnabled = YES;
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = KHEXRGB(0xF7F7F7);
        [self registerClass:[HMShareCell class] forCellWithReuseIdentifier:NSStringFromClass([HMShareCell class])];
    }
    return self;
}

#pragma mark - delegate

//一共有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每一组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

//每一个cell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HMShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HMShareCell class]) forIndexPath:indexPath];
    cell.dic = self.dataArr[indexPath.item];
    @weakify(self);
    cell.itemBtnBlock = ^{
        @strongify(self);
        if (self.clickCellBlock) {
            self.clickCellBlock(self.dataArr, indexPath);
        }
        NSLog(@"section:%ld item%ld",indexPath.section,indexPath.item);
    };
    return cell;
}

#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake(55,78);
}

#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(23, 25, 18, 20);//（上、左、下、右）
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.clickCellBlock) {
        self.clickCellBlock(self.dataArr, indexPath);
    }
    NSLog(@"section:%ld item%ld",indexPath.section,indexPath.item);
}

@end
