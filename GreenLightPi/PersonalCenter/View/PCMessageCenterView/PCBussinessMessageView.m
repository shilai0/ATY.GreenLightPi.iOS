//
//  PCBussinessMessageView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCBussinessMessageView.h"
#import "PCBussinessMessageCell.h"
#import "PCMessageModel.h"

@implementation PCBussinessMessageView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    [self registerClass:[PCBussinessMessageCell class] forCellReuseIdentifier:NSStringFromClass([PCBussinessMessageCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCBussinessMessageCell *listCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCBussinessMessageCell class])];
    listCell.model = self.dataArr[indexPath.section];
    return listCell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 31)];
    BusinessMessageModel *model = self.dataArr[section];
    titleLabel.text = model.ctime;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = KHEXRGB(0x999999);
    titleLabel.font = FONT(12);
    return titleLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 31;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 157;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
