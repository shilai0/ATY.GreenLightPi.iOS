//
//  BaseTableView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseTableView.h"
#import "MJRefresh.h"
#import "EmptyDataView.h"

@implementation BaseTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self xs_initializesOperating];
    }
    return self;
}

#pragma mark -初始化设置
- (void)xs_initializesOperating {
    self.backgroundColor = KHEXRGB(0xF7F7F7);
    self.delegate = self;
    self.dataSource = self;
    self.rowHeight = 44;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    
    // 解决界面刷新时的漂移问题
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
}

#pragma mark -懒加载
- (void)setDataArr:(NSMutableArray *)dataArr {
    if (_dataArr != dataArr) {
        _dataArr = dataArr;
    }
}

#pragma mark -设置无数据缺省页和上拉尾部提醒语
- (void)xs_setTableViewEmptyImage:(NSString *)emptyImageName emptyBtnTitle:(NSString *)emptyBtnTitle noneDataFooterTitle:(NSString *)footerTitle {
    if (self.dataArr.count == 0) {   // 没有数据
        if (![emptyBtnTitle isEqualToString:@"NO"]) {
            self.emptyDataView = [[EmptyDataView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT)];
            [self addSubview:self.emptyDataView];
        }
        self.mj_footer.hidden = YES;
    } else if (self.dataArr.count % 8 > 0 && self.dataArr.count % 8 < 8) { // 数据范围在1~8之间
        if (self.emptyDataView) {
            [self.emptyDataView removeFromSuperview];
        }
        // 更改footer在没有更多数据状态下的标题
        MJRefreshAutoNormalFooter *footer = (MJRefreshAutoNormalFooter *)self.mj_footer;
        [footer setTitle:footerTitle forState:MJRefreshStateNoMoreData];
        // 变为没有更多数据的状态
        [self.mj_footer endRefreshingWithNoMoreData];
        self.mj_footer.hidden = NO;
    }
}

#pragma mark -UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - DZNEmptyDataSetSource
// 设置图片
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.emptyImgName.length <= 0) {
        return nil;
    }
    
    return [UIImage imageNamed:self.emptyImgName];
}

// 设置标题文字
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.emptyTitle.length <= 0) {
        return nil;
    }
    
    NSString *text = self.emptyTitle;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:18.0f], NSForegroundColorAttributeName: [UIColor darkGrayColor]};
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

// 设置详情文字
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.emptyMessage.length <= 0) {
        return nil;
    }
    
    NSString *text = self.emptyMessage;
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:14.0f], NSForegroundColorAttributeName: [UIColor lightGrayColor], NSParagraphStyleAttributeName: paragraph};
    return [[NSAttributedString alloc] initWithString:text attributes:attribute];
}

// 设置可以点击的按钮 上面带文字
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.emptyBtnTitle.length <= 0) {
        return nil;
    }
    
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:17.0f]};
    return [[NSAttributedString alloc] initWithString:self.emptyBtnTitle attributes:attribute];
}

#pragma mark - DZNEmptyDataSetDelegate
// 处理按钮的点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
    if (self.emptyBtnClickBlock) {
        self.emptyBtnClickBlock();
    }
}

// 空白区域点击事件
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    if (self.emptyClickBlock) {
        self.emptyClickBlock();
    }
}

// 设置界面的垂直方向的对齐约束， 默认为CGPointZero
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return -KSCREENH_HEIGHT/2;
}

// 实现该方法告诉代理该视图允许滚动，默认为NO
- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

@end
