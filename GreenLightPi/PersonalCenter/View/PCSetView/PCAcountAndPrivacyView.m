//
//  PCAcountAndPrivacyView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCAcountAndPrivacyView.h"
#import "BaseFormCell.h"
#import "BaseFormModel.h"

@implementation PCAcountAndPrivacyView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.rowHeight = 60;
    [self registerClass:[BaseFormCell class] forCellReuseIdentifier:NSStringFromClass([BaseFormCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BaseFormModel *model = self.dataArr[section];
    return model.itemsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BaseFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BaseFormCell class])];
    BaseFormModel *model = self.dataArr[indexPath.section];
    BaseDetailFormModel *demodel = model.itemsArr[indexPath.row];
    cell.detailModel = demodel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row > 1) {
        [self setSwitchCell:cell indexPath:indexPath];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.pushBlock) {
        self.pushBlock(self.dataArr, indexPath);
    }
}

#pragma mark -- SwitchCell
- (void)setSwitchCell:(BaseFormCell *)cell indexPath:(NSIndexPath *)indexPath {
    // 开关
    if ((UISwitch *)[cell.contentView viewWithTag:1000 + indexPath.row] == nil) {
        UISwitch *pushSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 64, 13, 48, 33)];
        pushSwitch.onTintColor = KHEXRGB(0x44C08C);
        pushSwitch.tintColor = KHEXRGB(0xCCCCCC);
        pushSwitch.tag = 1000 + indexPath.row;
        [cell.contentView addSubview:pushSwitch];
    }
    UISwitch *pushSwitch = [cell.contentView viewWithTag:1000 + indexPath.row];
    pushSwitch.on = YES;
}

@end
