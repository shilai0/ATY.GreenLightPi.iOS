//
//  BaseFormTableView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseFormTableView.h"
#import "BaseFormModel.h"
#import "BaseFormCell.h"
#import "ATYCustomLabel.h"

@implementation BaseFormTableView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    
    [self registerClass:[BaseFormCell class] forCellReuseIdentifier:NSStringFromClass([BaseFormTableView class])];
}

#pragma mark -UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BaseFormModel *formModel = self.dataArr[section];
    return [formModel.itemsArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseFormCell *agentCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BaseFormTableView class])];
    BaseFormModel *formModel = self.dataArr[indexPath.section];
    agentCell.detailModel = formModel.itemsArr[indexPath.row];
    
    return agentCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ATYCustomLabel *headerLabel = [[ATYCustomLabel alloc]initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 40)];
    BaseFormModel *formModel = self.dataArr[section];
    headerLabel.text = formModel.headerTitle;
    headerLabel.textColor = KHEXRGB(0x797979);
    headerLabel.font = [UIFont systemFontOfSize:13];
    headerLabel.textAlignment = NSTextAlignmentLeft;
    headerLabel.textInsets  = UIEdgeInsetsMake(8, 10, 3, 10);
    return headerLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    BaseFormModel *formModel = self.dataArr[section];
    
    if (formModel.headerTitle.length <= 0) {
        return 10;
    } else {
        return 40;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    BaseFormModel *formModel = self.dataArr[section];
    
    if (formModel.footerTitle.length <= 0) {
        return 0.00001;
    } else {
        return 40;
    }
}

@end
