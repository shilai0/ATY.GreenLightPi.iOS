//
//  PCAuthenView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/1.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCAuthenView.h"
#import "BaseFormCell.h"
#import "BaseFormModel.h"
#import "PCAuthenFooterView.h"

@implementation PCAuthenView

- (PCAuthenFooterView *)authenFooterView {
    if (!_authenFooterView) {
        _authenFooterView = [[PCAuthenFooterView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 230)];
    }
    return _authenFooterView;
}

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
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        self.authenFooterView.IdCardimage = self.IdCardimage;
        return self.authenFooterView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 230;
    }
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.pushBlock) {
        self.pushBlock(self.dataArr, indexPath);
    }
}


@end
