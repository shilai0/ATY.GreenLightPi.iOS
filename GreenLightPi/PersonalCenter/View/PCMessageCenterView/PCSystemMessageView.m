//
//  PCSystemMessageView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCSystemMessageView.h"
#import "PCSystemMessageCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "PCMessageModel.h"

@implementation PCSystemMessageView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    [self registerClass:[PCSystemMessageCell class] forCellReuseIdentifier:NSStringFromClass([PCSystemMessageCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCSystemMessageCell *listCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCSystemMessageCell class])];
    listCell.model = self.dataArr[indexPath.section];
    return listCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([PCSystemMessageCell class]) cacheByIndexPath:indexPath configuration:^(PCSystemMessageCell *cell) {
        cell.model = self.dataArr[indexPath.section];
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
