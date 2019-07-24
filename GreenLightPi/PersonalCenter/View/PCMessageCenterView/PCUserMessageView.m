//
//  PCUserMessageView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCUserMessageView.h"
#import "PCUserMessageLikeCell.h"
#import "PCUserMessageFollowCell.h"
#import "PCUserMessageReviewforwardCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "PCMessageModel.h"
/**
 /// 点赞
 /// </summary>
 [Description("点赞")]
 zan = 1,
 /// <summary>
 /// 评论
 /// </summary>
 [Description("评论")]
 comment = 2,
 /// <summary>
 /// 转发
 /// </summary>
 [Description("转发")]
 forward = 3,
 /// <summary>
 /// 关注
 /// </summary>
 [Description("关注")]
 follow = 4,
 /// <summary>
 /// 广告
 /// </summary>
 [Description("广告")]
 adv = 5,
 /// <summary>
 /// 商家
 /// </summary>
 [Description("商家")]
 business = 6,
 /// <summary>
 /// 系统
 /// </summary>
 [Description("系统")]
 sys = 7,
 /// <summary>
 /// 推送
 /// </summary>
 [Description("推送")]
 push = 8,
 */
@implementation PCUserMessageView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    [self registerClass:[PCUserMessageLikeCell class] forCellReuseIdentifier:NSStringFromClass([PCUserMessageLikeCell class])];
    [self registerClass:[PCUserMessageFollowCell class] forCellReuseIdentifier:NSStringFromClass([PCUserMessageFollowCell class])];
    [self registerClass:[PCUserMessageReviewforwardCell class] forCellReuseIdentifier:NSStringFromClass([PCUserMessageReviewforwardCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:nil noneDataFooterTitle:@"已加载全部数据"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCUserMessageLikeCell *likeCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCUserMessageLikeCell class])];
    PCUserMessageFollowCell *followCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCUserMessageFollowCell class])];
    PCUserMessageReviewforwardCell *reviewForwardCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCUserMessageReviewforwardCell class])];
    UserMessageModel *model = self.dataArr[indexPath.row];
//    if ([model.category isEqualToString:@"zan"]) {
//        likeCell.model = model;
//        return likeCell;
//    } else if ([model.category isEqualToString:@"follow"]) {
//        followCell.model = model;
//        return followCell;
//    } else if ([model.category isEqualToString:@"comment"] || [model.category isEqualToString:@"forward"]) {
//        reviewForwardCell.model = model;
//        return reviewForwardCell;
//    }
//    return nil;
    
    reviewForwardCell.model = model;
    return reviewForwardCell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserMessageModel *model = self.dataArr[indexPath.row];
//    if ([model.category isEqualToString:@"zan"]) {
//        return 85;
//    } else if ([model.category isEqualToString:@"follow"]) {
//        return 65;
//    } else if ([model.category isEqualToString:@"comment"] || [model.category isEqualToString:@"forward"]) {
//        return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([PCUserMessageReviewforwardCell class]) cacheByIndexPath:indexPath configuration:^(PCUserMessageReviewforwardCell *cell) {
//            cell.model = model;
//        }];
//    }
//    return 0;
    return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([PCUserMessageReviewforwardCell class]) cacheByIndexPath:indexPath configuration:^(PCUserMessageReviewforwardCell *cell) {
        cell.model = model;
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}


@end
