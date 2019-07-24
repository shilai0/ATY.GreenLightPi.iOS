//
//  PCMyCollectListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/26.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMyCollectListView.h"
#import "PCMyCollectHeadView.h"
#import "PCMyCollectCell.h"
#import "PCMyCollectModel.h"
#import "PCBrowseTypeModel.h"

@interface PCMyCollectListView ()
@property (nonatomic, strong) PCMyCollectHeadView *headView;
@end

@implementation PCMyCollectListView

- (PCMyCollectHeadView *)headView {
    if (_headView == nil) {
        _headView = [[PCMyCollectHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 56)];
        _headView.userInteractionEnabled = YES;
    }
    return _headView;
}

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    [self registerClass:[PCMyCollectCell class] forCellReuseIdentifier:NSStringFromClass([PCMyCollectCell class])];
    self.allowsMultipleSelectionDuringEditing = YES;
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCMyCollectCell *listCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCMyCollectCell class])];
//    listCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.type == SelectShowTypeDefault) {
        listCell.collectModel = self.currentDataArr[indexPath.row];
    } else {
        listCell.browseTypeModel = self.currentDataArr[indexPath.row];
    }
    return listCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSMutableArray *titleArr = [[NSMutableArray alloc] init];
    if (self.type == SelectShowTypeBrows) {
        [self.dataArr enumerateObjectsUsingBlock:^(PCBrowseTypeModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [titleArr addObject:obj.typeName];
        }];
    } else {
        [self.dataArr enumerateObjectsUsingBlock:^(PCMyCollectModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [titleArr addObject:obj.typeName];
        }];
    }
    self.headView.titleArr = titleArr;
    self.headView.selectedIndex = self.switchIndex;
    @weakify(self);
    self.headView.selectBlock = ^(NSInteger index) {
        @strongify(self);
        self.headView.selectedIndex = index;
        self.switchIndex = index;
        if (self.type == SelectShowTypeBrows) {
            PCBrowseTypeModel *currentModel = self.dataArr[index];
            self.currentDataArr = [currentModel.browseList mutableCopy];
            [self reloadData];
        } else {
            PCMyCollectModel *currentModel = self.dataArr[index];
            self.currentDataArr = [currentModel.collectList mutableCopy];
            [self reloadData];
        }
        
    };
    return self.headView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.currentDataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 96;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 56;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.pushBlock) {
        self.pushBlock(self.currentDataArr, indexPath);
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 多选
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}

@end
