//
//  BabyInfoTableView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/5.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BabyInfoTableView.h"
#import "BaseFormCell.h"
#import "BaseFormModel.h"
#import "UIImageView+WebCache.h"

@interface BabyInfoTableView () {
    NSIndexPath *_indexPath;
}
@property (nonatomic, strong) UIButton *selectedSexButton;
@property (nonatomic, strong) UIButton *selectedRelationButton;
@end

@implementation BabyInfoTableView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.rowHeight = 60;
    [self registerClass:[BaseFormCell class] forCellReuseIdentifier:NSStringFromClass([BaseFormCell class])];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseFormCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([BaseFormCell class])];
    BaseFormModel *model = self.dataArr[indexPath.section];
    BaseDetailFormModel *demodel = model.itemsArr[indexPath.row];
    cell.detailModel = demodel;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self setBabyPictureForCell:cell];
    } else if (indexPath.section == 1 && indexPath.row == 0) {
        [self setRelationShipForCell:cell];
    } else if (indexPath.row == 2) {
        [self setBabySexForCell:cell];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    _indexPath = indexPath;
    if (self.pushBlock) {
        self.pushBlock(self.dataArr, indexPath);
    }
}

#pragma mark -- 宝宝头像
- (void)setBabyPictureForCell:(BaseFormCell *)cell {
    if ((UIImageView *)[cell.contentView viewWithTag:1000] == nil) {
        UIImageView *photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 50, 10, 40, 40)];
        photoImage.tag = 1000;
        [photoImage sd_setImageWithURL:[NSURL URLWithString:self.imagePathStr] placeholderImage:[UIImage imageNamed:@"kid"]];
        XSViewBorderRadius(photoImage, 20, 0, KHEXRGB(0xF9694E));
        [cell.contentView addSubview:photoImage];
    }
    UIImageView *photoImage = (UIImageView *)[cell.contentView viewWithTag:1000];
    if (self.picImage) {
        XSViewBorderRadius(photoImage, 20, 0, KHEXRGB(0xF9694E));
        photoImage.image = self.picImage;
    }
}

#pragma mark -- 宝宝性别
- (void)setBabySexForCell:(BaseFormCell *)cell {
    if ((UIButton *)[cell.contentView viewWithTag:100] == nil && (UIButton *)[cell.contentView viewWithTag:101] == nil) {
        NSArray *sexArr = @[@"公主",@"王子"];
        for (int i = 0; i < 2; i ++) {
            UIButton *sexButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 140 + 50 * i + 10 * i, 10, 60, 40)];
            [sexButton setImage:[UIImage imageNamed:@"dot_nor"] forState:UIControlStateNormal];
            [sexButton setImage:[UIImage imageNamed:@"dot_sel"] forState:UIControlStateSelected];
            [sexButton setTitle:sexArr[i] forState:UIControlStateNormal];
            [sexButton setTitleColor:KHEXRGB(0x646464) forState:UIControlStateNormal];
            [sexButton setTitleColor:KHEXRGB(0x44C08C) forState:UIControlStateSelected];
            sexButton.titleLabel.font = [UIFont systemFontOfSize:14];
            [cell.contentView addSubview:sexButton];
            if (i == [self.sex intValue]) {
                sexButton.selected = YES;
                self.selectedSexButton = sexButton;
            }
            sexButton.tag = 100 + i;
            @weakify(self);
            [[sexButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self);
                [self selectBabySexButtonActionWithbutton:sexButton];
            }];
        }
    }
}

#pragma mark -- 与宝宝的关系
- (void)setRelationShipForCell:(BaseFormCell *)cell {
    if ((UIButton *)[cell.contentView viewWithTag:200] == nil && (UIButton *)[cell.contentView viewWithTag:201] == nil) {
        NSArray *relationArr = @[@"妈妈",@"爸爸"];
        for (int i = 0; i < 2; i ++) {
            UIButton *relationButton = [[UIButton alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH - 140 + 50 * i + 10 * i, 10, 60, 40)];
            [relationButton setImage:[UIImage imageNamed:@"dot_nor"] forState:UIControlStateNormal];
            [relationButton setImage:[UIImage imageNamed:@"dot_sel"] forState:UIControlStateSelected];
            [relationButton setTitle:relationArr[i] forState:UIControlStateNormal];
            [relationButton setTitleColor:KHEXRGB(0x646464) forState:UIControlStateNormal];
            [relationButton setTitleColor:KHEXRGB(0x44C08C) forState:UIControlStateSelected];
            relationButton.titleLabel.font = [UIFont systemFontOfSize:11];
            [cell.contentView addSubview:relationButton];
            if (i == [self.relation intValue]) {
                relationButton.selected = YES;
                self.selectedRelationButton = relationButton;
            }
            relationButton.tag = 200 + i;
            @weakify(self);
            [[relationButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                @strongify(self);
                [self selectRelationButtonActionWithbutton:relationButton];
            }];
        }
    }
}

- (void)selectBabySexButtonActionWithbutton:(UIButton *)button {
//    button.selected = !button.selected;
    if (button != self.selectedSexButton) {
        self.selectedSexButton.selected = NO;
        button.selected = YES;
        self.selectedSexButton = button;
    }else{
        self.selectedSexButton.selected = YES;
    }
    if (self.selectSexBlock) {
        self.selectSexBlock(button.tag - 100);
    }
}

- (void)selectRelationButtonActionWithbutton:(UIButton *)button {
    //    button.selected = !button.selected;
    if (button != self.selectedRelationButton) {
        self.selectedRelationButton.selected = NO;
        button.selected = YES;
        self.selectedRelationButton = button;
    }else{
        self.selectedRelationButton.selected = YES;
    }
    if (self.selectRelationBlock) {
        self.selectRelationBlock(button.tag - 200);
    }
}

@end
