//
//  FCAudioListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/17.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCAudioListView.h"
#import "FCMainSelectedCell.h"
#import "FcCoursesModel.h"

@implementation FCAudioListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    [self registerClass:[FCMainSelectedCell class] forCellReuseIdentifier:NSStringFromClass([FCMainSelectedCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

#pragma mark -- TableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FCMainSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FCMainSelectedCell class])];
    cell.courseModel = self.dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
