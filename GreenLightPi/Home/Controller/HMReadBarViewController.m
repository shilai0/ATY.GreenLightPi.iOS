//
//  HMReadBarViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/29.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMReadBarViewController.h"
#import "FatherStudyContentListModel.h"
#import "FatherStudyCategoryModel.h"
#import "FSDetailViewController.h"
#import "HMReadBarListView.h"
#import "FileEntityModel.h"
#import <WebKit/WebKit.h>
#import "HomeViewModel.h"
#import "LSPPageView.h"
#import "HomeModel.h"

@interface HMReadBarViewController ()<LSPPageViewDelegate>
@property (nonatomic, strong) UIView *recommandView;
@property (nonatomic,strong) NSMutableArray *childVcArray;
@property (nonatomic, strong) HMReadBarListView *readBarListView;
@property (nonatomic, strong) HomeViewModel *homeVM;
@end

@implementation HMReadBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHEXRGB(0xFFFFFF);
    [self creatReadBarViews];
}

- (void)creatReadBarViews {
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"读吧" titleColor:0x333333];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"本周推荐",@"阅读书单", nil];
    for (int i = 0; i < titleArr.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        if (i == 0) {
            self.recommandView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - 44)];
            UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - 44)];
            [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
            self.recommandView.tag = 10 + i;
            [vc.view addSubview:self.recommandView];
            [self.recommandView addSubview:web];
        } else {
            self.readBarListView = [[HMReadBarListView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - 44) style:UITableViewStylePlain];
            @weakify(self);
            self.readBarListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
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
            self.readBarListView.tag = 10 + i;
            [vc.view addSubview:self.readBarListView];
        }
        [self.childVcArray addObject:vc];
    }
    LSPTitleStyle *style = [[LSPTitleStyle alloc] init];
    style.index = 0;
    style.isAverage = YES;
    style.isNeedScale = YES;
    style.isShowBottomLine = YES;
    style.normalColor = KHEXRGB(0x646464);
    style.font = [UIFont boldSystemFontOfSize:14];
    LSPPageView *pageView = [[LSPPageView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) titles:titleArr style:style childVcs:self.childVcArray.mutableCopy parentVc:self];
    pageView.delegate = self;
    pageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pageView];
    
    [self requestReadBarData];
    
}

#pragma mark -- 请求数据
- (void)requestReadBarData {
    UIViewController *currentVC = self.childVcArray[1];
    HMReadBarListView *currentTableView = (HMReadBarListView *)[currentVC.view viewWithTag:(10 + 1)];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"categoryId"] = [NSNumber numberWithInteger:self.homeModel.categoryId];
    params[@"themeId"] = [NSNumber numberWithInteger:0];
    params[@"pageindex"] = [NSNumber numberWithInteger:1];
    params[@"pagesize"] = [NSNumber numberWithInteger:8];
    __block NSInteger pageindex = 1;
    [[self.homeVM.getContentList execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            FatherStudyContentListModel *model = [FatherStudyContentListModel mj_objectWithKeyValues:x[@"Data"]];
            currentTableView.dataArr = [model.contentList mutableCopy];
            [currentTableView reloadData];
            pageindex = 2;
        }
    }];
    
    // 下拉刷新数据请求指令
    currentTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        params[@"pageindex"] = [NSNumber numberWithInteger:1];
        [[self.homeVM.getContentList execute:params] subscribeNext:^(id  _Nullable x) {
            [currentTableView.mj_header endRefreshing];
            [currentTableView.mj_footer endRefreshing];
            if (x != nil) {
                FatherStudyContentListModel *model = [FatherStudyContentListModel mj_objectWithKeyValues:x[@"Data"]];
                currentTableView.dataArr = [model.contentList mutableCopy];
                [currentTableView reloadData];
                pageindex = 2;
            }
        }];
    }];
    
    // 上拉加载更多数据指令
    currentTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        params[@"pageindex"] = [NSNumber numberWithInteger:pageindex];
        [[self.homeVM.getContentList execute:params] subscribeNext:^(id  _Nullable x) {
            [currentTableView.mj_footer endRefreshing];
            if (x != nil) {
                FatherStudyContentListModel *model = [FatherStudyContentListModel mj_objectWithKeyValues:x[@"Data"]];
                NSArray *newDataArr = [model.contentList mutableCopy];
                NSMutableArray *oldArr = currentTableView.dataArr;
                NSMutableArray *allDataArr = [NSMutableArray arrayWithArray:oldArr];
                [allDataArr addObjectsFromArray:newDataArr];
                currentTableView.dataArr = allDataArr;
                [currentTableView reloadData];
                pageindex ++;
            }
        }];
    }];
}

#pragma mark - LSPPageViewDelegate
- (void)pageViewScollEndView:(LSPPageView *)pageView WithIndex:(NSInteger)index {
    
}

#pragma mark -- 懒加载
- (NSMutableArray *)childVcArray {
    if (_childVcArray == nil) {
        _childVcArray = [[NSMutableArray alloc] init];
    }
    return _childVcArray;
}

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

@end
