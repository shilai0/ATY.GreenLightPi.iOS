//
//  PCAlreadyBoughtCourseListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/26.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCAlreadyBoughtCourseListView.h"
#import "PCAlreadyBoughtCourseCell.h"
#import "FcCoursesModel.h"
#import "EmptyDataView.h"
#import "AppDelegate.h"
#import "UIView+Controller.h"
#import "MainTabBarViewController.h"

@implementation PCAlreadyBoughtCourseListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    [self registerClass:[PCAlreadyBoughtCourseCell class] forCellReuseIdentifier:NSStringFromClass([PCAlreadyBoughtCourseCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
    [self.emptyDataView.titleBtn setTitle:@"去发现感兴趣内容～" forState:UIControlStateNormal];
    @weakify(self);
    self.emptyDataView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        MainTabBarViewController *tabViewController = (MainTabBarViewController *) appDelegate.window.rootViewController;
        [tabViewController setSelectedIndex:2];
        [[self xs_viewController].navigationController popToRootViewControllerAnimated:YES];
    };
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCAlreadyBoughtCourseCell *listCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCAlreadyBoughtCourseCell class])];
    FcCoursesModel *model = self.dataArr[indexPath.row];
    listCell.model = model;
    return listCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}


@end
