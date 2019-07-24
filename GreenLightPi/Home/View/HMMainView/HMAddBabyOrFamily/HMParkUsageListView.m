//
//  HMParkUsageListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/3.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMParkUsageListView.h"
#import "HMParkUseRankListView.h"
#import "HMParkUseTimeCell.h"
#import "HMParkUseRankCell.h"
#import "UserUseLogModel.h"

@implementation HMParkUsageListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xF7F7F7);
    [self registerClass:[HMParkUseTimeCell class] forCellReuseIdentifier:NSStringFromClass([HMParkUseTimeCell class])];
    [self registerClass:[HMParkUseRankCell class] forCellReuseIdentifier:NSStringFromClass([HMParkUseRankCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMParkUseTimeCell *parkUseTimeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HMParkUseTimeCell class])];
    HMParkUseRankCell *parkUseRankCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HMParkUseRankCell class])];
    parkUseTimeCell.selectionStyle = UITableViewCellSelectionStyleNone;
    parkUseRankCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        parkUseTimeCell.model = self.dataArr[indexPath.section][indexPath.row];
        return parkUseTimeCell;
    } else {
        parkUseRankCell.model = [[self.dataArr firstObject] firstObject];
        parkUseRankCell.parkUseRankListView.dataArr = self.dataArr[indexPath.section];
        @weakify(self);
        parkUseRankCell.openOrCloseBlock = ^(BOOL isOpen) {
            @strongify(self);
            if (self.openOrCloseBlock) {
                self.openOrCloseBlock(isOpen);
            }
        };
        return parkUseRankCell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    } else {
        UseLogModel *model = [[self.dataArr firstObject] firstObject];
        if (model.useDetails.count <= 3) {
            return 70*[self.dataArr[indexPath.section] count] + 6;
        } else {
            return 70*[self.dataArr[indexPath.section] count] + 71;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 60)];
    headView.backgroundColor = KHEXRGB(0xF7F7F7);
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(17, 0, KSCREEN_WIDTH, 60)];
    headLabel.textColor = KHEXRGB(0x333333);
    headLabel.font = [UIFont boldSystemFontOfSize:18];
    [headView addSubview:headLabel];
    if (section == 0) {
        headLabel.text = @"使用时间";
    } else {
        headLabel.text = @"使用排行";
    }
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
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
