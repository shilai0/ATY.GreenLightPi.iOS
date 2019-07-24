//
//  FCCourseItemListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/21.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCCourseItemListView.h"
#import "FCCourseItemCell.h"

@implementation FCCourseItemListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xFFFFFF);
    [self registerClass:[FCCourseItemCell class] forCellReuseIdentifier:NSStringFromClass([FCCourseItemCell class])];
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
    FCCourseItemCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FCCourseItemCell class])];
    cell.courseModel = self.courseModel;
    cell.courseDetailModel = self.dataArr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}


@end
