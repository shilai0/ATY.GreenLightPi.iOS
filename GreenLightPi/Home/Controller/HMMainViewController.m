//
//  HMMainViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HMMainViewController.h"
#import "HMKnowledgeBaseViewController.h"
#import "RLFirstOpenAppViewController.h"
#import "BaseNavigationViewController.h"
#import "FCCourseDetailViewController.h"
#import "FCAudioDetailViewController.h"
#import "CommonSearchViewController.h"
#import "PCScanQRCodeViewController.h"
#import "HMParkUsageViewController.h"
#import "RLLoginRegisterViewModel.h"
#import "HMReadBarViewController.h"
#import "HMPLayBarViewController.h"
#import "PersonalCenterViewModel.h"
#import "HMDetailViewController.h"
#import "HMMyBabyViewController.h"
#import "ATYAlertViewController.h"
#import "HMMainSectionHeadView.h"
#import "RLRegistSuccessView.h"
#import "PCActivityTipView.h"
#import "HMMainSearchView.h"
#import "UserUseLogModel.h"
#import "FileEntityModel.h"
#import "HMMainListView.h"
#import "HMMianHeadView.h"
#import "HMMainFooterView.h"
#import "HomeViewModel.h"
#import "XSYTapSound.h"
#import "HomeModel.h"
#import "BabyModel.h"
#import "AdModel.h"

#define defaultToken @"59CAA9017F3EFAB8"

@interface HMMainViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegisterVM;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, strong) RLRegistSuccessView *registSuccessView;
@property (nonatomic, strong) PCActivityTipView *activityTipView;
@property (nonatomic, strong) HMMainSearchView *mainSearchView;
@property (nonatomic, strong) HMMainFooterView *mainFooterView;
@property (nonatomic, strong) HMMianHeadView *mainHeadView;
@property (nonatomic, strong) HMMainListView *mainListView;
@property (nonatomic, strong) UIView *shadowBackView;
@property (nonatomic, strong) HomeViewModel *homeVM;
@property (nonatomic, copy) NSString *activityCode;

/**
 首页内容总数组
 */
@property (nonatomic, strong) NSMutableArray *allContentArr;

/**
 banner图数组
 */
@property (nonatomic, strong) NSMutableArray *bannerArr;
/**
 section0(乐园使用情况)
 */
@property (nonatomic, strong) NSMutableArray *parkArr;

/**
 所有盒子列表
 */
@property (nonatomic, strong) NSMutableArray *boxListArr;

/**
 section1(育儿小妙招)
 */
@property (nonatomic, strong) NSMutableArray *parentingArr;

/**
 section2(亲子时光)
 */
@property (nonatomic, strong) NSMutableArray *acommpanyArr;

/**
 section3(居家早教)
 */
@property (nonatomic, strong) NSMutableArray *patentalGrowthArr;

/**
 mainListView的偏移量
 */
@property (nonatomic, assign) CGFloat offsetY;

@end

