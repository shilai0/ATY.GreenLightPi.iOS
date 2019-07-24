//
//  FCMainListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/9.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCMainListView.h"
#import "FCMainSelectedCell.h"
#import "FcCoursesModel.h"
#import "FamilyIndexSectionView.h"

@interface FCMainListView()

@end

@implementation FCMainListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    [self registerClass:[FCMainSelectedCell class] forCellReuseIdentifier:NSStringFromClass([FCMainSelectedCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

#pragma mark -- TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataArr[section] count] > 2) {
        return 3;
    } else {
        return [self.dataArr[section] count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FCMainSelectedCell *selectedCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FCMainSelectedCell class])];
    if ([self.dataArr[indexPath.section] count] > 0) {
        selectedCell.courseModel = self.dataArr[indexPath.section][indexPath.row];
    }
    return selectedCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        self.headzeroview.dataDic = @{@"title":@"亲子沟通三步曲",@"btnTitle":@"更多"};
        return self.headzeroview;
    } else if (section == 1) {
        self.headoneview.dataDic = @{@"title":@"家园共育八阶段",@"btnTitle":@"更多"};
        return self.headoneview;
    } else if (section == 2) {
        self.headtwoview.dataDic = @{@"title":@"从游戏中培养孩子的能力",@"btnTitle":@"更多"};
        return self.headtwoview;
    } else if (section == 3) {
        self.headthreeview.dataDic = @{@"title":@"公开课",@"btnTitle":@"更多"};
        return self.headthreeview;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 68;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

- (FamilyIndexSectionView *)headzeroview {
    if (!_headzeroview) {
        _headzeroview = [[FamilyIndexSectionView alloc] init];
        _headzeroview.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _headzeroview.display = YES;
    }
    return _headzeroview;
}

- (FamilyIndexSectionView *)headoneview {
    if (!_headoneview) {
        _headoneview = [[FamilyIndexSectionView alloc] init];
        _headoneview.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _headoneview.display = YES;
    }
    return _headoneview;
}

- (FamilyIndexSectionView *)headtwoview {
    if (!_headtwoview) {
        _headtwoview = [[FamilyIndexSectionView alloc] init];
        _headtwoview.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _headtwoview.display = YES;
    }
    return _headtwoview;
}

- (FamilyIndexSectionView *)headthreeview {
    if (!_headthreeview) {
        _headthreeview = [[FamilyIndexSectionView alloc] init];
        _headthreeview.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _headthreeview.display = YES;
    }
    return _headthreeview;
}

@end
