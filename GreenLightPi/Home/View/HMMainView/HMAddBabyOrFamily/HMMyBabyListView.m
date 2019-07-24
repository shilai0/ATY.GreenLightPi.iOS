//
//  HMMyBabyListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/1.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMyBabyListView.h"
#import "HMMyBabyListCell.h"
#import "BabyModel.h"

@implementation HMMyBabyListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xF7F7F7);
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 200;
    [self registerClass:[HMMyBabyListCell class] forCellReuseIdentifier:NSStringFromClass([HMMyBabyListCell class])];
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
    HMMyBabyListCell *myBabyCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HMMyBabyListCell class])];
    BabyModel *model = self.dataArr[indexPath.row];
    myBabyCell.babyModel = model;
    return myBabyCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 21, KSCREEN_WIDTH, 14)];
    titleLabel.backgroundColor = KHEXRGB(0xF7F7F7);
    titleLabel.text = @"    我家宝宝";
    titleLabel.textColor = KHEXRGB(0x333333);
    titleLabel.font = [UIFont boldSystemFontOfSize:15];
    return titleLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 48;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
