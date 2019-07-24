//
//  CommonAllSearchView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/10/24.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "CommonAllSearchView.h"
#import "HomeListCell.h"
#import "FCMainSelectedCell.h"
#import "SearchArticleModel.h"
#import "SearchVideoModel.h"
#import "SearchFatherStudyContentModel.h"
#import "UIButton+Common.h"
#import "SearchActivityModel.h"
#import "FSSectionTwoCell.h"

@implementation CommonAllSearchView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    [self registerClass:[HomeListCell class] forCellReuseIdentifier:NSStringFromClass([HomeListCell class])];
    [self registerClass:[FCMainSelectedCell class] forCellReuseIdentifier:NSStringFromClass([FCMainSelectedCell class])];
    [self registerClass:[FSSectionTwoCell class] forCellReuseIdentifier:NSStringFromClass([FSSectionTwoCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
//    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeListCell *articleCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeListCell class])];
    FCMainSelectedCell *videoCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FCMainSelectedCell class])];
    FSSectionTwoCell *fsContentCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FSSectionTwoCell class])];
    
    if ([self.dataArr[indexPath.section] isKindOfClass:[SearchArticleModel class]]) {
        SearchArticleModel *articleModel = self.dataArr[indexPath.section];
        articleCell.homeListModel = articleModel.data[indexPath.row];
        return articleCell;
    }
    if ([self.dataArr[indexPath.section] isKindOfClass:[SearchVideoModel class]]) {
        SearchVideoModel *videoModel = self.dataArr[indexPath.section];
        videoCell.courseModel = videoModel.data[indexPath.row];
        return videoCell;
    }
    if ([self.dataArr[indexPath.section] isKindOfClass:[SearchFatherStudyContentModel class]]) {
        SearchFatherStudyContentModel *fsContentModel = self.dataArr[indexPath.section];
        fsContentCell.model = fsContentModel.data[indexPath.row];
        return fsContentCell;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.dataArr[section] isKindOfClass:[SearchArticleModel class]]) {
        SearchArticleModel *articleModel = self.dataArr[section];
        return articleModel.data.count;
    }
    if ([self.dataArr[section] isKindOfClass:[SearchVideoModel class]]) {
        SearchVideoModel *videoModel = self.dataArr[section];
        return videoModel.data.count;
    }
    if ([self.dataArr[section] isKindOfClass:[SearchFatherStudyContentModel class]]) {
        SearchFatherStudyContentModel *fsContentModel = self.dataArr[section];
        return fsContentModel.data.count;
    }
    if ([self.dataArr[section] isKindOfClass:[SearchActivityModel class]]) {
        SearchActivityModel *searchActivityModel = self.dataArr[section];
        return searchActivityModel.data.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.dataArr[indexPath.section] isKindOfClass:[SearchArticleModel class]]) {
        return 122;
    }
    if ([self.dataArr[indexPath.section] isKindOfClass:[SearchVideoModel class]]) {
        return 120;
    }
    if ([self.dataArr[indexPath.section] isKindOfClass:[SearchFatherStudyContentModel class]]) {
        return 130;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
