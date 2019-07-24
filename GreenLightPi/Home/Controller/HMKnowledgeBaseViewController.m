//
//  HMKnowledgeBaseViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/29.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMKnowledgeBaseViewController.h"
#import "UIButton+Common.h"
#import "UIImageView+WebCache.h"
#import "FileEntityModel.h"
#import "HomeViewModel.h"
#import "ChanelModel.h"
#import "LSPPageView.h"
#import "HMChannelMenuViewController.h"
#import "HomeListTableView.h"
#import "HomeListModel.h"
#import "FileEntityModel.h"
#import "LSPTitleStyle.h"
#import "HMDetailViewController.h"
#import "UserModel.h"
#import "ATYCache.h"
#import "FCAudioDetailViewController.h"
#import "FCCourseDetailViewController.h"
#import "CommonSearchViewController.h"
#import "DataLoadFaultView.h"
#import "BaseNavigationViewController.h"
#import "HMKnowledgeHeadView.h"
#import "RLFirstOpenAppViewController.h"

@interface HMKnowledgeBaseViewController ()<UISearchBarDelegate,LSPPageViewDelegate>
@property (nonatomic,strong) HomeViewModel *homeVM;
@property (nonatomic,strong) NSMutableArray *headTitleArray;
@property (nonatomic,strong) NSMutableArray *titleDicArray;
@property (nonatomic,strong) HomeListTableView *homeListTableView;
@property (nonatomic,strong) NSMutableArray *childVcArray;
@property (nonatomic,strong) NSMutableArray *babyDayRecommentArr;
@property (nonatomic,strong) NSMutableArray *items;
@property (nonatomic, strong) CLLocationManager *locationmanager;//定位服务
@property (nonatomic, strong) NSArray *followerArr;
@property (nonatomic, strong) NSArray *followDynamicArr;
@property (nonatomic, strong) UIView *selectBackView;
@property (nonatomic, strong) DataLoadFaultView *dataFaultView;
@property (nonatomic, strong) HMKnowledgeHeadView *knowladgeHeadView;
@end

@implementation HMKnowledgeBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = KHEXRGB(0xFFFFFF);
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self hm_setKnowladgeHeadView];
    [self hm_getMyChanelData];
    
    //接收编辑频道的通知，重新请求我的频道数据
    @weakify(self);
    [[KNotificationCenter rac_addObserverForName:EDITECHANLE_CONTENT_NOTIFICATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self hm_getMyChanelData];
    }];
}

#pragma mark -- 导航栏
- (void)hm_setKnowladgeHeadView {
    [self.view addSubview:self.knowladgeHeadView];
    [self.knowladgeHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(60+KTopBarSafeHeight));
    }];
    
    @weakify(self);
    self.knowladgeHeadView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0:
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            case 1:
            {
                CommonSearchViewController *searchVC = [[CommonSearchViewController alloc] init];
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:searchVC];
                [self presentViewController:navController animated:YES completion:^{
                    
                }];
            }
                break;
            default:
                break;
        }
    };
}

#pragma mark -- 滑动视图
- (void)hm_creatHeadScrollView {
    [self.childVcArray removeAllObjects];
    for (int i = 0; i < self.headTitleArray.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        self.homeListTableView = [[HomeListTableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - 44) style:UITableViewStylePlain];
        self.homeListTableView.tag = 10 + i;
        [self hm_currentView:self.homeListTableView index:i];
        [vc.view addSubview:self.homeListTableView];
        [self.childVcArray addObject:vc];
    }
    LSPTitleStyle *style = [[LSPTitleStyle alloc] init];
    style.index = 0;
    style.isShowMoreBtn = YES;
//    style.isNeedScale = YES;
    style.isShowBottomLine = YES;
    style.normalColor = KHEXRGB(0x646464);
    style.font = [UIFont boldSystemFontOfSize:14];
    LSPPageView *pageView = [[LSPPageView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) titles:self.headTitleArray style:style childVcs:self.childVcArray.mutableCopy parentVc:self];
    pageView.delegate = self;
    pageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pageView];
    
    @weakify(self);
    pageView.selectAction = ^{
        //编辑频道
        @strongify(self);
        if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
            HMChannelMenuViewController *channelMenuVC = [[HMChannelMenuViewController alloc] init];
            channelMenuVC.myTagsArrM = [[NSMutableArray alloc] initWithArray:self.titleDicArray];
            [self.navigationController pushViewController:channelMenuVC animated:YES];
        } else {
            [self loginAction];
        }
        
    };
    [self hm_getOtherWithindex:0];
}

