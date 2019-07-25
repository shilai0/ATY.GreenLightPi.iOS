//
//  FCCourseDetailViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCCourseDetailViewController.h"
#import "FCCourseDetailBottomView.h"
#import "FCPurchaseCourseViewController.h"
#import "FcCoursesModel.h"
#import <ZFPlayer/ZFPlayer.h>
#import <ZFPlayer/ZFPlayerControlView.h>
#import <ZFPlayer/ZFAVPlayerManager.h>
#import "FileEntityModel.h"
#import "FamilyCoachViewModel.h"
#import "LSPPageView.h"
#import "LSPTitleStyle.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "WXApiManager.h"
#import "AliPayManager.h"
#import "FCEvaluateViewController.h"
#import "FCCourseItemListView.h"
#import "FCCourseDetailTipView.h"
#import <AVFoundation/AVFoundation.h>
#import <WechatOpenSDK/WXApiObject.h>
#import <WechatOpenSDK/WXApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "TencentApiManager.h"
#import "HMDetailBottomView.h"
#import "HMShareView.h"
#import "GKCover.h"
#import "FCCourseItemListHeadView.h"
#import "WFActivityRequset.h"
#import "ATYAlertViewController.h"
#import "BaseNavigationViewController.h"
#import "RLFirstOpenAppViewController.h"
#import "UIImageView+WebCache.h"


static NSString *kVideoCover = @"https://upload-images.jianshu.io/upload_images/635942-14593722fe3f0695.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240";
 
@interface FCCourseDetailViewController ()<LSPPageViewDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong)FCCourseDetailBottomView *bottomView;
@property (nonatomic, strong) ZFPlayerController *player;
@property (nonatomic, strong) UIImageView *containerView;
@property (nonatomic, strong) ZFPlayerControlView *controlView;
//@property (nonatomic, strong) UIView<ZFPlayerMediaControl> *controlView;
@property (nonatomic, strong) UIButton *playBtn;
@property (nonatomic, strong) FamilyCoachViewModel *familyCoachVM;
@property (nonatomic, strong) NSMutableArray *childVCArr;
@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) FCCourseItemListView *courseItemListView;
@property (nonatomic, strong) UIWebView *detailWebView;
@property (nonatomic, strong) FCCourseDetailTipView *tipView;
@property (nonatomic, strong) FcCoursesModel *model;
@property (nonatomic, strong) FcCoursesDetailModel *playModel;
@property (nonatomic, assign) NSInteger playIndex;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) FCCourseItemListHeadView *itemListHeadView;
@property (nonatomic, strong) UIButton *bottomAddStudyBtn;

@end

