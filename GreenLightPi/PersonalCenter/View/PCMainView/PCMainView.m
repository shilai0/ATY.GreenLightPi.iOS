//
//  PCMainView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/10/23.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMainView.h"
#import "PVMianCell.h"

@implementation PCMainView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.rowHeight = 64;
    self.backgroundColor = KHEXRGB(0xFFFFFF);
    [self registerClass:[PVMianCell class] forCellReuseIdentifier:NSStringFromClass([PVMianCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArr[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PVMianCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PVMianCell class])];
    cell.dataDic = self.dataArr[indexPath.section][indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
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

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    if (self.scrollBlock) {
        self.scrollBlock(scrollView);
    }
}

@end
