//
//  PCSelectCardTableView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/14.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCSelectCardTableView.h"
#import "PCSelectBankCardCell.h"

@interface PCSelectCardTableView()
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation PCSelectCardTableView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xFFFFFF);
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 100;
    [self registerClass:[PCSelectBankCardCell class] forCellReuseIdentifier:NSStringFromClass([PCSelectBankCardCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:@"NO" noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCSelectBankCardCell *selectBankCardCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCSelectBankCardCell class])];
//    selectBankCardCell.selectionStyle = UITableViewCellSelectionStyleNone;
    selectBankCardCell.myCardModel = self.dataArr[indexPath.row];
    return selectBankCardCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
