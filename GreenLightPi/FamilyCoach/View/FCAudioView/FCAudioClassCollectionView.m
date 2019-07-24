//
//  FCAudioClassCollectionView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/18.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCAudioClassCollectionView.h"
#import "FCAudioClassCollectionCell.h"

@interface FCAudioClassCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation FCAudioClassCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if ([super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = KHEXRGB(0xF7F7F7);
        [self registerClass:[FCAudioClassCollectionCell class] forCellWithReuseIdentifier:NSStringFromClass([FCAudioClassCollectionCell class])];
    }
    return self;
}

#pragma mark - delegate
//每一组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

//每一个cell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FCAudioClassCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FCAudioClassCollectionCell class]) forIndexPath:indexPath];
    FcClassifyModel *model = self.dataArr[indexPath.item];
    cell.classModel = model;
    @weakify(self);
    cell.btnBlock = ^{
        @strongify(self);
        if (self.clickCellBlock) {
            self.clickCellBlock(self.dataArr, indexPath);
        }
    };
    return cell;
}

#pragma mark  定义每个UICollectionView的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return  CGSizeMake((KSCREEN_WIDTH - 160)/3,40);
}

#pragma mark  定义整个CollectionViewCell与整个View的间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);//（上、左、下、右）
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"section:%ld item%ld",indexPath.section,indexPath.item);
}


@end
