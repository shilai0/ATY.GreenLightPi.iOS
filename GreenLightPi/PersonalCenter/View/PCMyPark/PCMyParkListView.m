//
//  PCMyParkListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/11.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCMyParkListView.h"
#import "PCMyParkListCell.h"

@implementation PCMyParkListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.rowHeight = 64;
    [self registerClass:[PCMyParkListCell class] forCellReuseIdentifier:NSStringFromClass([PCMyParkListCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PCMyParkListCell *parkCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCMyParkListCell class])];
    parkCell.dataDic = self.dataArr[indexPath.section];
    return parkCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.pushBlock) {
        self.pushBlock(self.dataArr, indexPath);
    }
}


@end
