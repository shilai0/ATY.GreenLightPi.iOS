//
//  PCCashOutResultVIew.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/16.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCCashOutResultVIew.h"
#import "PCCashOutResultCell.h"

@implementation PCCashOutResultVIew

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xFFFFFF);
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 200;
    [self registerClass:[PCCashOutResultCell class] forCellReuseIdentifier:NSStringFromClass([PCCashOutResultCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:@"NO" noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCCashOutResultCell *cashOutResultCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCCashOutResultCell class])];
    cashOutResultCell.selectionStyle = UITableViewCellSelectionStyleNone;
    cashOutResultCell.dataDic = self.dataArr[indexPath.row];
    return cashOutResultCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
