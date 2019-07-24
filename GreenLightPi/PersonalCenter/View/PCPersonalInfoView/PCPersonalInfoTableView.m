//
//  PCPersonalInfoTableView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/24.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCPersonalInfoTableView.h"
#import "BaseFormCell.h"
#import "BaseFormModel.h"
#import "UIImageView+WebCache.h"
#import "FileEntityModel.h"

@interface PCPersonalInfoTableView () {
    NSIndexPath *_indexPath;
}
@end

@implementation PCPersonalInfoTableView

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
    if (indexPath.section == 0) {
        [self setBabyPictureForCell:cell];
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
    _indexPath = indexPath;
    if (self.pushBlock) {
        self.pushBlock(self.dataArr, indexPath);
    }
}

#pragma mark -- 头像
- (void)setBabyPictureForCell:(BaseFormCell *)cell {
    if ((UIImageView*)[cell.contentView viewWithTag:1000] == nil) {
        UIImageView *photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 50, 10, 40, 40)];
        XSViewBorderRadius(photoImage, 20, 0, KHEXRGB(0xF9694E));
        photoImage.tag = 1000;
        photoImage.image = [UIImage imageNamed:@"kid"];
        [cell.contentView addSubview:photoImage];
    }
    UIImageView *photoImage = (UIImageView *)[cell.contentView viewWithTag:1000];
    if (self.HeadPicUrl) {
        XSViewBorderRadius(photoImage, 20, 0, KHEXRGB(0xF9694E));
        [photoImage sd_setImageWithURL:[NSURL URLWithString:self.HeadPicUrl] placeholderImage:[UIImage imageNamed:@"kid"]];
    }
}

@end
