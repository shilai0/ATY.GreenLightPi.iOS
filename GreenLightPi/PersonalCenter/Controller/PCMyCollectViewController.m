//
//  PCMyCollectViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/26.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCMyCollectViewController.h"
#import "PCMyCollectListView.h"
#import "PersonalCenterViewModel.h"
#import "PCMyCollectModel.h"
#import "PCBrowseTypeModel.h"
#import "PCMyCollectHeadView.h"
#import "PCMyCollectBottomView.h"
#import "HMDetailViewController.h"
#import "FCCourseDetailViewController.h"
#import "FCAudioDetailViewController.h"
#import "FileEntityModel.h"
#import "ATYDataService.h"

@interface PCMyCollectViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIButton *returnButton;
@property (nonatomic, strong) UIButton *editButton;
@property (nonatomic, strong) PCMyCollectListView *myCollectListView;
@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIScrollView *contentScrollView;
@property (nonatomic, strong) UIView *headLineView;
@property (nonatomic, strong) NSMutableArray *headBtnArr;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, strong) NSMutableArray *myCollectArr;
@property (nonatomic, strong) NSMutableArray *browseHistoryArr;
@property (nonatomic, strong) PCMyCollectHeadView *headView;
@property (nonatomic, assign) BOOL isEditor;
@property (nonatomic, strong) PCMyCollectBottomView *bottomView;
@property (nonatomic, strong) NSMutableArray *selectedArr;
/**
 是否禁止ScollView拖动，防止两个代理产生死循环
 */
@property(nonatomic, assign) BOOL isForbidScrollDelegate;
/**
 开始滑动的位置
 */
@property(nonatomic, assign) CGFloat startOffsetX;

@end

@implementation PCMyCollectViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self pc_creatViews];
    [self pc_requestMyCollectData];
}

- (void)pc_requestMyCollectData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    @weakify(self);
    [[self.personalCenterVM.GetPersonalCollect execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            NSArray *dataArr = [PCMyCollectModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
            self.myCollectArr = [dataArr mutableCopy];
            PCMyCollectListView *currnetListView = [self.view viewWithTag:1000];
            currnetListView.type = SelectShowTypeDefault;
            currnetListView.dataArr = self.myCollectArr;
            PCMyCollectModel *currentModel = [self.myCollectArr firstObject];
            currnetListView.currentDataArr = [currentModel.collectList mutableCopy];
            [currnetListView reloadData];
        }
    }];
}

