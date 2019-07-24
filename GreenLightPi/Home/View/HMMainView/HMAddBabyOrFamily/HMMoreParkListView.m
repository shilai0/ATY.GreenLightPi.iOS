//
//  HMMoreParkListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/3.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMoreParkListView.h"
#import "UserUseLogModel.h"
#import "HMMoreParkCell.h"

@implementation HMMoreParkListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xF7F7F7);
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = KSCREENH_HEIGHT;
    [self registerClass:[HMMoreParkCell class] forCellReuseIdentifier:NSStringFromClass([HMMoreParkCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMMoreParkCell *moreParkCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HMMoreParkCell class])];
    moreParkCell.model = self.dataArr[indexPath.row];
    return moreParkCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}


@end
