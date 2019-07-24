//
//  CommonSearchViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/10/24.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "CommonSearchViewController.h"
#import "SearchCollectionViewCell.h"
#import "SearchCollectionReusableView.h"
#import "HomeViewModel.h"
#import "LSPPageView.h"
#import "LSPContentView.h"
#import "CommonAllSearchView.h"
#import "SearchVideoModel.h"
#import "SearchArticleModel.h"
#import "SearchFatherStudyContentModel.h"
#import "HomeListModel.h"
#import "HMDetailViewController.h"
#import "FCAudioDetailViewController.h"
#import "FCCourseDetailViewController.h"
#import "FcCoursesModel.h"
#import "FileEntityModel.h"
#import "SearchActivityModel.h"
#import "FSDetailViewController.h"
#import "FatherStudyCategoryModel.h"
#import "ATYCache.h"

@interface CommonSearchViewController () <UITextFieldDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,LSPPageViewDelegate>
@property (nonatomic, weak) UIView *searchNavView;
@property (nonatomic, weak) UICollectionView *myCollectionView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) HomeViewModel *homeVM;
@property (nonatomic, strong) CommonAllSearchView *allSearchView;
@property (nonatomic, strong) NSMutableArray *allSearchDataArr;
@property (nonatomic, strong) NSMutableArray *childVcArray;
@property (nonatomic, strong) NSMutableArray *titleArr;
@property (nonatomic, copy) NSString *searchText;
@property (nonatomic, strong) LSPPageView *pageView;
@end

@implementation CommonSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KHEXRGB(0xF7F7F7);
    
    self.navView.hidden = YES;
    
    [self initCustomUI];
    
    [self requestData];
    
    [self.textField becomeFirstResponder];
    
}

- (void)requestData {
    dispatch_group_t group1 =   dispatch_group_create();
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
        params[@"moduleType"] = [NSNumber numberWithInteger:0];
        dispatch_group_enter(group1);
        [[self.homeVM.getMySearchHistoryCommand execute:params] subscribeNext:^(id  _Nullable x) {
            if (x != nil) {
                [self.dataArray[0] addObjectsFromArray:x[@"Data"]];
            }
            dispatch_group_leave(group1);
        }];
    } else {
        [self.dataArray[0] addObjectsFromArray:[ATYCache readCache:SEARCHHISTORY] == nil ? [[NSMutableArray alloc] init] : [ATYCache readCache:SEARCHHISTORY]];
    }
    
    NSMutableDictionary *params1 = [[NSMutableDictionary alloc] init];
    params1[@"moduleType"] = [NSNumber numberWithInteger:0];
    dispatch_group_enter(group1);
    [[self.homeVM.getHotSearchCommand execute:params1] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            [self.dataArray[1] addObjectsFromArray:x[@"Data"]];
        }
        dispatch_group_leave(group1);
    }];
    
    dispatch_group_notify(group1, dispatch_get_main_queue(), ^{
        [self.myCollectionView reloadData];
    });
}

-(void)initCustomUI
{
    [self searchNavView];
    [self myCollectionView];
}

#pragma mark -UICollectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SearchCollectionViewCell" forIndexPath:indexPath];
    NSArray *titleAry = self.dataArray[indexPath.section];
    cell.titleLab.text = titleAry[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.searchText = self.dataArray[indexPath.section][indexPath.item];
    [self searchRequest:self.dataArray[indexPath.section][indexPath.item] type:[NSNumber numberWithInteger:0] index:0];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *titleAry = self.dataArray[indexPath.section];
    CGFloat cellWidth = [SearchCollectionViewCell cellWidthForData:titleAry[indexPath.row]];
    return CGSizeMake(cellWidth, 25);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:@"UICollectionElementKindSectionHeader"]) {
        SearchCollectionReusableView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"UICollectionReusableView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            reusableView.lineView.hidden = YES;
            reusableView.deleteBtn.hidden = NO;
            reusableView.titleLab.text = @"搜索历史";
            __weak typeof(self) weakSelf = self;
            reusableView.deleteBtnBlock = ^{
                [weakSelf deleteSearchHistory];
            };
        } else if (indexPath.section == 1) {
            reusableView.lineView.hidden = NO;
            reusableView.deleteBtn.hidden = YES;
            reusableView.titleLab.text = @"热门搜索";
        }
        return reusableView;
    } else {
        return nil;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 16, 22, 16);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(self.view.bounds.size.width, 50);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}