- (void)pc_creatViews {
    UIImageView *navBackView = [[UIImageView alloc] init];
    navBackView.backgroundColor = KHEXRGB(0xFFFFFF);
    navBackView.userInteractionEnabled = YES;
    [self.view addSubview:navBackView];
    [navBackView addSubview:self.returnButton];
    [navBackView addSubview:self.editButton];

    [navBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@64);
    }];
    
    [self.returnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@31);
        make.width.height.equalTo(@24);
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.top.equalTo(@37);
        make.width.equalTo(@30);
        make.height.equalTo(@13);
    }];
    
    @weakify(self);
    [[self.returnButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.editButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        NSInteger index = self.selectedBtn.tag - 200;
        PCMyCollectListView *currentListView = [self.view viewWithTag:1000 + index];
        if (!self.isEditor) {
            [currentListView setEditing:YES animated:NO];
            self.bottomView.hidden = NO;
            [self.editButton setTitle:@"取消" forState:UIControlStateNormal];
        } else {
            [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
            [currentListView setEditing:NO animated:NO];
            self.bottomView.hidden = YES;
        }
        self.isEditor = !self.isEditor;
        [currentListView reloadData];
    }];
    
    NSArray *titleArr = @[@"我的收藏",@"浏览历史"];
    CGFloat Width = (KSCREEN_WIDTH - 140)/(titleArr.count);
    [titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        UIButton *headBtn = [UIButton new];
        headBtn.frame = CGRectMake(70 + idx * Width, 35, Width, 27);
        [headBtn setTitle:NSLocalizedString(obj, nil) forState:UIControlStateNormal];
        [headBtn setTitleColor:KHEXRGB(0x333333) forState:UIControlStateNormal];
        headBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [navBackView addSubview:headBtn];
        headBtn.tag = 200 + idx;
        [self.headBtnArr addObject:headBtn];
        if (idx == 0) {
            self.selectedBtn = headBtn;
            [self.selectedBtn setTitleColor:KHEXRGB(0x44c08c) forState:UIControlStateNormal];
            self.selectedBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        }
        @weakify(self);
        [[headBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.selectedBtn != headBtn) {
                [headBtn setTitleColor:KHEXRGB(0x44c08c) forState:UIControlStateNormal];
                headBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
                [self.selectedBtn setTitleColor:KHEXRGB(0x333333) forState:UIControlStateNormal];
                self.selectedBtn.titleLabel.font = [UIFont systemFontOfSize:17];
                self.selectedBtn = headBtn;
                [self changeData:idx switchIndex:0];
            }
            NSInteger index = headBtn.tag - 200;
            [self.contentScrollView setContentOffset:CGPointMake(KSCREEN_WIDTH * index, 0) animated:YES];
            self.isForbidScrollDelegate = YES;
            [UIView animateWithDuration:0.5 animations:^{
                self.headLineView.frame = CGRectMake(self.selectedBtn.frame.origin.x + ((self.selectedBtn.frame.size.width - self.headLineView.frame.size.width) / 2.0), CGRectGetMaxY(self.selectedBtn.frame), 20, 2);
            }];
        }];
    }];
    
    self.headLineView.frame = CGRectMake(CGRectGetMaxX(self.selectedBtn.frame) - self.selectedBtn.frame.size.width/2 - 10, 60, 20, 2);
    [navBackView addSubview:self.headLineView];
    self.headLineView.backgroundColor = KHEXRGB(0x44c08c);

    self.contentScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64,KSCREEN_WIDTH , KSCREENH_HEIGHT-CGRectGetMaxY(_headLineView.frame) - KBottomSafeHeight)];
    [self.view addSubview:self.contentScrollView];
    self.contentScrollView.delegate=self;
    self.contentScrollView.pagingEnabled=YES;
    self.contentScrollView.alwaysBounceVertical = NO;
    self.contentScrollView.showsHorizontalScrollIndicator=NO;
    self.contentScrollView.showsVerticalScrollIndicator=NO;
    self.contentScrollView.bounces = NO;
    self.contentScrollView.contentSize = CGSizeMake(KSCREEN_WIDTH*(titleArr.count), 0);
    
    for (int i = 0; i < titleArr.count; i ++) {
        self.myCollectListView = [[PCMyCollectListView alloc] initWithFrame:CGRectMake(KSCREEN_WIDTH * i, 0,KSCREEN_WIDTH , KSCREENH_HEIGHT-CGRectGetMaxY(_headLineView.frame)) style:UITableViewStylePlain];
        self.myCollectListView.tag = 1000 + i;
        [_contentScrollView addSubview:self.myCollectListView];
        
        @weakify(self);
        self.myCollectListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
            @strongify(self);
            if (!self.isEditor) {
                if (i == 0) {
                    CollectModel *collectModel = dataArr[indexPath.row];
                    NSInteger moduleType = [self getModuleTypeWithStr:collectModel.collectModularType];
                    if ([collectModel.collectContentType isEqualToString:@"图文"]) {
                        HMDetailViewController *detailVC = [[HMDetailViewController alloc] init];
                        detailVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/articleDetail.html?uId=%@&aId=%@&moduleType=%ld",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],collectModel.contactId,moduleType];
                        detailVC.aid = collectModel.contactId;
                        detailVC.titleStr = collectModel.title;
//                        detailVC.contentStr = collectModel.contentIntro;
                        detailVC.urlStr = collectModel.image.path;
                        detailVC.moduleType = moduleType;
                        [self.navigationController pushViewController:detailVC animated:YES];
                    } else if ([collectModel.collectContentType isEqualToString:@"课程"]) {
                        FCCourseDetailViewController *detailVC = [[FCCourseDetailViewController alloc] init];
                        detailVC.course_id = collectModel.contactId;
                        detailVC.coverImageStr = collectModel.image.path;
                        [self.navigationController pushViewController:detailVC animated:YES];
                    } else if ([collectModel.collectContentType isEqualToString:@"专辑"]) {
                        FCAudioDetailViewController *detailVC = [[FCAudioDetailViewController alloc] init];
                        detailVC.courses_id = collectModel.contactId;
                        [self.navigationController pushViewController:detailVC animated:YES];
                    }
                } else if (i == 1) {
                    BrowseModel *browModel = dataArr[indexPath.row];
                    NSInteger moduleType = [self getModuleTypeWithStr:browModel.browseModularType];
                    if ([browModel.browseContentType isEqualToString:@"图文"]) {
                        HMDetailViewController *detailVC = [[HMDetailViewController alloc] init];
                        detailVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/articleDetail.html?uId=%@&aId=%@&moduleType=%ld",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],browModel.contactId,moduleType];
                        detailVC.aid = browModel.contactId;
                        detailVC.titleStr = browModel.title;
                        //                    detailVC.contentStr = collectModel.contentIntro;
                        detailVC.urlStr = browModel.image.path;
                        detailVC.moduleType = moduleType;
                        [self.navigationController pushViewController:detailVC animated:YES];
                    } else if ([browModel.browseContentType isEqualToString:@"视频"]) {
                        FCCourseDetailViewController *detailVC = [[FCCourseDetailViewController alloc] init];
                        detailVC.course_id = browModel.contactId;
                        detailVC.coverImageStr = browModel.image.path;
                        [self.navigationController pushViewController:detailVC animated:YES];
                    } else if ([browModel.browseContentType isEqualToString:@"音频"]) {
                        FCAudioDetailViewController *detailVC = [[FCAudioDetailViewController alloc] init];
                        detailVC.courses_id = browModel.contactId;
                        [self.navigationController pushViewController:detailVC animated:YES];
                    }
                }
            }
        };
        
    }
    
    [self.view addSubview:self.bottomView];
    self.bottomView.hidden = YES;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(@(-KBottomSafeHeight));
        make.height.equalTo(@49);
    }];
    
    self.bottomView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        NSInteger currentIndex = self.selectedBtn.tag - 200;
        PCMyCollectListView *currentListView = [self.view viewWithTag:1000 + currentIndex];
        if (index == 0) {//全选
            if (self.isEditor && [content1 isEqualToString:@"1"]) {
                for (int i = 0; i < currentListView.currentDataArr.count; i ++) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    [currentListView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionTop];
                }
            } else if (self.isEditor && [content1 isEqualToString:@"0"]) {
                for (int i = 0; i < currentListView.currentDataArr.count; i ++) {
                    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
                    [currentListView deselectRowAtIndexPath:indexPath animated:NO];
                }
            }
        } else {//删除
            [self deleteData:currentListView index:currentIndex];
        }
    };
}

