//
//  PCAddBankCardView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/11.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCAddBankCardView.h"
#import "BaseFormCell.h"
#import "BaseFormModel.h"
#import "BaseFormView.h"

@implementation PCAddBankCardView

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
    cell.formView.textAlignment = 0;
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


@end
