//
//  PCMyTeamVIew.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/10.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCMyTeamVIew.h"
#import "PCEquityProfitCell.h"

@implementation PCMyTeamVIew

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 100;
    [self registerClass:[PCEquityProfitCell class] forCellReuseIdentifier:NSStringFromClass([PCEquityProfitCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:@"NO" noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCEquityProfitCell *myTeamCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCEquityProfitCell class])];
    myTeamCell.selectionStyle = UITableViewCellSelectionStyleNone;
    myTeamCell.myTeamModel = self.dataArr[indexPath.row];
    return myTeamCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
