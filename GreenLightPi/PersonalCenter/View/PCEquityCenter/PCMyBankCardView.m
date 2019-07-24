//
//  PCMyBankCardView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/11.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCMyBankCardView.h"
#import "PCMyBankCardCell.h"

@implementation PCMyBankCardView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 200;
    [self registerClass:[PCMyBankCardCell class] forCellReuseIdentifier:NSStringFromClass([PCMyBankCardCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:@"NO" noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCMyBankCardCell *myBankCardCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCMyBankCardCell class])];
    myBankCardCell.selectionStyle = UITableViewCellSelectionStyleNone;
    myBankCardCell.myCardModel = self.dataArr[indexPath.row];
    return myBankCardCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
