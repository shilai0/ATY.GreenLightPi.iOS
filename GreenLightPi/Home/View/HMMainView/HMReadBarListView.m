//
//  HMReadBarListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/29.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMReadBarListView.h"
#import "HMReadBarListCell.h"
#import "FatherStudyCategoryModel.h"

@implementation HMReadBarListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xF7F7F7);
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 200;
    [self registerClass:[HMReadBarListCell class] forCellReuseIdentifier:NSStringFromClass([HMReadBarListCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMReadBarListCell *readBarCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HMReadBarListCell class])];
    FatherStudyContentModel *model = self.dataArr[indexPath.row];
    readBarCell.readModel = model;
    return readBarCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
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

@end
