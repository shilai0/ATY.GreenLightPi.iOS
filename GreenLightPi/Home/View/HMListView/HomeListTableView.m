//
//  HomeListTableView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HomeListTableView.h"
#import "HomeListModel.h"
#import "HomeListCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "HomeListVideoCell.h"
#import "HomeListPictureCell.h"
#import "HomePureTextCell.h"

@implementation HomeListTableView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 200;
    [self registerClass:[HomeListCell class] forCellReuseIdentifier:NSStringFromClass([HomeListCell class])];
    [self registerClass:[HomeListVideoCell class] forCellReuseIdentifier:NSStringFromClass([HomeListVideoCell class])];
    [self registerClass:[HomeListPictureCell class] forCellReuseIdentifier:NSStringFromClass([HomeListPictureCell class])];
    [self registerClass:[HomePureTextCell class] forCellReuseIdentifier:NSStringFromClass([HomePureTextCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HomePureTextCell *pureTextCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomePureTextCell class])];

    switch (self.listViewType) {
        case ListViewTypeDefault:
        {
            HomeListCell *listCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeListCell class])];
            HomeListVideoCell *listVideoCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeListVideoCell class])];
            HomeListPictureCell *listPictureCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomeListPictureCell class])];

            HomeListModel *model = self.dataArr[indexPath.row];
            
            if ([model.contentType integerValue] == 1) {
                //图文
                if (!NilOrNull(model.imageList) && model.imageList.count > 2) {
                    listPictureCell.listModel = model;
                    return listPictureCell;
                } else {
                    listCell.homeListModel = model;
                    return listCell;
                }
            } else if ([model.contentType integerValue] == 2) {
                //视频
                listVideoCell.homeListModel = model;
                return listVideoCell;
            } else if ([model.contentType integerValue] == 3) {
                //音频
            } else if ([model.contentType integerValue] == 4) {
                //纯文字
                pureTextCell.listModel = model;
                return pureTextCell;
            }
            
        }break;
        default:
            break;
    }
    return pureTextCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