@implementation FCCourseDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
    self.isStart = YES;     // 开启网络状况监听
    if (self.player.currentPlayerManager.isPreparedToPlay) {
        [self.player addDeviceOrientationObserver];
        if (self.player.isPauseByEvent) {
            self.player.pauseByEvent = NO;
        }
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.isStart = NO;  // 关闭网络状况监听
    if (self.player.currentPlayerManager.isPreparedToPlay) {
        [self.player removeDeviceOrientationObserver];
        if (self.player.currentPlayerManager.isPlaying) {
            self.player.pauseByEvent = YES;
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = KHEXRGB(0xFFFFFF);
    
    self.navView.hidden = YES;
    
    [self fc_RequestData:0];
    
    [self.view addSubview:self.containerView];
    [self.containerView addSubview:self.playBtn];
    [self.view addSubview:self.returnBtn];
    [self.view addSubview:self.shareBtn];
    [self fc_creatContentView];
    ZFAVPlayerManager *playerManager = [[ZFAVPlayerManager alloc] init];
    //    KSMediaPlayerManager *playerManager = [[KSMediaPlayerManager alloc] init];
//        ZFIJKPlayerManager *playerManager = [[ZFIJKPlayerManager alloc] init];
    /// 播放器相关
    self.player = [ZFPlayerController playerWithPlayerManager:playerManager containerView:self.containerView];
    self.player.controlView = self.controlView;
    __weak typeof(self) weakSelf = self;
    self.player.orientationWillChange = ^(ZFPlayerController * _Nonnull player, BOOL isFullScreen) {
        [weakSelf setNeedsStatusBarAppearanceUpdate];
    };
    
    // 播放完自动播放下一个
    self.player.playerDidToEnd = ^(id  _Nonnull asset) {
        [weakSelf.player playTheNext];
        if (!weakSelf.player.isLastAssetURL) {
            NSString *title = [NSString stringWithFormat:@"视频标题%zd",weakSelf.player.currentPlayIndex];
            [weakSelf.controlView showTitle:title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
        } else {
            [weakSelf.player stop];
        }
    };
    
}

#pragma mark -- 中间详情
- (void)fc_creatContentView {
    NSArray *titleArr = @[@"介绍",@"目录"];
    for (int i = 0; i < titleArr.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        [self fc_loadWebView:vc index:i];
        [self.childVCArr addObject:vc];
    }
    LSPTitleStyle *style = [[LSPTitleStyle alloc] init];
    style.isAverage = YES;
    LSPPageView *pageView = [[LSPPageView alloc] initWithFrame:CGRectMake(0, KSCREEN_WIDTH*9/16, self.view.bounds.size.width, KSCREENH_HEIGHT - KSCREEN_WIDTH*9/16 - KBottomSafeHeight) titles:titleArr style:style childVcs:self.childVCArr.mutableCopy parentVc:self];
    pageView.delegate = self;
    pageView.tag = 2000;
    pageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pageView];
}

- (void)fc_loadWebView:(UIViewController *)VC index:(int)index {
    NSString *urlString = nil;
    CGRect frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KSCREEN_WIDTH*9/16 - KBottomSafeHeight - 44);
    if (index == 0) {
        if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
            urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/famailyVideo.html?coursesId=%@&userId=%@&type=2",self.course_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
        } else {
            urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/famailyVideo.html?coursesId=%@&userId=0&type=2",self.course_id];
        }
        self.detailWebView = [[UIWebView alloc] initWithFrame:frame];
        self.detailWebView.delegate = self;
        [self.detailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        [VC.view addSubview:self.detailWebView];
    } else if (index == 1) {
        self.courseItemListView = [[FCCourseItemListView alloc] initWithFrame:frame style:UITableViewStylePlain];
        self.courseItemListView.tableHeaderView = self.itemListHeadView;
        __weak typeof(self) weakSelf = self;
        self.courseItemListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
            FcCoursesDetailModel *currentDetailModel = [weakSelf.model.consumptionDetails objectAtIndex:indexPath.row];
            if (currentDetailModel.isLock == 0 &&( [weakSelf.model.isPurchase integerValue] == 1 || [weakSelf.model.consumptionType isEqualToString:@"free"])) {
                FcCoursesDetailModel *detailModel = [weakSelf.model.consumptionDetails objectAtIndex:indexPath.row];
                NSTimeInterval timeInterval = [detailModel.duration integerValue]*[detailModel.progress floatValue];
                [weakSelf.player playTheIndex:indexPath.row];
                [weakSelf.player seekToTime:timeInterval completionHandler:nil];
                if (weakSelf.playIndex != indexPath.row) {
                    [weakSelf addRecord];
                }
                weakSelf.playModel = [weakSelf.model.consumptionDetails objectAtIndex:indexPath.row];
                weakSelf.playIndex = indexPath.row;
                [weakSelf.model.consumptionDetails enumerateObjectsUsingBlock:^(FcCoursesDetailModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (idx == indexPath.row) {
                        obj.isCurrentPlay = YES;
                    } else {
                        obj.isCurrentPlay = NO;
                    }
                }];
                [weakSelf.courseItemListView reloadData];
            } else if (currentDetailModel.isLock == 1) {
                
            } else {
                [ATYToast aty_bottomMessageToast:@"付费课程购买之后才可观看"];
            }
        };
        [VC.view addSubview:self.courseItemListView];
    }
}