@implementation HMMainViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{
    if (self.offsetY <= 0) {
        return UIStatusBarStyleLightContent; //返回白色状态栏
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
        if (self.isFirstRegister) {
            static dispatch_once_t disOnce;
            dispatch_once(&disOnce,^ {

            [[UIApplication sharedApplication].keyWindow addSubview:self.shadowBackView];
            self.registSuccessView = [[RLRegistSuccessView alloc] initWithFrame:CGRectMake(0, 61, KSCREEN_WIDTH, KSCREENH_HEIGHT - 61)];
            UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.registSuccessView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(16, 16)];
            CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
            maskLayer1.frame = self.registSuccessView.bounds;
            maskLayer1.path = maskPath1.CGPath;
            self.registSuccessView.layer.mask = maskLayer1;
            [self.shadowBackView addSubview:self.registSuccessView];
            @weakify(self);
            self.registSuccessView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
                @strongify(self);
                switch (index) {
                    case 20://隐藏
                    {
                        [UIView animateWithDuration:0.3
                                         animations:^{
                                             self.shadowBackView.alpha = 0;
                                         } completion:^(BOOL finished) {
                                         }];
                        [self.shadowBackView removeFromSuperview];
                        self.shadowBackView = nil;
                    }
                        break;
                    case 21://激活一家老小
                    {
                        [UIView animateWithDuration:0.3
                                         animations:^{
                                             self.shadowBackView.alpha = 0;
                                         } completion:^(BOOL finished) {
                                         }];
                        [self.shadowBackView removeFromSuperview];
                        self.shadowBackView = nil;
                        [self scanQRCodeOpenPark];
                    }
                        break;
                    case 22://暂不激活
                    {
                        [UIView animateWithDuration:0.3
                                         animations:^{
                                             self.shadowBackView.alpha = 0;
                                         } completion:^(BOOL finished) {
                                         }];
                        [self.shadowBackView removeFromSuperview];
                        self.shadowBackView = nil;
                    }
                        break;
                    default:
                        break;
                }
            };
            });
        }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    if (![[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_TOKEN]) {
        [[NSUserDefaults standardUserDefaults] setObject:defaultToken forKey:PROJECT_TOKEN];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    if (@available(iOS 11.0, *)) {
        self.mainListView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
    }
    [self creatHomeMainSubViews];
    [self getHomeMainData];
    [self.mainListView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    @weakify(self);
    [[KNotificationCenter rac_addObserverForName:TRANSFORMPARK_NOTIFICATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self getHomeMainData];
    }];
    
    [[KNotificationCenter rac_addObserverForName:PUSHMESSAGE_NOTIFICATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        HMParkUsageViewController *parkUsageVC = [[HMParkUsageViewController alloc] init];
        parkUsageVC.pushType = JPush;
        [self.navigationController pushViewController:parkUsageVC animated:YES];
    }];
    
}

- (void)creatHomeMainSubViews {
    [self.view addSubview:self.mainListView];
    self.mainListView.tableHeaderView = self.mainHeadView;
    self.mainListView.tableFooterView = self.mainFooterView;
    [self.view addSubview:self.mainSearchView];
    [self.mainListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    [self.mainSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(72+KTopBarSafeHeight));
    }];
    
    @weakify(self);
    self.mainSearchView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0:
            {
                if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                    HMMyBabyViewController *myBabyVC = [[HMMyBabyViewController alloc] init];
                    [self.navigationController pushViewController:myBabyVC animated:YES];
                } else {
                    [self loginAction];
                }
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
    
    self.mainListView.sectionOneHeadView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        //知识库
        HMKnowledgeBaseViewController *knowledgeBaseVC = [[HMKnowledgeBaseViewController alloc] init];
        [self.navigationController pushViewController:knowledgeBaseVC animated:YES];
    };
    
    self.mainListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        HomeModel *model = dataArr[indexPath.section][indexPath.row];
        if (dataArr.count == 4) {
            switch (indexPath.section) {
                case 0://盒子使用情况
                {
                    HMParkUsageViewController *parkUsageVC = [[HMParkUsageViewController alloc] init];
                    parkUsageVC.parkListArr = self.parkArr;
                    parkUsageVC.useLogModel = self.boxListArr[indexPath.row];
                    parkUsageVC.boxListArr = self.boxListArr;
                    [self.navigationController pushViewController:parkUsageVC animated:YES];
                }
                    break;
                case 2://今日亲子时光
                {
                    if (model.category == 1) {//读吧
                        HMReadBarViewController *readBarVC = [[HMReadBarViewController alloc] init];
                        readBarVC.homeModel = model;
                        if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                            readBarVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=%@&aId=%ld",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],model.content_id];
                        } else {
                            readBarVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=0&aId=%ld",model.content_id];
                        }
                        [self.navigationController pushViewController:readBarVC animated:YES];
                    } else if (model.category == 2) {//玩吧
                        HMPLayBarViewController *playBarVC = [[HMPLayBarViewController alloc] init];
                        playBarVC.homeModel = model;
                        [self.navigationController pushViewController:playBarVC animated:YES];
                    }
                }
                    break;
                case 3://居家早教.三步曲
                {
                    if (model.contentType == 2) {//视频
                        FCCourseDetailViewController *courseDetailVC = [[FCCourseDetailViewController alloc] init];
                        courseDetailVC.course_id = [NSNumber numberWithInteger:model.content_id];
                        courseDetailVC.coverImageStr = model.imagePath;
                        [self.navigationController pushViewController:courseDetailVC animated:YES];
                    } else if (model.contentType == 3) {//音频
                        FCAudioDetailViewController *audioDetailVC = [[FCAudioDetailViewController alloc] init];
                        audioDetailVC.courses_id = [NSNumber numberWithInteger:model.content_id];
                        [self.navigationController pushViewController:audioDetailVC animated:YES];
                    }
                    
                }
                    break;
                default:
                    break;
            }
        } else if (dataArr.count == 3) {
            switch (indexPath.section) {
                case 1://今日亲子时光
                {
                    HomeModel *model = dataArr[indexPath.section][indexPath.row];
                    if (model.category == 1) {//读吧
                        HMReadBarViewController *readBarVC = [[HMReadBarViewController alloc] init];
                        readBarVC.homeModel = model;
                        if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                            readBarVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=%@&aId=%ld",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],model.content_id];
                        } else {
                            readBarVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=0&aId=%ld",model.content_id];
                        }
                        [self.navigationController pushViewController:readBarVC animated:YES];
                    } else if (model.category == 2) {//玩吧
                        HMPLayBarViewController *playBarVC = [[HMPLayBarViewController alloc] init];
                        playBarVC.homeModel = model;
                        [self.navigationController pushViewController:playBarVC animated:YES];
                    }
                }
                    break;
                case 2://母成长.三步曲
                {
                    if (model.contentType == 2) {//视频
                        FCCourseDetailViewController *courseDetailVC = [[FCCourseDetailViewController alloc] init];
                        courseDetailVC.course_id = [NSNumber numberWithInteger:model.content_id];
                        courseDetailVC.coverImageStr = model.imagePath;
                        [self.navigationController pushViewController:courseDetailVC animated:YES];
                    } else if (model.contentType == 3) {//音频
                        FCAudioDetailViewController *audioDetailVC = [[FCAudioDetailViewController alloc] init];
                        audioDetailVC.courses_id = [NSNumber numberWithInteger:model.content_id];
                        [self.navigationController pushViewController:audioDetailVC animated:YES];
                    }
                }
                    break;
                default:
                    break;
            }
        }
        
    };
    
    self.mainListView.parentingBlock = ^(NSMutableArray *dataArr, NSIndexPath *index) {
        @strongify(self);
        HomeModel *model = dataArr[index.section][index.row];
        HMDetailViewController *detailVC = [[HMDetailViewController alloc] init];
        if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
            detailVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/articleDetail.html?uId=%@&aId=%ld&moduleType=0",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],model.content_id];
        } else {
            detailVC.urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/articleDetail.html?uId=0&aId=%ld&moduleType=0",model.content_id];
        }
        detailVC.aid = [NSNumber numberWithInteger:model.content_id];
        detailVC.titleStr = model.title;
        detailVC.contentHtmlStr = model.content;
        detailVC.urlStr = model.imagePath;
        detailVC.moduleType = 0;
        [self.navigationController pushViewController:detailVC animated:YES];
    };
    
    // 下拉刷新数据请求指令
    self.mainListView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self);
        [self.mainListView.mj_header endRefreshing];
        [self.mainListView.mj_footer endRefreshing];
        [self getHomeMainData];
    }];
    
}