#pragma mark -- requestData
/**
 index:导航索引，switchIndex：头部索引；
 */
- (void)changeData:(NSInteger)index switchIndex:(NSInteger)switchIndex{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    @weakify(self);
    PCMyCollectListView *currnetListView = [self.view viewWithTag:1000 + index];
    if (index == 0) {
        [[self.personalCenterVM.GetPersonalCollect execute:params] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if (x != nil) {
                NSArray *dataArr = [PCMyCollectModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
                self.myCollectArr = [dataArr mutableCopy];
                currnetListView.type = SelectShowTypeDefault;
                currnetListView.dataArr = self.myCollectArr;
                PCMyCollectModel *currentModel = [self.myCollectArr objectAtIndex:switchIndex];
                currnetListView.switchIndex = switchIndex;
                currnetListView.currentDataArr = [currentModel.collectList mutableCopy];
                [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
                [currnetListView setEditing:NO animated:NO];
                self.isEditor = NO;
                self.bottomView.hidden = YES;
                [currnetListView reloadData];
            }
        }];
    } else {
        [[self.personalCenterVM.GetReadRecord execute:params] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if (x != nil) {
                NSArray *dataArr = [PCBrowseTypeModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
                self.browseHistoryArr = [dataArr mutableCopy];
                currnetListView.type = SelectShowTypeBrows;
                currnetListView.dataArr = self.browseHistoryArr;
                PCBrowseTypeModel *currentModel = [self.browseHistoryArr objectAtIndex:switchIndex];
                currnetListView.switchIndex = switchIndex;
                currnetListView.currentDataArr = [currentModel.browseList mutableCopy];
                [self.editButton setTitle:@"编辑" forState:UIControlStateNormal];
                [currnetListView setEditing:NO animated:NO];
                self.isEditor = NO;
                self.bottomView.hidden = YES;
                [currnetListView reloadData];
            }
        }];
    }
}

#pragma mark -- UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    self.isForbidScrollDelegate = NO;
    
    self.startOffsetX = scrollView.contentOffset.x;
    
}

