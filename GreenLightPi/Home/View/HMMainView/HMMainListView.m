//
//  HMMainListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/21.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMainListView.h"
#import "HMMainViewParkCell.h"
#import "HMMainViewParentingCell.h"
#import "HMMainViewAccompanyCell.h"
#import "HMMainViewParentalGrowthCell.h"
#import "HMAccompanyCollectionViewCell.h"
#import "HMMainSectionHeadView.h"
#import "UserUseLogModel.h"

@interface HMMainListView()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong) HMMainSectionHeadView *sectionZeroHeadView;
@property (nonatomic, strong) HMMainSectionHeadView *sectionTwoHeadView;
@property (nonatomic, strong) HMMainSectionHeadView *sectionThreeHeadView;
@end

@implementation HMMainViewAccompanyCollectionView

@end

@implementation HMMainListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 300;
    [self registerClass:[HMMainViewParkCell class] forCellReuseIdentifier:NSStringFromClass([HMMainViewParkCell class])];
    [self registerClass:[HMMainViewParentingCell class] forCellReuseIdentifier:NSStringFromClass([HMMainViewParentingCell class])];
    [self registerClass:[HMMainViewAccompanyCell class] forCellReuseIdentifier:NSStringFromClass([HMMainViewAccompanyCell class])];
    [self registerClass:[HMMainViewParentalGrowthCell class] forCellReuseIdentifier:NSStringFromClass([HMMainViewParentalGrowthCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArr.count == 4) {
        if (section == 1 || section == 2) {
            return 1;
        }
        return [self.dataArr[section] count];
    } else {
        if (section == 0 || section == 1) {
            return 1;
        }
        return [self.dataArr[section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMMainViewParkCell *hmParkCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HMMainViewParkCell class])];
    HMMainViewParentingCell *hmParentingCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HMMainViewParentingCell class])];
    HMMainViewAccompanyCell *hmAccompanyCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HMMainViewAccompanyCell class])];
    HMMainViewParentalGrowthCell *hmParentalGrowthCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HMMainViewParentalGrowthCell class])];
    
    hmParkCell.selectionStyle = UITableViewCellSelectionStyleNone;
    hmParentingCell.selectionStyle = UITableViewCellSelectionStyleNone;
    hmAccompanyCell.selectionStyle = UITableViewCellSelectionStyleNone;
    hmParentalGrowthCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.dataArr.count == 4) {
        if (indexPath.section == 0) {
            UseLogModel *useParkModel = self.dataArr[indexPath.section][indexPath.row];
            hmParkCell.useParkModel = useParkModel;
            return hmParkCell;
        } else if (indexPath.section == 1) {
            hmParentingCell.parentingArr = self.dataArr[indexPath.section];
            @weakify(self);
            hmParentingCell.singleBlock = ^(NSInteger singleIndex) {
                @strongify(self);
                NSIndexPath *index = [NSIndexPath indexPathForRow:singleIndex inSection:indexPath.section];
                if (self.parentingBlock) {
                    self.parentingBlock(self.dataArr, index);
                }
            };
            return hmParentingCell;
        } else if (indexPath.section == 2) {
            return hmAccompanyCell;
        } else {
            hmParentalGrowthCell.homeModel = self.dataArr[indexPath.section][indexPath.row];
            return hmParentalGrowthCell;
        }
    } else {
        if (indexPath.section == 0) {
            hmParentingCell.parentingArr = self.dataArr[indexPath.section];
            @weakify(self);
            hmParentingCell.singleBlock = ^(NSInteger singleIndex) {
                @strongify(self);
                NSIndexPath *index = [NSIndexPath indexPathForRow:singleIndex inSection:indexPath.section];
                if (self.parentingBlock) {
                    self.parentingBlock(self.dataArr, index);
                }
            };
            return hmParentingCell;
        } else if (indexPath.section == 1) {
            return hmAccompanyCell;
        } else {
            hmParentalGrowthCell.homeModel = self.dataArr[indexPath.section][indexPath.row];
            return hmParentalGrowthCell;
        }
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.dataArr.count == 4 && section == 0) {
        self.sectionZeroHeadView.dataDic = @{@"icon":@"hm_paradiseUse",@"title":@"独角兽乐园使用情况",@"btnTitle":@"更多"};
        return self.sectionZeroHeadView;
    } else if ((self.dataArr.count == 4 && section == 1) || (self.dataArr.count == 3 && section == 0)) {
        self.sectionOneHeadView.display = YES;
        self.sectionOneHeadView.dataDic = @{@"icon":@"hm_TipsForParenting",@"title":@"育儿小妙招",@"btnTitle":@"更多"};
        return self.sectionOneHeadView;
    } else if ((self.dataArr.count == 4 && section == 2) || (self.dataArr.count == 3 && section == 1)) {
        self.sectionTwoHeadView.dataDic = @{@"icon":@"hm_craftsForKids",@"title":@"今日亲子时光",@"btnTitle":@"更多"};
        return self.sectionTwoHeadView;
    } else if (  (self.dataArr.count == 4 && section == 3) || (self.dataArr.count == 3 && section == 2)) {
        self.sectionThreeHeadView.dataDic = @{@"icon":@"hm_parentSchool",@"title":@"亲子沟通三步曲",@"btnTitle":@"更多"};
        return self.sectionThreeHeadView;
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 54;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(HMMainViewAccompanyCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((self.dataArr.count == 4 && indexPath.section == 2) || (self.dataArr.count == 3 && indexPath.section == 1)) {
        [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    }
}

#pragma mark -- collectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *collectionViewArray = nil;
    if (self.dataArr.count == 4) {
        collectionViewArray = [self.dataArr objectAtIndex:2];
    } else {
        collectionViewArray = [self.dataArr objectAtIndex:1];
    }
    return collectionViewArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMAccompanyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([HMAccompanyCollectionViewCell class]) forIndexPath:indexPath];
    NSArray *collectionViewArray = nil;
    if (self.dataArr.count == 4) {
        collectionViewArray = [self.dataArr objectAtIndex:2];
    } else {
        collectionViewArray = [self.dataArr objectAtIndex:1];
    }
    HomeModel *homeModel = [collectionViewArray objectAtIndex:indexPath.item];
    cell.homeModel = homeModel;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = [(HMMainViewAccompanyCollectionView *)collectionView indexPath].section;
    NSLog(@"section:%ld item%ld",section,indexPath.item);
    NSIndexPath *index = [NSIndexPath indexPathForRow:indexPath.item inSection:section];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,index);
    }
}

#pragma mark -- 懒加载
- (HMMainSectionHeadView *)sectionZeroHeadView {
    if (!_sectionZeroHeadView) {
        _sectionZeroHeadView = [[HMMainSectionHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 72)];
    }
    return _sectionZeroHeadView;
}

- (HMMainSectionHeadView *)sectionOneHeadView {
    if (!_sectionOneHeadView) {
        _sectionOneHeadView = [[HMMainSectionHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 72)];
    }
    return _sectionOneHeadView;
}

- (HMMainSectionHeadView *)sectionTwoHeadView {
    if (!_sectionTwoHeadView) {
        _sectionTwoHeadView = [[HMMainSectionHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 72)];
    }
    return _sectionTwoHeadView;
}

- (HMMainSectionHeadView *)sectionThreeHeadView {
    if (!_sectionThreeHeadView) {
        _sectionThreeHeadView = [[HMMainSectionHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 72)];
    }
    return _sectionThreeHeadView;
}

@end
