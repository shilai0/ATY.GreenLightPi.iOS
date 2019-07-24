//
//  HMGameLibraryViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/1.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMGameLibraryViewController.h"
#import "FatherStudyContentListModel.h"
#import "FatherStudyCategoryModel.h"
#import "FSDetailViewController.h"
#import "HMGameLibraryListView.h"
#import "FileEntityModel.h"
#import "HomeViewModel.h"
#import "HomeModel.h"

@interface HMGameLibraryViewController ()
@property (nonatomic, strong) HomeViewModel *homeVM;
@property (nonatomic, strong) HMGameLibraryListView *gameLibraryListView;
@end

@implementation HMGameLibraryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.view addSubview:self.gameLibraryListView];
    
    if (self.gametype == moreGame) {
        [self aty_setCenterNavItemtitle:@"更多推荐" titleColor:0x333333];
        [self requestPlayBarData];
    } else {
        [self aty_setCenterNavItemtitle:@"游戏库" titleColor:0x333333];
        [self requestGameLibraryData];
    }
    
    self.gameLibraryListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        FatherStudyContentModel *model = dataArr[indexPath.row];
        FSDetailViewController *detailVC = [[FSDetailViewController alloc] init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
            detailVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=%@&aId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],model.content_id];
        } else {
            detailVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=0&aId=%@",model.content_id];
        }
        detailVC.aId = model.content_id;
        detailVC.titleStr = model.title;
        detailVC.content = model.summarize;
        detailVC.urlStr = model.image.path;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
}

#pragma mark -- requestData
- (void)requestPlayBarData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"categoryId"] = [NSNumber numberWithInteger:self.homeModel.categoryId];
    params[@"pageindex"] = [NSNumber numberWithInteger:1];
    params[@"pagesize"] = [NSNumber numberWithInteger:8];
    __block NSInteger pageindex = 1;
    [[self.homeVM.GetAlsoPlayCommand execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            FatherStudyContentListModel *model = [FatherStudyContentListModel mj_objectWithKeyValues:x[@"Data"]];
            self.gameLibraryListView.dataArr = [model.contentList mutableCopy];
            [self.gameLibraryListView reloadData];
            pageindex = 2;
        }
    }];
    
    // 下拉刷新数据请求指令
    self.gameLibraryListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        params[@"pageindex"] = [NSNumber numberWithInteger:1];
        [[self.homeVM.GetAlsoPlayCommand execute:params] subscribeNext:^(id  _Nullable x) {
            [self.gameLibraryListView.mj_header endRefreshing];
            [self.gameLibraryListView.mj_footer endRefreshing];
            if (x != nil) {
                FatherStudyContentListModel *model = [FatherStudyContentListModel mj_objectWithKeyValues:x[@"Data"]];
                self.gameLibraryListView.dataArr = [model.contentList mutableCopy];
                [self.gameLibraryListView reloadData];
                pageindex = 2;
            }
        }];
    }];
    
    // 上拉加载更多数据指令
    self.gameLibraryListView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        params[@"pageindex"] = [NSNumber numberWithInteger:pageindex];
        [[self.homeVM.GetAlsoPlayCommand execute:params] subscribeNext:^(id  _Nullable x) {
            [self.gameLibraryListView.mj_footer endRefreshing];
            if (x != nil) {
                FatherStudyContentListModel *model = [FatherStudyContentListModel mj_objectWithKeyValues:x[@"Data"]];
                NSArray *newDataArr = [model.contentList mutableCopy];
                NSMutableArray *oldArr = self.gameLibraryListView.dataArr;
                NSMutableArray *allDataArr = [NSMutableArray arrayWithArray:oldArr];
                [allDataArr addObjectsFromArray:newDataArr];
                self.gameLibraryListView.dataArr = allDataArr;
                [self.gameLibraryListView reloadData];
                pageindex ++;
            }
        }];
    }];
}

- (void)requestGameLibraryData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"categoryId"] = [NSNumber numberWithInteger:self.homeModel.categoryId];
    params[@"pageindex"] = [NSNumber numberWithInteger:1];
    params[@"pagesize"] = [NSNumber numberWithInteger:8];
    __block NSInteger pageindex = 1;
    [[self.homeVM.getContentList execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            FatherStudyContentListModel *model = [FatherStudyContentListModel mj_objectWithKeyValues:x[@"Data"]];
            self.gameLibraryListView.dataArr = [model.contentList mutableCopy];
            [self.gameLibraryListView reloadData];
            pageindex = 2;
        }
    }];
    
    // 下拉刷新数据请求指令
    self.gameLibraryListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        params[@"pageindex"] = [NSNumber numberWithInteger:1];
        [[self.homeVM.getContentList execute:params] subscribeNext:^(id  _Nullable x) {
            [self.gameLibraryListView.mj_header endRefreshing];
            [self.gameLibraryListView.mj_footer endRefreshing];
            if (x != nil) {
                FatherStudyContentListModel *model = [FatherStudyContentListModel mj_objectWithKeyValues:x[@"Data"]];
                self.gameLibraryListView.dataArr = [model.contentList mutableCopy];
                [self.gameLibraryListView reloadData];
                pageindex = 2;
            }
        }];
    }];
    
    // 上拉加载更多数据指令
    self.gameLibraryListView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        params[@"pageindex"] = [NSNumber numberWithInteger:pageindex];
        [[self.homeVM.getContentList execute:params] subscribeNext:^(id  _Nullable x) {
            [self.gameLibraryListView.mj_footer endRefreshing];
            if (x != nil) {
                FatherStudyContentListModel *model = [FatherStudyContentListModel mj_objectWithKeyValues:x[@"Data"]];
                NSArray *newDataArr = [model.contentList mutableCopy];
                NSMutableArray *oldArr = self.gameLibraryListView.dataArr;
                NSMutableArray *allDataArr = [NSMutableArray arrayWithArray:oldArr];
                [allDataArr addObjectsFromArray:newDataArr];
                self.gameLibraryListView.dataArr = allDataArr;
                [self.gameLibraryListView reloadData];
                pageindex ++;
            }
        }];
    }];
}

- (HMGameLibraryListView *)gameLibraryListView {
    if (!_gameLibraryListView) {
        _gameLibraryListView = [[HMGameLibraryListView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - KBottomSafeHeight) style:UITableViewStylePlain];
    }
    return _gameLibraryListView;
}

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

@end