#pragma mark -- 获取数据
- (void)getHomeMainData {
    dispatch_group_t hmMainGroup =   dispatch_group_create();
    @weakify(self);
    NSMutableDictionary *params1 = [[NSMutableDictionary alloc] init];
    params1[@"type"] = [NSNumber numberWithInteger:4];
    dispatch_group_enter(hmMainGroup);
    //获取banner列表
    NSMutableArray *bannerArr = [[NSMutableArray alloc] init];
    [[self.homeVM.getAdByTypeCommand execute:params1] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            AdModel *adModel = [AdModel mj_objectWithKeyValues:x[@"Data"]];
            @weakify(self);
            [adModel.filelist enumerateObjectsUsingBlock:^(FileEntityModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                @strongify(self);
                [bannerArr addObject:obj.path];
                self.bannerArr = bannerArr;
            }];
        }
        dispatch_group_leave(hmMainGroup);
    }];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        NSMutableDictionary *params2 = [[NSMutableDictionary alloc] init];
        params2[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
        dispatch_group_enter(hmMainGroup);
        //获取一家老小盒子使用情况数据
        NSMutableArray *boxListArr = [[NSMutableArray alloc] init];
        NSMutableArray *parkArr = [[NSMutableArray alloc] init];
        [[self.homeVM.GetUserBoxListCommand execute:params2] subscribeNext:^(id  _Nullable x) {
            if (x != nil) {
                NSArray *dataArr = [UserUseLogModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
                @weakify(self);
                [dataArr enumerateObjectsUsingBlock:^(UserUseLogModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    @strongify(self);
                    if (obj.userId == [[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID] integerValue]) {
                        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithInteger:obj.boxId] forKey:PROJECT_BOXID];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                    if (obj.useLogModels.count) {
                        [boxListArr addObject:obj];
                        UseLogModel *model = [obj.useLogModels firstObject];
                        model.boxName = obj.boxName;
                        [parkArr addObject:model];
                    }
                    self.boxListArr = boxListArr;
                    self.parkArr = parkArr;
                }];
            }
            dispatch_group_leave(hmMainGroup);
        }];
    }
    
    NSMutableDictionary *params3 = [[NSMutableDictionary alloc] init];
    dispatch_group_enter(hmMainGroup);
    //获取首页内容数据
    NSMutableArray *parentingArr = [[NSMutableArray alloc] init];
    NSMutableArray *acommpanyArr = [[NSMutableArray alloc] init];
    NSMutableArray *patentalGrowthArr = [[NSMutableArray alloc] init];
    [[self.homeVM.getHomeContentCommand execute:params3] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            NSArray *contentArr = [HomeModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
            @weakify(self);
            [contentArr enumerateObjectsUsingBlock:^(HomeModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                @strongify(self);
                if (obj.section == 1) {
                    [parentingArr addObject:obj];
                } else if (obj.section == 2) {
                    [acommpanyArr addObject:obj];
                } else if (obj.section == 3) {
                    [patentalGrowthArr addObject:obj];
                }
                self.parentingArr = parentingArr;
                self.acommpanyArr = acommpanyArr;
                self.patentalGrowthArr = patentalGrowthArr;
            }];
        }
        dispatch_group_leave(hmMainGroup);
    }];
    
    dispatch_group_notify(hmMainGroup, dispatch_get_main_queue(), ^{
        [self.allContentArr removeAllObjects];
        @strongify(self);
        if (self.parkArr.count > 0) {
            [self.allContentArr addObject:self.parkArr];
        }
        [self.allContentArr addObject:self.parentingArr];
        if (self.acommpanyArr.count > 2) {
            [self.allContentArr addObject:[self.acommpanyArr subarrayWithRange:NSMakeRange(0, 2)]];
        } else {
            [self.allContentArr addObject:self.acommpanyArr];
        }
        [self.allContentArr addObject:self.patentalGrowthArr];
        self.mainHeadView.bannerArr = self.bannerArr;
        self.mainListView.dataArr = self.allContentArr;
        [self.mainListView reloadData];
    });
}

