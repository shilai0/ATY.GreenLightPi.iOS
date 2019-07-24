//
//  BaseTableView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+EmptyDataSet.h"

@class EmptyDataView;
@interface BaseTableView : UITableView <UITableViewDelegate, UITableViewDataSource ,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

/** 展示的数据 */
@property (strong, nonatomic) NSMutableArray *dataArr;

/* push 数组和下标 */
@property (copy, nonatomic) void(^pushBlock)(NSMutableArray *dataArr, NSIndexPath *indexPath);

/* 初始化设置 */
- (void)xs_initializesOperating;

/* 展示数据set/get方法 */
- (void)setDataArr:(NSMutableArray *)dataArr;
- (NSMutableArray *)dataArr;

/** 设置无数据缺省页和上拉尾部提醒语 */
- (void)xs_setTableViewEmptyImage:(NSString *)emptyImageName emptyBtnTitle:(NSString *)emptyBtnTitle noneDataFooterTitle:(NSString *)footerTitle;

/** 无数据页面图片 */
@property (nonatomic, copy) NSString *emptyImgName;
/** 无数据页面提示标题 */
@property (nonatomic, copy) NSString *emptyTitle;
/** 无数据页面提示信息 */
@property (nonatomic, copy) NSString *emptyMessage;
/** 设置无数据页面按钮文字 */
@property (nonatomic, copy) NSString *emptyBtnTitle;
/** 无数据页面按钮点击事件 */
@property (nonatomic, copy) void(^emptyBtnClickBlock)(void);
/** 无数据页面点击空白处的事件 */
@property (nonatomic, copy) void(^emptyClickBlock)(void);

@property (nonatomic, strong) EmptyDataView *emptyDataView;

@end
