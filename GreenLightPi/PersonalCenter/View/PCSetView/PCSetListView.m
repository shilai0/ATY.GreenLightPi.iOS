//
//  PCSetListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCSetListView.h"
#import "BaseFormCell.h"
#import "BaseFormModel.h"

@implementation PCSetListView

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
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self setPushSwitchCell:cell];
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

#pragma mark -- PushSwitchCell
- (void)setPushSwitchCell:(BaseFormCell *)cell {
    // 开关
    if ((UISwitch *)[cell.contentView viewWithTag:1000] == nil) {
        UISwitch *pushSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 64, 13, 48, 33)];
        pushSwitch.onTintColor = KHEXRGB(0x44C08C);
        pushSwitch.tintColor = KHEXRGB(0xCCCCCC);
        pushSwitch.tag = 1000;
        UIButton *topBtn = [[UIButton alloc] initWithFrame:pushSwitch.bounds];
        topBtn.tag = 1001;
        [pushSwitch addSubview:topBtn];
        [cell.contentView addSubview:pushSwitch];
    }
    UISwitch *pushSwitch = [cell.contentView viewWithTag:1000];
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    pushSwitch.on = (setting.types != UIUserNotificationTypeNone);

    UIButton *topBtn = [cell.contentView viewWithTag:1001];
    @weakify(self);
    [[topBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.pushSwitchClickBlock) {
            self.pushSwitchClickBlock();
        }
    }];
    
}

@end