#pragma mark--实时监听滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //判断是否是点击事件
    if (self.isForbidScrollDelegate) {
        return;
    }
    //定义获取需要的变量
    CGFloat progress = 0.0;
    NSInteger sourceIndex = 0;
    NSInteger targetIndex = 0;
    
    //判断是左滑还是右滑
    CGFloat currentOffsetX = scrollView.contentOffset.x;
    CGFloat scrollViewW = scrollView.bounds.size.width;
    
    if (currentOffsetX > self.startOffsetX) {//左滑

        //计算progress
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        
        //计算sourceIndex
        sourceIndex =  (NSInteger)(currentOffsetX / scrollViewW);
        
        //计算targetIndex
        targetIndex = sourceIndex + 1;
        //        NSLog(@"targetIndex=%zd",targetIndex);
        if (targetIndex >= self.headBtnArr.count) {
            targetIndex = self.headBtnArr.count - 1;
            sourceIndex = self.headBtnArr.count - 1;
        }
        
        //如果完全划过去
        if (currentOffsetX - self.startOffsetX == scrollViewW) {
            
            progress = 1.0;
            targetIndex = sourceIndex;
        }
        
    }else{//右滑
        if (currentOffsetX < 0) {
            return;
        }
        //计算progress
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        
        //计算targetIndex
        targetIndex = (NSInteger)(currentOffsetX / scrollViewW);
        
        //计算sourceIndex
        sourceIndex = targetIndex + 1;
        
        if (sourceIndex >= self.headBtnArr.count) {
            
            sourceIndex = self.headBtnArr.count - 1;
        }
    }
    
    //取出sourceLabel和targetLabel
    UIButton *sourceBtn = self.headBtnArr[sourceIndex];
    UILabel *targetBtn = self.headBtnArr[targetIndex];
    CGFloat moveTotalX = targetBtn.frame.origin.x - sourceBtn.frame.origin.x;
    CGFloat moveTotalW = targetBtn.frame.size.width - sourceBtn.frame.size.width;
    
    //计算滚动的范围差值
    CGFloat x = sourceBtn.frame.origin.x + ((sourceBtn.frame.size.width - self.headLineView.frame.size.width)/2.0) + moveTotalX * progress;
        
    CGFloat width = self.headLineView.frame.size.width + moveTotalW * progress;
        
    self.headLineView.frame = CGRectMake(x, self.headLineView.frame.origin.y,width, self.headLineView.frame.size.height);
}

#pragma mark--停止滚动
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView ==_contentScrollView && self.startOffsetX != _contentScrollView.contentOffset.x) {
        int i=_contentScrollView.contentOffset.x/KSCREEN_WIDTH;
        UIButton *btn = self.headBtnArr[i];
        [self.selectedBtn setTitleColor:KHEXRGB(0x333333) forState:UIControlStateNormal];
        self.selectedBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [btn setTitleColor:KHEXRGB(0x44c08c) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.selectedBtn = btn;
        [self changeData:i switchIndex:0];
    }
}

