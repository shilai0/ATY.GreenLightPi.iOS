//
//  HMPlayBarListView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/30.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMPlayBarListView.h"
#import "HMPlayBarListCell.h"
#import "FatherStudyCategoryModel.h"
#import "HMPlayBarGameCell.h"
#import "HMPlayBarHeadView.h"
#import "MoreButton.h"

@interface HMPlayBarListView ()
@property (nonatomic, strong) HMPlayBarHeadView *zeroHeadView;
@property (nonatomic, strong) HMPlayBarHeadView *oneHeadView;
@end

@implementation HMPlayBarListView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.backgroundColor = KHEXRGB(0xF7F7F7);
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 200;
    [self registerClass:[HMPlayBarListCell class] forCellReuseIdentifier:NSStringFromClass([HMPlayBarListCell class])];
    [self registerClass:[HMPlayBarGameCell class] forCellReuseIdentifier:NSStringFromClass([HMPlayBarGameCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == self.dataArr.count - 1) {
        return [self.dataArr[section] count];
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HMPlayBarListCell *playBarCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HMPlayBarListCell class])];
    HMPlayBarGameCell *playGameCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HMPlayBarGameCell class])];
    playBarCell.selectionStyle = UITableViewCellSelectionStyleNone;
    playGameCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        return playGameCell;
    } else {
        FatherStudyContentModel *model = self.dataArr[indexPath.section][indexPath.row];
        playBarCell.playModel = model;
        return playBarCell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.zeroHeadView;
    } else if (section == 1) {
        return self.oneHeadView;
    } else if (section == 2) {
        return self.twoHeadView;
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == self.dataArr.count - 1) {
        return [UIView new];
    } else {
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 8)];
        footerView.backgroundColor = KHEXRGB(0xF7F7F7);
        return footerView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.dataArr.count - 1) {
        return 0.001;
    }
    return 8;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

#pragma mark -- 懒加载
- (HMPlayBarHeadView *)zeroHeadView {
    if (!_zeroHeadView) {
        _zeroHeadView = [[HMPlayBarHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 40)];
        _zeroHeadView.titleLabel.text = @"今日游戏";
        _zeroHeadView.titleLabel.textColor = KHEXRGB(0xF88B20);
        _zeroHeadView.moreBtn.hidden = YES;
    }
    return _zeroHeadView;
}

- (HMPlayBarHeadView *)oneHeadView {
    if (!_oneHeadView) {
        _oneHeadView = [[HMPlayBarHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 40)];
        _oneHeadView.titleLabel.text = @"游戏·玩具库";
        _oneHeadView.moreBtn.hidden = YES;
    }
    return _oneHeadView;
}

- (HMPlayBarHeadView *)twoHeadView {
    if (!_twoHeadView) {
        _twoHeadView = [[HMPlayBarHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 40)];
        _twoHeadView.titleLabel.text = @"还要玩";
    }
    return _twoHeadView;
}

@end