#pragma mark -- 底部按钮
- (void)fc_creatBottomView {
    if ([self.model.isPurchase integerValue] == 0) {
        if ([self.model.consumptionType isEqualToString:@"free"]) {
            [self.view addSubview:self.bottomAddStudyBtn];
            
            [self.bottomAddStudyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.bottom.equalTo(@(-KBottomSafeHeight));
                make.height.equalTo(@49);
            }];
            
            __weak typeof(self) weakSelf = self;
            [[self.bottomAddStudyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                    [weakSelf addStudy];
                } else {
                    [self loginAction];
                }
            }];
            
            /***版本1.3.1暂时隐藏加入学习的下单入口（后面如果开放，注掉下面这行代码即可）***/
            self.bottomAddStudyBtn.hidden = YES;
            
        } else {
            /***版本1.3.1暂时隐藏加入学习的下单入口（后面如果开放，替换下面btnArr代码即可）***/
//            NSMutableArray *btnArr = [NSMutableArray arrayWithObjects:@{@"imageName":@"fc_wantStudy_normal",@"title":@"想学",@"titleColor":@"0x646464",@"backColor":KHEXRGB(0xFFFFFF)}, @{@"imageName":@"",@"title":@"VIP免费",@"titleColor":@"0x646464",@"backColor":KHEXRGB(0xD9D295)},@{@"imageName":@"fc_addStudy",@"title":@"+加入学习",@"titleColor":@"0xFFFFFF",@"backColor":KHEXRGB(0x44C08C)},nil];
            
            NSMutableArray *btnArr = [NSMutableArray arrayWithObjects:@{@"imageName":@"fc_wantStudy_normal",@"title":@"想学",@"titleColor":@"0x646464",@"backColor":KHEXRGB(0xFFFFFF)}, @{@"imageName":@"",@"title":@"VIP免费",@"titleColor":@"0x646464",@"backColor":KHEXRGB(0xD9D295)},nil];

            self.bottomView = [[FCCourseDetailBottomView alloc] initWithData:btnArr];
            [self.view addSubview:self.bottomView];
            
            [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self.view);
                make.bottom.equalTo(@(-KBottomSafeHeight));
                make.height.equalTo(@49);
            }];
            
            __weak typeof(self) weakSelf = self;
            self.bottomView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
                if (index == 0) {
                    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                        [weakSelf collectOrCancelCollectCourse:content1];
                    } else {
                        [weakSelf loginAction];
                    }
                } else if (index == 1) {
                    [weakSelf.view addSubview:weakSelf.tipView];
                    weakSelf.tipView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
                        [weakSelf.tipView removeFromSuperview];
                    };
                } else if (index == 2) {
                    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                        FCPurchaseCourseViewController *purchaseCourseVC = [[FCPurchaseCourseViewController alloc] init];
                        purchaseCourseVC.coursesModel = weakSelf.model;
                        [WXApiManager sharedManager].model = weakSelf.model;
                        [AliPayManager sharedManager].model = weakSelf.model;
                        [weakSelf.navigationController pushViewController:purchaseCourseVC animated:YES];              } else {
                            [weakSelf loginAction];
                    }
                }
            };
        }
        
        LSPPageView *pageView = [self.view viewWithTag:2000];
        CGRect temp = pageView.frame;
        temp.size.height = (KSCREENH_HEIGHT - KSCREEN_WIDTH*9/16 - KBottomSafeHeight - 49);
        pageView.frame = temp;
        
        CGRect detailTemp = self.detailWebView.frame;
        detailTemp.size.height = (KSCREENH_HEIGHT - KSCREEN_WIDTH*9/16 - KBottomSafeHeight - 49 - 44);
        self.detailWebView.frame = detailTemp;
        
        CGRect listTemp = self.courseItemListView.frame;
        listTemp.size.height = (KSCREENH_HEIGHT - KSCREEN_WIDTH*9/16 - KBottomSafeHeight - 49 - 44);
        self.courseItemListView.frame = listTemp;
        
    }
}