#pragma mark -- 激活独角兽乐园
- (void)scanQRCodeOpenPark {
    self.activityTipView = [[PCActivityTipView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT)];
    [[UIApplication sharedApplication].keyWindow addSubview:self.activityTipView];
    self.activityTipView.backView1.hidden = NO;
    @weakify(self);
    self.activityTipView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0://给自己激活
            {
                [self.activityTipView removeFromSuperview];
                [self openScanQRCodeActionIsOther:NO];
            }
                break;
            case 1://给别人激活
            {
                self.activityTipView.backView1.hidden = YES;
                self.activityTipView.backView2.hidden = NO;
            }
                break;
            case 2://暂不激活
            {
                [self.activityTipView removeFromSuperview];
            }
                break;
            case 3://获取验证码(给别人激活)
            {
                [self getCodeForActivityBoxWithPhone:content1];
            }
                break;
            case 4://立即激活(给别人激活)
            {
                if (![ATYUtils isNumText:self.activityTipView.phoneTextField.text]) {
                    [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码"];
                    return;
                }
                if (self.activityTipView.codeTextField.text.length == 0) {
                    [ATYToast aty_bottomMessageToast:@"请输入验证码"];
                    return;
                }
                [self.activityTipView removeFromSuperview];
                [self openScanQRCodeActionIsOther:YES];
            }
                break;
            case 5://放弃激活(给别人激活)
            {
                [self.activityTipView removeFromSuperview];
            }
                break;
            default:
                break;
        }
    };
}

- (void)openScanQRCodeActionIsOther:(BOOL)isOther {
    if (![XSYTapSound ifCanUseSystemCamera]) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"一家老小”已禁用相机" message:@"请在iPhone的“设置”选项中,允许“一家老小”访问你的相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
        [alertView show];
        
        [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber * _Nullable x) {
            if ([x isEqual:@1]) {
                [ATYUtils openSystemSettingView];
            }
        }];
    } else {
        @weakify(self);
        PCScanQRCodeViewController *scanVC = [[PCScanQRCodeViewController alloc] initWithComplete:^(NSString *serialNumber) {
            NSLog(@"扫描到的二维码为------：%@",serialNumber);
            @strongify(self);
            [self  activityBoxActionStr:serialNumber isOther:isOther];
        }];
        [self.navigationController pushViewController:scanVC animated:YES];
    }
}

#pragma mark -- 激活盒子乐园获取验证码（给别人激活）
- (void)getCodeForActivityBoxWithPhone:(NSString *)phone {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = phone;
    params[@"smsType"] = [NSNumber numberWithInteger:10];
    @weakify(self);
    [[self.loginRegisterVM.getVerificationCodeCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSString *message = x[@"Msg"][@"message"];
        NSNumber *success = x[@"Success"];
        if (message.length > 0) {
            [ATYToast aty_bottomMessageToast:message];
        }
        if ([success boolValue]) {
            self.activityCode = x[@"Data"];
        }
    }];
}

