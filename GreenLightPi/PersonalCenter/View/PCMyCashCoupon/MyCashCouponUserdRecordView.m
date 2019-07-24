//
//  MyCashCouponUserdRecordView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/30.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "MyCashCouponUserdRecordView.h"
#import "MyCashCouponUsedRecordCell.h"

@implementation MyCashCouponUserdRecordView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xF7F7F7);
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 200;
    [self registerClass:[MyCashCouponUsedRecordCell class] forCellReuseIdentifier:NSStringFromClass([MyCashCouponUsedRecordCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyCashCouponUsedRecordCell *cashCouponUsedRecordCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyCashCouponUsedRecordCell class])];
    return cashCouponUsedRecordCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