#pragma mark -UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    self.searchText = textField.text;
    [self searchRequest:textField.text type:[NSNumber numberWithInteger:0] index:0];
    return YES;
}

#pragma mark -- search
- (void)searchRequest:(NSString *)text type:(NSNumber *)searchType index:(NSInteger)index {
    if (text.length) {
        [self.textField resignFirstResponder];
        @weakify(self);
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"keyword"] = text;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
            params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
        } else {
            params[@"userId"] = [NSNumber numberWithInteger:0];
        }
        __block NSInteger pageindex = 1;
        params[@"page"] = @{@"pageindex":[NSNumber numberWithInteger:pageindex],@"pagesize":[NSNumber numberWithInteger:8]};
        params[@"searchType"] = searchType;
        [[self.homeVM.getSearchAllCommand execute:params] subscribeNext:^(id  _Nullable x) {
            if (x != nil) {
                @strongify(self);
                [self addSearchData:x[@"Data"]];
                [self creatSearchResultView];
                self.myCollectionView.hidden = YES;
                [self.dataArray[0] addObject:text];
                NSIndexSet *index = [NSIndexSet indexSetWithIndex:0];
                [self.myCollectionView reloadSections:index];
                if ([params[@"userId"] integerValue] == 0) {
                    NSMutableArray *searchArr = [ATYCache readCache:SEARCHHISTORY] == nil ? [[NSMutableArray alloc] init] : [ATYCache readCache:SEARCHHISTORY];
                    [searchArr addObject:text];
                    NSOrderedSet *set = [NSOrderedSet orderedSetWithArray:searchArr];
                    NSMutableArray *orderSearchArr = [[NSMutableArray alloc] initWithArray:set.array];
                    [ATYCache saveDataCache:orderSearchArr forKey:SEARCHHISTORY];
                }
            }
        }];
    }
}

- (void)addSearchData:(NSDictionary *)data{
    [self.titleArr removeAllObjects];
    [self.allSearchDataArr removeAllObjects];
    SearchArticleModel *articleModel = [SearchArticleModel mj_objectWithKeyValues:data[@"article"]];
    SearchVideoModel *videoModel = [SearchVideoModel mj_objectWithKeyValues:data[@"video"]];
    SearchFatherStudyContentModel *bookModel = [SearchFatherStudyContentModel mj_objectWithKeyValues:data[@"book"]];
    SearchFatherStudyContentModel *toyModel = [SearchFatherStudyContentModel mj_objectWithKeyValues:data[@"toy"]];
    if (articleModel) {
        [articleModel.data enumerateObjectsUsingBlock:^(HomeListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.isShowType = YES;
        }];
        [self.allSearchDataArr addObject:articleModel];
        [self.titleArr addObject:articleModel.title];
    }
    if (videoModel) {
        [self.allSearchDataArr addObject:videoModel];
        [self.titleArr addObject:videoModel.title];
    }
    
    if (bookModel) {
        [self.allSearchDataArr addObject:bookModel];
        [self.titleArr addObject:bookModel.title];
    }
    if (toyModel) {
        [self.allSearchDataArr addObject:toyModel];
        [self.titleArr addObject:toyModel.title];
    }
}

