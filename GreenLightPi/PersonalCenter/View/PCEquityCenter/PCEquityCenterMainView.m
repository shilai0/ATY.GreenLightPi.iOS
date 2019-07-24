//
//  PCEquityCenterMainView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/8.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCEquityCenterMainView.h"
#import "PCEquityCenterMainViewCell.h"

@implementation PCEquityCenterMainView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xFFFFFF);
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 100;
    [self registerClass:[PCEquityCenterMainViewCell class] forCellReuseIdentifier:NSStringFromClass([PCEquityCenterMainViewCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCEquityCenterMainViewCell *mainViewCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCEquityCenterMainViewCell class])];
    mainViewCell.selectionStyle = UITableViewCellSelectionStyleNone;
    mainViewCell.dataDic = self.dataArr[indexPath.row];
    return mainViewCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 40)];
    headView.backgroundColor = KHEXRGB(0xFFFFFF);
    UILabel *headLabel = [[UILabel alloc] initWithFrame:CGRectMake(16, 12, KSCREEN_WIDTH - 32, 17)];
    headLabel.text = @"我的团队";
    headLabel.font = [UIFont boldSystemFontOfSize:18];
    headLabel.textColor = KHEXRGB(0x1A1A1A);
    [headView addSubview:headLabel];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}


@end