#pragma mark -- 删除
- (void)deleteData:(PCMyCollectListView *)myCollectListView index:(NSInteger)index{
    //获取已选中的行号
    NSArray *indexPaths = [myCollectListView indexPathsForSelectedRows];
    @weakify(self);
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        if (index == 0) {
            CollectModel *model = myCollectListView.currentDataArr[obj.row];
            params[@"id"] = model.collectId;
            params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
            params[@"typeName"] = model.collectModularType;
            [self.selectedArr addObject:params];
        } else if (index == 1) {
            BrowseModel *model = myCollectListView.currentDataArr[obj.row];
            params[@"id"] = model.browseId;
            params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
            params[@"typeName"] = model.browseModularType;
            [self.selectedArr addObject:params];
        }
    }];
    
    if (self.selectedArr.count == 0) {
        [ATYToast aty_bottomMessageToast:@"请选择要删除的内容！"];
        return;
    }
    
    NSString *nsurl = nil;
    if (index == 0) {
        nsurl = @"http://interface.aiteyou.net/api/PersonalCenterApi/DeleteCollect";
//        nsurl = @"http://release.aiteyou.net/api/PersonalCenterApi/DeleteCollect";
//        nsurl = @"http://api.aiteyou.net/api/PersonalCenterApi/DeleteCollect";
    } else if (index == 1) {
        nsurl = @"http://interface.aiteyou.net/api/PersonalCenterApi/DeleteReadRecord";
//        nsurl = @"http://release.aiteyou.net/api/PersonalCenterApi/DeleteCollect";
//        nsurl = @"http://api.aiteyou.net/api/PersonalCenterApi/DeleteReadRecord";
    }
    
    ATYDataService *dataService = [ATYDataService sharedManager];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:PROJECT_TOKEN];
    [dataService.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [dataService POST:nsurl parameters:self.selectedArr progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject[@"Msg"][@"message"] isEqualToString:@""]) {
            [ATYToast aty_bottomMessageToast:responseObject[@"Msg"][@"message"]];
        }
//        if ([responseObject[@"Success"] intValue] == Success) {
//            [myCollectListView.currentDataArr removeObjectsInArray:self.selectedArr];
//            [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [myCollectListView.currentDataArr removeObjectAtIndex:obj.row];
//            }];
//            [myCollectListView reloadData];
//        }
        [self changeData:index switchIndex:myCollectListView.switchIndex];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [ATYToast aty_bottomMessageToast:@"数据请求失败"];
    }];
    
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

#pragma mark -- 懒加载
- (NSMutableArray *)selectedArr {
    if (!_selectedArr) {
        _selectedArr = [[NSMutableArray alloc] init];
    }
    return _selectedArr;
}

- (PCMyCollectBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[PCMyCollectBottomView alloc] init];
        _bottomView.backgroundColor = KHEXRGB(0xFFFFFF);
    }
    return _bottomView;
}

- (NSMutableArray *)myCollectArr {
    if (!_myCollectArr) {
        _myCollectArr = [[NSMutableArray alloc] init];
    }
    return _myCollectArr;
}

- (NSMutableArray *)browseHistoryArr {
    if (!_browseHistoryArr) {
        _browseHistoryArr = [[NSMutableArray alloc] init];
    }
    return _browseHistoryArr;
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

- (UIView *)headLineView {
    if (_headLineView == nil) {
        _headLineView = [UIView new];
    }
    return _headLineView;
}

- (NSMutableArray *)headBtnArr {
    if (!_headBtnArr) {
        _headBtnArr = [[NSMutableArray alloc] init];
    }
    return _headBtnArr;
}

- (UIButton *)returnButton {
    if (!_returnButton) {
        _returnButton = [UIButton new];
        [_returnButton setBackgroundImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    }
    return _returnButton;
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [[UIButton alloc] init];
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        _editButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _editButton;
}


@end