#pragma mark -- 激活盒子乐园
- (void)activityBoxActionStr:(NSString *)guidStr isOther:(BOOL)isOther{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"guidStr"] = guidStr;
    
    if (isOther) {
        params[@"phone"] = self.activityTipView.phoneTextField.text;
        params[@"smsCode"] = self.activityTipView.codeTextField.text;
    }
    
    [[self.personalCenterVM.AppActivityBox execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            NSString *str = x[@"Msg"][@"message"];
            if (str.length > 0) {
                [ATYToast aty_bottomMessageToast:str];
            } else {
                [ATYToast aty_bottomMessageToast:@"激活成功，请在盒子完成登录！"];
            }
            
        }
    }];
}


#pragma mark -- 监听mainListView的偏移量
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]){
        CGPoint offset = [change[NSKeyValueChangeNewKey] CGPointValue];
        self.offsetY = offset.y;
        if (offset.y > 0) {
            self.mainSearchView.backgroundColor = KHEXRGB(0xFFFFFF);
            [self.mainSearchView.searchBtn setBackgroundColor:KHEXRGB(0xF7F7F7)];
            self.mainSearchView.hidden = NO;
        } else if (offset.y == 0) {
            self.mainSearchView.backgroundColor = [UIColor clearColor];
            [self.mainSearchView.searchBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
            self.mainSearchView.hidden = NO;
        } else {
            self.mainSearchView.hidden = YES;
        }
        [self setNeedsStatusBarAppearanceUpdate];
    }
}

#pragma mark - 懒加载
- (HMMainSearchView *)mainSearchView {
    if (!_mainSearchView) {
        _mainSearchView = [[HMMainSearchView alloc] init];
        _mainSearchView.backgroundColor = [UIColor clearColor];
    }
    return _mainSearchView;
}

- (HMMianHeadView *)mainHeadView {
    if (!_mainHeadView) {
        _mainHeadView = [[HMMianHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 185*KHEIGHTSCALE)];
    }
    return _mainHeadView;
}

- (HMMainFooterView *)mainFooterView {
    if (!_mainFooterView) {
        _mainFooterView = [[HMMainFooterView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 58)];
    }
    return _mainFooterView;
}

- (HMMainListView *)mainListView {
    if (!_mainListView) {
        _mainListView = [[HMMainListView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _mainListView;
}

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

- (NSMutableArray *)allContentArr {
    if (!_allContentArr) {
        _allContentArr = [[NSMutableArray alloc] init];
    }
    return _allContentArr;
}

- (NSMutableArray *)bannerArr {
    if (!_bannerArr) {
        _bannerArr = [[NSMutableArray alloc] init];
    }
    return _bannerArr;
}

- (NSMutableArray *)parkArr {
    if (!_parkArr) {
        _parkArr = [[NSMutableArray alloc] init];
    }
    return _parkArr;
}

- (NSMutableArray *)boxListArr {
    if (!_boxListArr) {
        _boxListArr = [[NSMutableArray alloc] init];
    }
    return _boxListArr;
}

- (NSMutableArray *)parentingArr {
    if (!_parentingArr) {
        _parentingArr = [[NSMutableArray alloc] init];
    }
    return _parentingArr;
}

- (NSMutableArray *)acommpanyArr {
    if (!_acommpanyArr) {
        _acommpanyArr = [[NSMutableArray alloc] init];
    }
    return _acommpanyArr;
}

- (NSMutableArray *)patentalGrowthArr {
    if (!_patentalGrowthArr) {
        _patentalGrowthArr = [[NSMutableArray alloc] init];
    }
    return _patentalGrowthArr;
}

- (UIView *)shadowBackView {
    if (!_shadowBackView) {
        _shadowBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT)];
        _shadowBackView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        _shadowBackView.userInteractionEnabled = YES;
    }
    return _shadowBackView;
}

- (RLLoginRegisterViewModel *)loginRegisterVM {
    if (!_loginRegisterVM) {
        _loginRegisterVM = [[RLLoginRegisterViewModel alloc] init];
    }
    return _loginRegisterVM;
}

- (void)dealloc {
    [self.mainListView removeObserver:self forKeyPath:@"contentOffset" context:nil];
    [KNotificationCenter removeObserver:self];
    NSLog(@"控制器HMMainViewController销毁了");
}

@end