#pragma mark -- 加入学习
- (void)addStudy {
    NSMutableDictionary *orderParams = [[NSMutableDictionary alloc] init];
    orderParams[@"user_id"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    orderParams[@"courses_id"] = self.model.courses_id;
    orderParams[@"price"] = self.model.price;
    orderParams[@"integral"] = self.model.integral;
    orderParams[@"order_no"] = @"";
    orderParams[@"consumptionType"] = [NSNumber numberWithInteger:3];
    orderParams[@"payTypeEnum"] = [NSNumber numberWithInteger:3];
    orderParams[@"body"] = self.model.title;
    orderParams[@"subject"] = @"一家老小_购买课程";
    orderParams[@"orderSources"] = @2;
    __weak typeof(self) weakSelf = self;
    [[self.familyCoachVM.PlaceAnOrderCommand execute:orderParams] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            [ATYToast aty_bottomMessageToast:@"加入学习成功"];
            if ([weakSelf.model.consumptionType isEqualToString:@"free"]) {
                weakSelf.bottomAddStudyBtn.hidden = YES;
            } else {
                weakSelf.bottomView.hidden = YES;
            }
        }
    }];
}

#pragma mark -- 收藏/取消收藏课程
- (void)collectOrCancelCollectCourse:(NSString *)selected {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"coursesId"] = self.model.courses_id;
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    if ([selected isEqualToString:@"1"]) {
        [[self.familyCoachVM.CollecCourseCommand execute:params] subscribeNext:^(id  _Nullable x) {
            if (x != nil) {
                [ATYToast aty_bottomMessageToast:@"课程收藏成功"];
            }
        }];
    } else {
        [[self.familyCoachVM.CancelCollecCourseCommand execute:params] subscribeNext:^(id  _Nullable x) {
            if (x != nil) {
                [ATYToast aty_bottomMessageToast:@"取消收藏成功"];
            }
        }];
    }
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = CGRectGetWidth(self.view.frame);
    CGFloat h = w*9/16;
    self.containerView.frame = CGRectMake(x, y, w, h);
    
    w = 44;
    h = w;
    x = (CGRectGetWidth(self.containerView.frame)-w)/2;
    y = (CGRectGetHeight(self.containerView.frame)-h)/2;
    self.playBtn.frame = CGRectMake(x, y, w, h);
    
    w = 24;
    h = w;
    x = 16;
    y = 31;
    self.returnBtn.frame = CGRectMake(x, y, w, h);
    
    w = 24;
    h = w;
    x = CGRectGetWidth(self.containerView.frame)- w - 24;
    y = 31;
    self.shareBtn.frame = CGRectMake(x, y, w, h);
}

- (void)changeVideo:(UIButton *)sender {
    NSString *URLString = @"https://ylmtst.yejingying.com/asset/video/20180525184959_mW8WVQVd.mp4";
    self.player.assetURL = [NSURL URLWithString:URLString];
    [self.controlView showTitle:@"抖音" coverURLString:kVideoCover fullScreenMode:ZFFullScreenModePortrait];
}

- (void)playClick:(UIButton *)sender {
    [self.player playTheIndex:0];
    self.playModel = [self.model.consumptionDetails firstObject];
    self.playIndex = 0;
}

- (void)returnClick:(UIButton *)sender {
    [self.player stop];
    [self.navigationController popViewControllerAnimated:YES];
    [self addRecord];
}

#pragma mark -- 分享
- (void)shareClick:(UIButton *)sender {
    [self fcCourse_showShareView];
}

#pragma mark -- 添加阅读记录
- (void)addRecord {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        NSString *strTime = self.controlView.landScapeControlView.currentTimeLabel.text;
        NSArray *array = [strTime componentsSeparatedByString:@":"]; //从字符A中分隔成2个元素的数组
        NSString *MM= array[0];
        NSString *ss = array[1];
        NSInteger m = [MM integerValue];
        NSInteger s = [ss integerValue];
        NSInteger zonghms = m*60 + s;
        if (zonghms > 30) {
            NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
            params[@"coursesId"] = self.model.courses_id;
            params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
            params[@"often"] = [NSNumber numberWithInteger:zonghms];
            params[@"coursesDetailId"] = self.playModel.coursesDetail_id;
            
            [[self.familyCoachVM.AddFcWatchRecordCommand execute:params] subscribeNext:^(id  _Nullable x) {
                if (x != nil) {
                    
                }
            }];
        }
    }
}

