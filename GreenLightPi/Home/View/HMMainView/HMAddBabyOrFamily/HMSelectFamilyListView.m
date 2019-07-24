//
//  HMSelectFamilyListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/2.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMSelectFamilyListView.h"
#import "HMSelectFamilyListCell.h"
#import "FamilyApiModel.h"

@implementation HMSelectFamilyListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xF7F7F7);
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 200;
    [self registerClass:[HMSelectFamilyListCell class] forCellReuseIdentifier:NSStringFromClass([HMSelectFamilyListCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:@"NO" noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMSelectFamilyListCell *selectFamilyCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HMSelectFamilyListCell class])];
    FamilyApiModel *model = self.dataArr[indexPath.row];
    selectFamilyCell.model = model;
    return selectFamilyCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 8)];
    headView.backgroundColor = KHEXRGB(0xFFFFFF);
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
