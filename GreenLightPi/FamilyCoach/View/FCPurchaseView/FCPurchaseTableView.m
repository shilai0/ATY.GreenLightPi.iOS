//
//  FCPurchaseTableView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCPurchaseTableView.h"
#import "FCPurchaseCell.h"

@implementation FCPurchaseTableView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xF7F7F7);
    [self registerClass:[FCPurchaseCell class] forCellReuseIdentifier:NSStringFromClass([FCPurchaseCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

#pragma mark -- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FCPurchaseCell *purchaseCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FCPurchaseCell class])];
    purchaseCell.model = self.dataArr[indexPath.row];
    @weakify(self);
    purchaseCell.selectBtnBlock = ^{
        @strongify(self);
        if (self.pushBlock) {
            self.pushBlock(self.dataArr, indexPath);
        }
    };
    return purchaseCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"支付方式";
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