#pragma mark -- 根据返回搜索数据创建结果视图
- (void)creatSearchResultView {
    [self.childVcArray removeAllObjects];
    for (int i = 0; i < self.titleArr.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        self.allSearchView = [[CommonAllSearchView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KBottomSafeHeight - 44 - 74) style:UITableViewStyleGrouped];
        self.allSearchView.tag = 10 + i;
        [vc.view addSubview:self.allSearchView];
        [self.childVcArray addObject:vc];
        if (i == 0) {
            self.allSearchView.dataArr = [[NSMutableArray alloc] initWithObjects:self.allSearchDataArr[i], nil];
            [self.allSearchView reloadData];
        }
        [self searchCurrentView:self.allSearchView index:i];
    }
    if (self.titleArr.count > 0) {
        LSPTitleStyle *style = [[LSPTitleStyle alloc] init];
        style.isNeedScale = YES;
        style.isAverage = YES;
        self.pageView = [[LSPPageView alloc] initWithFrame:CGRectMake(0, 74+KTopBarSafeHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - 74 - KBottomSafeHeight - KTopBarSafeHeight) titles:self.titleArr style:style childVcs:self.childVcArray.mutableCopy parentVc:self];
        self.pageView.delegate = self;
        self.pageView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:self.pageView];
    }
}