#pragma mark --
- (void)hm_currentView:(HomeListTableView *)currentView index:(NSInteger)index{
    @weakify(self);
    currentView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        //进入详情
        HomeListModel *model = dataArr[indexPath.row];
        HMDetailViewController *detailVC = [[HMDetailViewController alloc] init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
            detailVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/articleDetail.html?uId=%@&aId=%@&moduleType=0",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],model.article_id];
        } else {
            detailVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/articleDetail.html?uId=0&aId=%@&moduleType=0",model.article_id];
        }
        detailVC.aid = model.article_id;
        detailVC.titleStr = model.title;
        detailVC.contentHtmlStr = model.content;
        detailVC.urlStr = model.image.path;
        detailVC.moduleType = 0;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSDictionary *currentDic = self.titleDicArray[index];
    __block NSInteger pageindex = 2;
    if (currentView.dataArr.count) {
        pageindex = currentView.dataArr.count/8 + 1 + (currentView.dataArr.count%8 > 0 ? 1 : 0);
    }
    params[@"pageindex"] = [NSNumber numberWithInteger:pageindex];
    params[@"pagesize"] = [NSNumber numberWithInteger:8];
    params[@"articletype_id"] = currentDic[@"articletype_id"];
    
    // 下拉刷新数据请求指令
    currentView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        params[@"pageindex"] = [NSNumber numberWithInteger:1];
        [[self.homeVM.getArticleListCommand execute:params] subscribeNext:^(id  _Nullable x) {
            [currentView.mj_header endRefreshing];
            [currentView.mj_footer endRefreshing];
            if (x != nil) {
                NSArray *dataArr = x[@"Data"];
                currentView.dataArr = [[[dataArr.rac_sequence map:^id _Nullable(id  _Nullable value) {
                    return [HomeListModel mj_objectWithKeyValues:value];
                }] array] mutableCopy];
                [currentView reloadData];
                pageindex = 2;
            }
        }];
    }];
    
    // 上拉加载更多数据指令
    currentView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        params[@"pageindex"] = [NSNumber numberWithInteger:pageindex];
        @strongify(self);
        [[self.homeVM.getArticleListCommand execute:params] subscribeNext:^(id  _Nullable x) {
            [currentView.mj_footer endRefreshing];
            if (x != nil) {
                NSArray *dataArr = x[@"Data"];
                NSArray *newData = [[dataArr.rac_sequence map:^id _Nullable(id  _Nullable value) {
                    return [HomeListModel mj_objectWithKeyValues:value];
                }] array];
                NSMutableArray *oldArr = currentView.dataArr;
                NSMutableArray *allDataArr = [NSMutableArray arrayWithArray:oldArr];
                [allDataArr addObjectsFromArray:newData];
                currentView.dataArr = allDataArr;
                [currentView reloadData];
                pageindex ++;
            }
        }];
    }];
    
}

