//
//  PCMessageCenterView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/27.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMessageCenterView.h"
#import "PCMessageCenterCell.h"

@implementation PCMessageCenterView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    [self registerClass:[PCMessageCenterCell class] forCellReuseIdentifier:NSStringFromClass([PCMessageCenterCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCMessageCenterCell *listCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCMessageCenterCell class])];
    listCell.dic = self.dataArr[indexPath.row];
    return listCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}


@end