- (void)searchCurrentView:(CommonAllSearchView *)currentAllSearchView index:(NSInteger)index {
    @weakify(self);
    currentAllSearchView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        if ([dataArr[indexPath.section] isKindOfClass:[SearchArticleModel class]]) {
            SearchArticleModel *articleModel = dataArr[indexPath.section];
            HomeListModel *model = articleModel.data[indexPath.row];
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
        }
        if ([dataArr[indexPath.section] isKindOfClass:[SearchVideoModel class]]) {
            SearchVideoModel *videoModel = dataArr[indexPath.section];
            FcCoursesModel *courseModel = videoModel.data[indexPath.row];
            if ([courseModel.coursesType integerValue] == 2) {
                FCCourseDetailViewController *detailVC = [[FCCourseDetailViewController alloc] init];
                detailVC.course_id = courseModel.courses_id;
                detailVC.coverImageStr = courseModel.image.path;
                [self.navigationController pushViewController:detailVC animated:YES];
            } else if ([courseModel.coursesType integerValue] == 3) {
                FCAudioDetailViewController *detailVC = [[FCAudioDetailViewController alloc] init];
                detailVC.courses_id = courseModel.courses_id;
                [self.navigationController pushViewController:detailVC animated:YES];
            }
        }
        
        if ([dataArr[indexPath.section] isKindOfClass:[SearchFatherStudyContentModel class]]) {
            SearchFatherStudyContentModel *fsContentModel = dataArr[indexPath.section];
            FatherStudyContentModel *contentModel = fsContentModel.data[indexPath.row];
            FSDetailViewController *detailVC = [[FSDetailViewController alloc] init];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                detailVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=%@&aId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],contentModel.content_id];
            } else {
                detailVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=0&aId=%@",contentModel.content_id];
            }
            detailVC.aId = contentModel.content_id;
            detailVC.titleStr = contentModel.title;
            detailVC.content = contentModel.summarize;
            if (contentModel.image) {
                detailVC.urlStr = contentModel.image.path;
            }
            [self.navigationController pushViewController:detailVC animated:YES];
        }
    };
    
    __block NSNumber *searchType = [NSNumber numberWithInteger:0];
    __block NSArray *currentDataArr = [[NSArray alloc] init];
    [self.allSearchDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == index) {
            if ([obj isKindOfClass:[SearchArticleModel class]]) {
                SearchArticleModel *articleModel = (SearchArticleModel *)obj;
                searchType = articleModel.searchType;
                currentDataArr = articleModel.data;
            }
            if ([obj isKindOfClass:[SearchVideoModel class]]) {
                SearchVideoModel *videoModel = (SearchVideoModel *)obj;
                searchType = videoModel.searchType;
                currentDataArr = videoModel.data;
            }
            if ([obj isKindOfClass:[SearchFatherStudyContentModel class]]) {
                SearchFatherStudyContentModel *fsContentModel = (SearchFatherStudyContentModel *)obj;
                searchType = fsContentModel.searchType;
                currentDataArr = fsContentModel.data;
            }
        }
    }];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"keyword"] = self.searchText;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    } else {
        params[@"userId"] = [NSNumber numberWithInteger:0];
    }
    __block NSInteger pageindex = currentDataArr.count/8 + 1 + (currentDataArr.count%8 > 0 ? 1 : 0);
    params[@"searchType"] = searchType;
        // 下拉刷新数据请求指令
        currentAllSearchView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self);
            params[@"page"] = @{@"pageindex":[NSNumber numberWithInteger:1],@"pagesize":[NSNumber numberWithInteger:8]};
            [[self.homeVM.getSearchAllCommand execute:params] subscribeNext:^(id  _Nullable x) {
                [currentAllSearchView.mj_header endRefreshing];
                [currentAllSearchView.mj_footer endRefreshing];
                if (x != nil) {
                    SearchArticleModel *articleModel = [SearchArticleModel mj_objectWithKeyValues:x[@"Data"][@"article"]];
                    SearchVideoModel *videoModel = [SearchVideoModel mj_objectWithKeyValues:x[@"Data"][@"video"]];
                    SearchFatherStudyContentModel *bookModel = [SearchFatherStudyContentModel mj_objectWithKeyValues:x[@"Data"][@"book"]];
                    SearchFatherStudyContentModel *toyModel = [SearchFatherStudyContentModel mj_objectWithKeyValues:x[@"Data"][@"toy"]];
                    
                    if (articleModel) {
                        [articleModel.data enumerateObjectsUsingBlock:^(HomeListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            obj.isShowType = YES;
                        }];
                        currentAllSearchView.dataArr = [[NSMutableArray alloc] initWithObjects:articleModel, nil];
                        [self.allSearchDataArr replaceObjectAtIndex:index withObject:articleModel];
                    }
                    if (videoModel) {
                        currentAllSearchView.dataArr = [[NSMutableArray alloc] initWithObjects:videoModel, nil];
                        [self.allSearchDataArr replaceObjectAtIndex:index withObject:videoModel];
                    }
                    if (bookModel) {
                        currentAllSearchView.dataArr = [[NSMutableArray alloc] initWithObjects:bookModel, nil];
                        [self.allSearchDataArr replaceObjectAtIndex:index withObject:bookModel];
                    }
                    if (toyModel) {
                        currentAllSearchView.dataArr = [[NSMutableArray alloc] initWithObjects:toyModel, nil];
                        [self.allSearchDataArr replaceObjectAtIndex:index withObject:toyModel];
                    }
                    [currentAllSearchView reloadData];
                    pageindex = 2;
                }
            }];
        }];
        
    // 上拉加载更多数据指令
    currentAllSearchView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
    params[@"page"] = @{@"pageindex":[NSNumber numberWithInteger:pageindex],@"pagesize":[NSNumber numberWithInteger:8]};
        @strongify(self);
        [[self.homeVM.getSearchAllCommand execute:params] subscribeNext:^(id  _Nullable x) {
            [currentAllSearchView.mj_footer endRefreshing];
            if (x != nil) {
                SearchArticleModel *articleModel = [SearchArticleModel mj_objectWithKeyValues:x[@"Data"][@"article"]];
                SearchVideoModel *videoModel = [SearchVideoModel mj_objectWithKeyValues:x[@"Data"][@"video"]];
                SearchFatherStudyContentModel *bookModel = [SearchFatherStudyContentModel mj_objectWithKeyValues:x[@"Data"][@"book"]];
                SearchFatherStudyContentModel *toyModel = [SearchFatherStudyContentModel mj_objectWithKeyValues:x[@"Data"][@"toy"]];
                    
                if (articleModel) {
                    [articleModel.data enumerateObjectsUsingBlock:^(HomeListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        obj.isShowType = YES;
                    }];
                    NSArray *newArr = articleModel.data;
                    SearchArticleModel *artiModel = (SearchArticleModel *)[currentAllSearchView.dataArr firstObject];
                    NSMutableArray *oldArr = [[NSMutableArray alloc] initWithArray:artiModel.data];
                    [oldArr addObjectsFromArray:newArr];
                    articleModel.data = oldArr;
                    currentAllSearchView.dataArr = [[NSMutableArray alloc] initWithObjects:articleModel, nil];
                    [self.allSearchDataArr replaceObjectAtIndex:index withObject:articleModel];
                }
                if (videoModel) {
                    NSArray *newArr = videoModel.data;
                    SearchVideoModel *viModel = (SearchVideoModel *)[currentAllSearchView.dataArr firstObject];
                    NSMutableArray *oldArr = [[NSMutableArray alloc] initWithArray:viModel.data];
                    [oldArr addObjectsFromArray:newArr];
                    videoModel.data = oldArr;
                    currentAllSearchView.dataArr = [[NSMutableArray alloc] initWithObjects:videoModel, nil];
                    [self.allSearchDataArr replaceObjectAtIndex:index withObject:videoModel];
                }
                if (bookModel) {
                    NSArray *newArr = bookModel.data;
                    SearchFatherStudyContentModel *boModel = (SearchFatherStudyContentModel *)[currentAllSearchView.dataArr firstObject];
                    NSMutableArray *oldArr = [[NSMutableArray alloc] initWithArray:boModel.data];
                        [oldArr addObjectsFromArray:newArr];
                    bookModel.data = oldArr;
                    currentAllSearchView.dataArr = [[NSMutableArray alloc] initWithObjects:bookModel, nil];
                    [self.allSearchDataArr replaceObjectAtIndex:index withObject:bookModel];
                }
                if (toyModel) {
                    NSArray *newArr = toyModel.data;
                    SearchFatherStudyContentModel *toModel = (SearchFatherStudyContentModel *)[currentAllSearchView.dataArr firstObject];
                    NSMutableArray *oldArr = [[NSMutableArray alloc] initWithArray:toModel.data];
                        [oldArr addObjectsFromArray:newArr];
                    toyModel.data = oldArr;
                    currentAllSearchView.dataArr = [[NSMutableArray alloc] initWithObjects:toyModel, nil];
                    [self.allSearchDataArr replaceObjectAtIndex:index withObject:toyModel];
                }
                [currentAllSearchView reloadData];
                pageindex ++;
            }
        }];
    }];
    
}

