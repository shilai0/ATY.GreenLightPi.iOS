//
//  FCAudioDetailListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/12.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCAudioDetailListView.h"
#import "FCAudioDetailListCell.h"

@implementation FCAudioDetailListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xFFFFFF);
    [self registerClass:[FCAudioDetailListCell class] forCellReuseIdentifier:NSStringFromClass([FCAudioDetailListCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

#pragma mark -- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FCAudioDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FCAudioDetailListCell class])];
    cell.detailModel = self.dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 74;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