#pragma mark -- 获取数据
- (void)hm_getMyChanelData {
    [self.headTitleArray removeAllObjects];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        params[@"user_id"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    } else {
        params[@"user_id"] = [NSNumber numberWithInteger:0];
    }
    @weakify(self);
    [[self.homeVM.getHomeMyChannelCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            NSDictionary *categoryDic = [x[@"Data"] firstObject];
            NSArray *categoryList = categoryDic[@"CategoryList"];
            [self.titleDicArray removeAllObjects];
            [self.titleDicArray addObjectsFromArray:categoryList];
            for (NSDictionary *dic in categoryList) {
                ChanelModel *chanelModel = [ChanelModel mj_objectWithKeyValues:dic];
                [self.headTitleArray addObject:chanelModel.typename];
            }
            //根据接口返回数据创建视图
            [self hm_creatHeadScrollView];
        } else {
            [self.view addSubview:self.dataFaultView];
            @weakify(self);
            self.dataFaultView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
                @strongify(self);
                [self.dataFaultView removeFromSuperview];
                self.dataFaultView = nil;
                [self hm_getMyChanelData];
            };
        }
    }];
}

#pragma mark - LSPPageViewDelegate
- (void)pageViewScollEndView:(LSPPageView *)pageView WithIndex:(NSInteger)index
{
    UIViewController *vc = [self.childVcArray objectAtIndex:index];
    HomeListTableView *currentListView = [vc.view viewWithTag:10 + index];
    if (!currentListView.dataArr) {
        [self hm_getOtherWithindex:index];
    }
}

#pragma mark -- 其他
- (void)hm_getOtherWithindex:(NSInteger)index {
    UIViewController *currentVC = self.childVcArray[index];
    HomeListTableView *currentTableView = (HomeListTableView *)[currentVC.view viewWithTag:(10 + index)];
    NSDictionary *currentDic = self.titleDicArray[index];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    __block NSInteger pageindex = 1;
    params[@"pageindex"] = [NSNumber numberWithInteger:pageindex];
    params[@"pagesize"] = [NSNumber numberWithInteger:8];
    params[@"articletype_id"] = currentDic[@"articletype_id"];
    [[self.homeVM.getArticleListCommand execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            NSArray *dataArr = x[@"Data"];
            currentTableView.dataArr = [[[dataArr.rac_sequence map:^id _Nullable(id  _Nullable value) {
                return [HomeListModel mj_objectWithKeyValues:value];
            }] array] mutableCopy];
            [currentTableView reloadData];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- 字段类型转化
- (NSInteger)getModuleTypeWithStr:(NSString *)str {
    if ([str isEqualToString:@"homepage"]) {
        return 0;
    } else if ([str isEqualToString:@"fatherStudy"]) {
        return 1;
    } else if ([str isEqualToString:@"familyCoach"]) {
        return 2;
    } else if ([str isEqualToString:@"business"]) {
        return 3;
    } else if ([str isEqualToString:@"detection"]) {
        return 4;
    } else if ([str isEqualToString:@"homepageQA"]) {
        return 5;
    } else if ([str isEqualToString:@"activity"]) {
        return 6;
    } else if ([str isEqualToString:@"user"]) {
        return 7;
    }
    return 0;
}

#pragma mark -- lazy
- (HomeViewModel *)homeVM {
    if (_homeVM == nil) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

- (NSMutableArray *)headTitleArray {
    if (_headTitleArray == nil) {
        _headTitleArray = [[NSMutableArray alloc] init];
    }
    return _headTitleArray;
}

- (NSMutableArray *)titleDicArray {
    if (_titleDicArray == nil) {
        _titleDicArray = [[NSMutableArray alloc] init];
    }
    return _titleDicArray;
}

- (NSMutableArray *)childVcArray {
    if (_childVcArray == nil) {
        _childVcArray = [[NSMutableArray alloc] init];
    }
    return _childVcArray;
}

- (HMKnowledgeHeadView *)knowladgeHeadView {
    if (!_knowladgeHeadView) {
        _knowladgeHeadView = [[HMKnowledgeHeadView alloc] init];
    }
    return _knowladgeHeadView;
}

- (DataLoadFaultView *)dataFaultView {
    if (!_dataFaultView) {
        _dataFaultView = [[DataLoadFaultView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT)];
    }
    return _dataFaultView;
}

- (void)dealloc {
    [KNotificationCenter removeObserver:self];
}

@end