#pragma mark -Action
-(void)cancleBtn:(UIButton *)btn
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

#pragma mark - LSPPageViewDelegate
- (void)pageViewScollEndView:(LSPPageView *)pageView WithIndex:(NSInteger)index
{
    UIViewController *VC = [self.childVcArray objectAtIndex:index];
    CommonAllSearchView *allSearchView = (CommonAllSearchView *)[VC.view viewWithTag:10 + index];
    allSearchView.dataArr = [[NSMutableArray alloc] initWithObjects:self.allSearchDataArr[index], nil];
    [allSearchView reloadData];
}

#pragma mark -- 删除搜索历史
- (void)deleteSearchHistory {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
        @weakify(self);
        [[self.homeVM.deleteSearchCommand execute:params] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if (x != nil) {
                [self.dataArray[0] removeAllObjects];
                NSIndexSet *index = [NSIndexSet indexSetWithIndex:0];
                [self.myCollectionView reloadSections:index];
                [ATYToast aty_bottomMessageToast:@"搜索历史删除成功"];
            }
        }];
    } else {
        [self.dataArray[0] removeAllObjects];
        [ATYCache removeChache:SEARCHHISTORY];
        NSIndexSet *index = [NSIndexSet indexSetWithIndex:0];
        [self.myCollectionView reloadSections:index];
        [ATYToast aty_bottomMessageToast:@"搜索历史删除成功"];
    }
}

