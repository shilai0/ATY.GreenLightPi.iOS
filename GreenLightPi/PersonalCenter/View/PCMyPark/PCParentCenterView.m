//
//  PCParentCenterView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/12.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCParentCenterView.h"
#import "PCParentCenterCell.h"
#import "ATYCustomLabel.h"
#import "BaseFormModel.h"

@implementation PCParentCenterView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.rowHeight = 64;
    self.backgroundColor = KHEXRGB(0xF7F7F7);
    [self registerClass:[PCParentCenterCell class] forCellReuseIdentifier:NSStringFromClass([PCParentCenterCell class])];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCParentCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCParentCenterCell class])];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self setPushSwitchCell:cell];
    }
    BaseFormModel *model = self.dataArr[indexPath.section];
    BaseDetailFormModel *demodel = model.itemsArr[indexPath.row];
    cell.detailModel = demodel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.pushBlock) {
        self.pushBlock(self.dataArr, indexPath);
    }
}

#pragma mark -- 开关
- (void)setPushSwitchCell:(PCParentCenterCell *)cell {
    // 开关
    if ((UISwitch *)[cell.contentView viewWithTag:1000] == nil) {
        UISwitch *pushSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 80, 13, 48, 33)];
        pushSwitch.onTintColor = KHEXRGB(0x44C08C);
        pushSwitch.tintColor = KHEXRGB(0xCCCCCC);
        pushSwitch.tag = 1000;
        [cell.contentView addSubview:pushSwitch];
        [pushSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    UISwitch *pushSwitch = [cell.contentView viewWithTag:1000];
    if (self.isOpen) {
        [pushSwitch setOn:YES];
    } else {
        [pushSwitch setOn:NO];
    }
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (self.openOrCloseSwitchBlock) {
        self.openOrCloseSwitchBlock(isButtonOn);
    }
}

@end