- (void)nextClick:(UIButton *)sender {
    [self.player playTheNext];
    if (!self.player.isLastAssetURL) {
        NSString *title = [NSString stringWithFormat:@"视频标题%zd",self.player.currentPlayIndex];
        [self.controlView showTitle:title coverURLString:kVideoCover fullScreenMode:ZFFullScreenModeLandscape];
    } else {
        NSLog(@"最后一个视频了");
    }
    [self fc_RequestData:self.player.currentPlayIndex];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.player.isFullScreen) {
        return UIStatusBarStyleLightContent;
    }
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return self.player.isStatusBarHidden;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationSlide;
}

- (BOOL)shouldAutorotate {
    return self.player.shouldAutorotate;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if (self.player.isFullScreen) {
        return UIInterfaceOrientationMaskLandscape;
    }
    return UIInterfaceOrientationMaskPortrait;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

#pragma mark -- RequestData
- (void)fc_RequestData:(NSInteger)playIndex {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"coursesId"] = self.course_id;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    } else {
        params[@"userId"] = [NSNumber numberWithInteger:0];
    }
    __weak typeof(self) weakSelf = self;
    [[self.familyCoachVM.GetCoursesForIdCommand execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            weakSelf.model = [FcCoursesModel mj_objectWithKeyValues:x[@"Data"]];
            weakSelf.itemListHeadView.titleStr = weakSelf.model.title;
            [weakSelf.model.consumptionDetails enumerateObjectsUsingBlock:^(FcCoursesDetailModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [weakSelf.assetURLs addObject:[NSURL URLWithString:[obj.file.path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
                if (idx == playIndex) {
                    obj.isCurrentPlay = YES;
                } else {
                    obj.isCurrentPlay = NO;
                }
            }];
            weakSelf.player.assetURLs = weakSelf.assetURLs;
           [weakSelf.containerView sd_setImageWithURL:[NSURL URLWithString:self.coverImageStr]];
            weakSelf.courseItemListView.dataArr = [weakSelf.model.consumptionDetails mutableCopy];
            weakSelf.courseItemListView.courseModel = weakSelf.model;
            [weakSelf.courseItemListView reloadData];
            [weakSelf fc_creatBottomView];
        }
    }];
}

#pragma mark - LSPPageViewDelegate
- (void)pageViewScollEndView:(LSPPageView *)pageView WithIndex:(NSInteger)index
{
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    WFActivityRequset *requset = [[WFActivityRequset alloc] init];
    context[@"AndroidWebView"] = requset;
    
    __weak typeof(self) weakSelf = self;
    requset.fuctionBlock = ^(NSString *fuctionName) {
        if ([fuctionName isEqualToString:@"writeComment"]) {
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                if ([weakSelf.model.isScore integerValue] == 1) {
                    [ATYToast aty_bottomMessageToast:@"不可重复评分"];
                    return ;
                }
                if ([weakSelf.model.isPurchase integerValue] == 0) {
                    [ATYToast aty_bottomMessageToast:@"未订阅课程不可评分"];
                    return ;
                }
                FCEvaluateViewController *evaluateVC = [[FCEvaluateViewController alloc] init];
                evaluateVC.coursesModel = weakSelf.model;
                UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:evaluateVC];
                evaluateVC.evaluateBlock = ^{
                    UIViewController *vc = (UIViewController *)weakSelf.childVCArr[2];
                    [weakSelf fc_loadWebView:vc index:2];
                };
                [weakSelf presentViewController:navController animated:YES completion:nil];
            } else {
//                [self gologinStr:@"需要登录才能进行评论哦"];
                [self loginAction];
                [self loginAction];
            }
            
        }
    };
    
}