#pragma mark -Lazy
-(UIView *)searchNavView
{
    if (!_searchNavView) {
        UIView *searchNavView = [[UIView alloc] init];
        searchNavView.backgroundColor = KHEXRGB(0xffffff);
        [self.view addSubview:searchNavView];
        _searchNavView = searchNavView;
        [searchNavView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(KTopBarSafeHeight));
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.height.equalTo(@74);
        }];
        
        // 搜索框
        UITextField *textField = [[UITextField alloc] init];
        textField.returnKeyType = UIReturnKeySearch;
        [searchNavView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(searchNavView).offset(16);
            make.top.equalTo(searchNavView).offset(30);
            make.right.equalTo(@(-70));
            make.height.equalTo(@35);
        }];
        _textField = textField;
        textField.delegate = self;
        textField.layer.masksToBounds = YES;
        textField.layer.cornerRadius = 16;
        textField.backgroundColor = KHEXRGB(0xF2F2F2);
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 9, 16, 16)];
        UIView *bg = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 34, 35)];
        [bg addSubview:imageView];
        imageView.image = [UIImage imageNamed:@"home_search"];
        textField.leftView = bg;
        textField.leftViewMode = UITextFieldViewModeAlways;
        
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"搜索你想要的内容" attributes:@{NSForegroundColorAttributeName:KHEXRGB(0x999999),NSFontAttributeName:[UIFont systemFontOfSize:12]}];
        
        // 取消按钮
        UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [searchNavView addSubview:cancleBtn];
        [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(searchNavView).offset(-16);
            make.centerY.equalTo(textField);
            make.size.mas_equalTo(CGSizeMake(35, 15));
        }];
        [cancleBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [cancleBtn setTitleColor:KHEXRGB(0x44C08C) forState:(UIControlStateNormal)];
        cancleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [cancleBtn addTarget:self action:@selector(cancleBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _searchNavView;
}

-(UICollectionView *)myCollectionView
{
    __weak typeof(self) weakSelf = self;
    if (!_myCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectNull collectionViewLayout:flowLayout];
        [self.view addSubview:collectionView];
        collectionView.backgroundColor = KHEXRGB(0xF7F7F7);
        _myCollectionView = collectionView;
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.searchNavView.mas_bottom);
            make.left.equalTo(weakSelf.view);
            make.right.equalTo(weakSelf.view);
            make.bottom.equalTo(weakSelf.view);
        }];
        
        [_myCollectionView registerClass:[SearchCollectionViewCell class] forCellWithReuseIdentifier:@"SearchCollectionViewCell"];
        [_myCollectionView registerClass:[SearchCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableView"];
        _myCollectionView.delegate = self;
        _myCollectionView.dataSource = self;
        
    }
    return _myCollectionView;
}

-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        NSMutableArray *dataAry = [NSMutableArray arrayWithObjects:[NSMutableArray array],[NSMutableArray array], nil];
        _dataArray = dataAry;
    }
    return _dataArray;
}

- (NSMutableArray *)allSearchDataArr {
    if (!_allSearchDataArr) {
        _allSearchDataArr = [[NSMutableArray alloc] init];
    }
    return _allSearchDataArr;
}

- (NSMutableArray *)titleArr {
    if (!_titleArr) {
        _titleArr = [[NSMutableArray alloc] init];
    }
    return _titleArr;
}

- (NSMutableArray *)childVcArray {
    if (!_childVcArray) {
        _childVcArray = [[NSMutableArray alloc] init];
    }
    return _childVcArray;
}

- (HomeViewModel *)homeVM {
    if (_homeVM == nil) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}


@end
