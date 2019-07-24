//
//  BabyListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/14.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BabyListView.h"
#import "BabyListCell.h"

@implementation BabyListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    [self registerClass:[BabyListCell class] forCellReuseIdentifier:NSStringFromClass([BabyListCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BabyListCell *listCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BabyListCell class])];
    listCell.dic = self.dataArr[indexPath.section];
    return listCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.deletBlock) {
        self.deletBlock(self.dataArr, indexPath);
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

@end
