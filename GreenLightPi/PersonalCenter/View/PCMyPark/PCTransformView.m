//
//  PCTransformView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/12.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCTransformView.h"
#import "PCTransformCell.h"

@implementation PCTransformView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.rowHeight = 72;
    self.backgroundColor = KHEXRGB(0xFFFFFF);
    [self registerClass:[PCTransformCell class] forCellReuseIdentifier:NSStringFromClass([PCTransformCell class])];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PCTransformCell *transformCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCTransformCell class])];
    if (self.isTransform) {
        transformCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    transformCell.memberModel = self.dataArr[indexPath.row];
    return transformCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.isTransform) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 48)];
        titleLabel.text = @"        转给";
        titleLabel.textColor = KHEXRGB(0x333333);
        titleLabel.font = [UIFont systemFontOfSize:17];
        titleLabel.backgroundColor = KHEXRGB(0xF7F7F7);
        return titleLabel;
    } else {
        return [UIView new];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.isTransform) {
        return 48;
    } else {
        return 0.001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.pushBlock) {
        self.pushBlock(self.dataArr, indexPath);
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

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.isTransform) {
        if (self.pushBlock) {
            self.pushBlock(self.dataArr, indexPath);
        }
    }
}

@end