#pragma mark --
- (void)fcCourse_showShareView {
    __block UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KBottomSafeHeight);
    view.backgroundColor = [UIColor clearColor];
    view.userInteractionEnabled = YES;
    [self.view addSubview:view];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 168)];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(23, 25, 18, 20);
    layout.minimumLineSpacing = 0;//竖向
    layout.minimumInteritemSpacing = 20;//横向间距
    layout.itemSize = CGSizeMake(55,78);
    HMShareView *shareView = [[HMShareView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 118) collectionViewLayout:layout];
    if ([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled]) {
        shareView.dataArr = @[@{@"image":@"WeChat",@"title":@"微信"},@{@"image":@"CircleOfFriends",@"title":@"朋友圈"},@{@"image":@"share_qq",@"title":@"QQ"},@{@"image":@"CopyLink",@"title":@"复制链接"}];
    } else if (![QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled]) {
        shareView.dataArr = @[@{@"image":@"WeChat",@"title":@"微信"},@{@"image":@"CircleOfFriends",@"title":@"朋友圈"},@{@"image":@"CopyLink",@"title":@"复制链接"}];
    } else if ([QQApiInterface isQQInstalled] && ![WXApi isWXAppInstalled]) {
        shareView.dataArr = @[@{@"image":@"share_qq",@"title":@"QQ"},@{@"image":@"CopyLink",@"title":@"复制链接"}];
    } else if (![QQApiInterface isQQInstalled] && ![WXApi isWXAppInstalled]) {
        shareView.dataArr = @[@{@"image":@"CopyLink",@"title":@"复制链接"}];
    }
    
    self.bottomButton.frame = CGRectMake(0, CGRectGetMaxY(shareView.frame), KSCREEN_WIDTH, 50);
    [bottomView addSubview:shareView];
    [bottomView addSubview:self.bottomButton];
    [GKCover coverFrom:view
           contentView:bottomView
                 style:GKCoverStyleTranslucent
             showStyle:GKCoverShowStyleBottom
         showAnimStyle:GKCoverShowAnimStyleTop
         hideAnimStyle:GKCoverHideAnimStyleTop
              notClick:NO
             showBlock:nil
             hideBlock:^{
                 [view removeFromSuperview];
                 view = nil;
             }];
    
    [[self.bottomButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [GKCover hideCover];
    }];
    
    __weak typeof(self) weakSelf = self;

    shareView.clickCellBlock = ^(NSArray *dataArr, NSIndexPath *indexPath) {
        if (([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 0) || (![QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 0)) {//分享到微信
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.scene = WXSceneSession;// 分享到会话
            WXMediaMessage *medMessage = [WXMediaMessage message];
            WXWebpageObject *webPageObj = [WXWebpageObject object];
            medMessage.title = weakSelf.model.title; // 标题
            medMessage.description = weakSelf.model.content;// 描述
            UIImage *thumbImage = [weakSelf compressImage:[weakSelf getImageFromURL:weakSelf.model.image.path] toByte:32768];
            [medMessage setThumbImage:thumbImage];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyVideoShare.html?coursesId=%@&userId=%@",weakSelf.course_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
            } else {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyVideoShare.html?coursesId=%@&userId=0",weakSelf.course_id];
            }
            medMessage.mediaObject = webPageObj;
            req.message = medMessage;
            [WXApi sendReq:req];
        } else if (([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 1) || (![QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 1)) {//分享到朋友圈
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.scene = WXSceneTimeline;// 分享到朋友圈
            WXMediaMessage *medMessage = [WXMediaMessage message];
            WXWebpageObject *webPageObj = [WXWebpageObject object];
            medMessage.title = weakSelf.model.title; // 标题
            medMessage.description = weakSelf.model.content;// 描述
            UIImage *thumbImage = [weakSelf compressImage:[weakSelf getImageFromURL:weakSelf.model.image.path] toByte:32768];
            [medMessage setThumbImage:thumbImage];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyVideoShare.html?coursesId=%@&userId=%@",weakSelf.course_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
            } else {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyVideoShare.html?coursesId=%@&userId=0",weakSelf.course_id];
            }
            medMessage.mediaObject = webPageObj;
            req.message = medMessage;
            [WXApi sendReq:req];
        } else if (([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 2) || ([QQApiInterface isQQInstalled] && ![WXApi isWXAppInstalled] && indexPath.item == 0)) {//分享到qq
            NSString *utf8String = nil;
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                utf8String = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyVideoShare.html?coursesId=%@&userId=%@",weakSelf.course_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
            } else {
                utf8String = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyVideoShare.html?coursesId=%@&userId=0",weakSelf.course_id];
            }
            NSString *title = weakSelf.model.title; // 标题
            NSString *description = weakSelf.model.content;// 描述
            NSString *previewImageUrl = weakSelf.model.image.path;
            QQApiNewsObject *newsObj = [QQApiNewsObject
                                        objectWithURL:[NSURL URLWithString:utf8String]
                                        title:title
                                        description:description
                                        previewImageURL:[NSURL URLWithString:previewImageUrl]];
            SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:newsObj];
            //将内容分享到qq
            [QQApiInterface sendReq:req];
        } else if (([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 3) || (![QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 2) || ([QQApiInterface isQQInstalled] && ![WXApi isWXAppInstalled] && indexPath.item == 1) || (![QQApiInterface isQQInstalled] && ![WXApi isWXAppInstalled] && indexPath.item == 0)) {//复制链接
            UIPasteboard *pab = [UIPasteboard generalPasteboard];
            NSString *string = nil;
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                string = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyVideoShare.html?coursesId=%@&userId=%@",weakSelf.course_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
            } else {
                string = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyVideoShare.html?coursesId=%@&userId=0",weakSelf.course_id];
            }
            [pab setString:string];
            if (pab == nil) {
                [ATYToast aty_bottomMessageToast:@"复制失败"];
            }else
            {
                [ATYToast aty_bottomMessageToast:@"复制成功"];
            }
            
        }
    };
}

#pragma mark - 压缩图片

-(UIImage *) getImageFromURL:(NSString *)fileURL

{
    
    UIImage * result;
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    
    result = [UIImage imageWithData:data];
    
    return result;
    
}

- (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}


- (FCCourseItemListHeadView *)itemListHeadView {
    if (!_itemListHeadView) {
        _itemListHeadView = [[FCCourseItemListHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 60)];
    }
    return _itemListHeadView;
}

- (UIButton *)bottomAddStudyBtn {
    if (!_bottomAddStudyBtn) {
        _bottomAddStudyBtn = [[UIButton alloc] init];
        [_bottomAddStudyBtn setTitle:@"+加入学习" forState:UIControlStateNormal];
        [_bottomAddStudyBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_bottomAddStudyBtn setBackgroundColor:KHEXRGB(0x44C08C)];
    }
    return _bottomAddStudyBtn;
}

- (UIButton *)bottomButton {
    if (!_bottomButton) {
        _bottomButton = [[UIButton alloc] init];
        [_bottomButton setBackgroundColor:KHEXRGB(0xFFFFFF)];
        [_bottomButton setTitle:@"取消" forState:UIControlStateNormal];
        [_bottomButton setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        _bottomButton.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _bottomButton;
}

- (FCCourseDetailTipView *)tipView {
    if (!_tipView) {
        _tipView = [[FCCourseDetailTipView alloc] initWithFrame:self.view.bounds];
    }
    return _tipView;
}

- (NSMutableArray *)childVCArr {
    if (!_childVCArr) {
        _childVCArr = [[NSMutableArray alloc] init];
    }
    return _childVCArr;
}

- (FamilyCoachViewModel *)familyCoachVM {
    if (!_familyCoachVM) {
        _familyCoachVM = [[FamilyCoachViewModel alloc] init];
    }
    return _familyCoachVM;
}

- (NSMutableArray *)assetURLs {
    if (!_assetURLs) {
        _assetURLs = [[NSMutableArray alloc] init];
    }
    return _assetURLs;
}

- (ZFPlayerControlView *)controlView {
    if (!_controlView) {
        _controlView = [ZFPlayerControlView new];
    }
    return _controlView;
}

- (UIImageView *)containerView {
    if (!_containerView) {
        _containerView = [UIImageView new];
        _containerView.userInteractionEnabled = YES;
        _containerView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _containerView;
}

- (UIButton *)playBtn {
    if (!_playBtn) {
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playBtn setImage:[UIImage imageNamed:@"new_allPlay_44x44_.png"] forState:UIControlStateNormal];
        [_playBtn addTarget:self action:@selector(playClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _playBtn;
}

- (UIButton *)returnBtn {
    if (!_returnBtn) {
        _returnBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_returnBtn setImage:[UIImage imageNamed:@"fc_return"] forState:UIControlStateNormal];
        [_returnBtn addTarget:self action:@selector(returnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _returnBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"more"] forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}


-(void)dealloc {
    [KNotificationCenter removeObserver:self];
}

@end
