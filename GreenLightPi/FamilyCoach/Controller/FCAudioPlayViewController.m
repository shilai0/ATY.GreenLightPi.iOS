//
//  FCAudioPlayViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/20.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCAudioPlayViewController.h"
#import "DFPlayer.h"
#import "YourDataModel.h"
#import "DFMacro.h"
#import "NSObject+Alert.h"
#import "UIImage+Blur.h"
#import "FcCoursesModel.h"
#import "FileEntityModel.h"
#import "FCAudioPlayView.h"
#import "FCAudioPlayBottomView.h"
#import "FCAudioEvaluateViewController.h"
#import "FCPurchaseCourseViewController.h"
#import "WXApiManager.h"
#import "AliPayManager.h"
#import "FamilyCoachViewModel.h"
#import "FCSelectItemView.h"
#import "GKCover.h"
#import "HMShareView.h"
#import "HMShareFooterView.h"
#import <WechatOpenSDK/WXApiObject.h>
#import <WechatOpenSDK/WXApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "HMDetailBottomView.h"
#import "UserModel.h"
#import "ATYAlertViewController.h"
#import "RLFirstOpenAppViewController.h"
#import "BaseNavigationViewController.h"
#import "FCManuscriptView.h"

// 引入 JPush 功能所需头文件
#import "JPUSHService.h"
// iOS10 注册 APNs 所需头文件
#import <UserNotifications/UserNotifications.h>

static NSInteger seq = 0;


static NSString *cellId = @"cellId";
#define topH SCREEN_HEIGHT - self.tabBarController.tabBar.frame.size.height-CountHeight(200) - 100

@interface FCAudioPlayViewController ()<DFPlayerDelegate,DFPlayerDataSource,UIGestureRecognizerDelegate>
@property (nonatomic, strong) FCAudioPlayView *audioPlayView;
@property (nonatomic, strong) FCAudioPlayBottomView *audioPlayBottomView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *df_ModelArray;
@property (nonatomic, assign) BOOL stopUpdate;
@property (nonatomic, strong) FamilyCoachViewModel *familyCoachVM;
@property (nonatomic, strong) FCSelectItemView *selectItemView;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) HMDetailBottomView *bottomView;
@property (nonatomic, strong) FCManuscriptView *manuscriptView;
/**
 非wifi网络下是否可以播放
 */
@property (nonatomic, assign) BOOL isCanPlay;

@end

@implementation FCAudioPlayViewController

- (HMDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[HMDetailBottomView alloc] init];
    }
    return _bottomView;
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

- (FCSelectItemView *)selectItemView {
    if (!_selectItemView) {
        _selectItemView = [[FCSelectItemView alloc] initWithFrame:self.view.bounds];
    }
    return _selectItemView;
}

- (FamilyCoachViewModel *)familyCoachVM {
    if (!_familyCoachVM) {
        _familyCoachVM = [[FamilyCoachViewModel alloc] init];
    }
    return _familyCoachVM;
}

- (void)dealloc {
    [[DFPlayer shareInstance] df_audioPause];
    [KNotificationCenter removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isCanPlay = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate) name:UIApplicationWillTerminateNotification object:nil];
    
    [self initBackGroundView];
    [self initDFPlayer];
    if (self.df_ModelArray.count > _index) {
        DFPlayerModel *model = self.df_ModelArray[_index];
        [[DFPlayer shareInstance] df_playerPlayWithAudioId:model.audioId];
    }
}

#pragma mark - UI
- (void)initBackGroundView{
    self.audioPlayView = [[FCAudioPlayView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - 50 - KBottomSafeHeight)];
    self.audioPlayView.coursesModel = self.coursesModel;
    self.audioPlayView.index = self.index;
    [self.view addSubview:self.audioPlayView];
    
    self.audioPlayBottomView = [[FCAudioPlayBottomView alloc] initWithFrame:CGRectMake(0, KSCREENH_HEIGHT - 50 - KBottomSafeHeight, KSCREEN_WIDTH, 50)];
    self.audioPlayBottomView.model = self.coursesModel;
    self.audioPlayBottomView.index = self.index;
    [self.view addSubview:self.audioPlayBottomView];
    
    @weakify(self);
    self.audioPlayView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        if (index == 0) {//返回
            [self dismissViewControllerAnimated:YES completion:nil];
            [self addRecord];
        } else if (index == 1) {//进入作者详情页
        }
    };
    
    self.audioPlayBottomView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 1://列表
            {
                [self.view addSubview:self.selectItemView];
                self.selectItemView.model = self.coursesModel;
                @weakify(self);
                self.selectItemView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
                    @strongify(self);
                    if (index == 0 && [content1 isEqualToString:@"cancel"]) {
                        [self.selectItemView removeFromSuperview];
                    } else {
                        FcCoursesDetailModel *currentDetailModel = [self.coursesModel.consumptionDetails objectAtIndex:index];
                        if (currentDetailModel.isLock == 0 && ([self.coursesModel.isPurchase integerValue] == 1 || [self.coursesModel.consumptionType isEqualToString:@"free"])) {
                            [self.selectItemView removeFromSuperview];
                            DFPlayerModel *model = self.df_ModelArray[index];
                            [[DFPlayer shareInstance] df_playerPlayWithAudioId:model.audioId];
                            self.audioPlayBottomView.index = index;
                            self.audioPlayView.index = index;
                        } else if (currentDetailModel.isLock == 1) {
                            [ATYToast aty_bottomMessageToast:@"课程暂未开放，敬请期待"];
                        } else {
                            [ATYToast aty_bottomMessageToast:@"付费音频购买后才可收听"];
                        }
                        
                    }
                };
            }
                break;
            case 2://文稿
            {
                FcCoursesDetailModel *currentDetailModel = [self.coursesModel.consumptionDetails objectAtIndex:self.audioPlayBottomView.index];
                self.manuscriptView = [[FCManuscriptView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT)];
                self.manuscriptView.urlStr = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/mp3Detail.html?id=%@",currentDetailModel.coursesDetail_id];
//                self.manuscriptView.urlStr = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/mp3Detail.html?id=1085"];

                [self.view addSubview:self.manuscriptView];
                
                @weakify(self);
                self.manuscriptView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
                    @strongify(self);
                    switch (index) {
                        case 0:
                            [self.manuscriptView removeFromSuperview];
                            self.manuscriptView = nil;
                            break;
                        case 1:
                        {
                            [self fc_showShareView:[NSString stringWithFormat:@"http://business.aiteyou.net/h5/mp3Detail.html?id=%@",currentDetailModel.coursesDetail_id] isDetailManuscript:YES];
                        }
                            break;
                        default:
                            break;
                    }
                };
                
                
//                if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
//                    if ([self.coursesModel.isPurchase integerValue] == 0 && [self.coursesModel.consumptionType isEqualToString:@"free"]) {
//                        [self addStudy];
//                    } else if ([self.coursesModel.isPurchase integerValue] == 0 && ![self.coursesModel.consumptionType isEqualToString:@"free"]) {
//                        FCPurchaseCourseViewController *purchaseCourseVC = [[FCPurchaseCourseViewController alloc] init];
//                        purchaseCourseVC.coursesModel = self.coursesModel;
//                        [WXApiManager sharedManager].model = self.coursesModel;
//                        [AliPayManager sharedManager].model = self.coursesModel;
//                        [self.navigationController pushViewController:purchaseCourseVC animated:YES];
//                    } else {
//                        [ATYToast aty_bottomMessageToast:@"您已订阅该专辑"];
//                    }
//                } else {
////                    [self gologinStr:@"需要登录才能订阅课程哦"];
//                    [self loginAction];
//                }
                
            }
                break;
            case 3://分享
            {
                if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                    [self fc_showShareView:[NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=%@",self.coursesModel.courses_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]] isDetailManuscript:NO];
                } else {
                    [self fc_showShareView:[NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=0",self.coursesModel.courses_id] isDetailManuscript:NO];
                }
            }
                break;
            default:
                break;
        }
    };
}

#pragma mark -- 添加阅读记录
- (void)addRecord {
    CGFloat strTime = [DFPlayer shareInstance].currentTime;
    if (strTime > 30 && [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        params[@"coursesId"] = self.coursesModel.courses_id;
        params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
        params[@"often"] = [NSNumber numberWithFloat:strTime];
        FcCoursesDetailModel *detailModel = self.coursesModel.consumptionDetails[_index];
        params[@"coursesDetailId"] = detailModel.coursesDetail_id;

        [[self.familyCoachVM.AddFcWatchRecordCommand execute:params] subscribeNext:^(id  _Nullable x) {
            if (x != nil) {

            }
        }];
    }
}

#pragma mark - 初始化DFPlayer
- (void)initDFPlayer{
    [[DFPlayer shareInstance] df_initPlayerWithUserId:nil];
    [DFPlayer shareInstance].dataSource  = self;
    [DFPlayer shareInstance].delegate    = self;
    [DFPlayer shareInstance].category    = DFPlayerAudioSessionCategoryPlayback;
    [DFPlayer shareInstance].isObserveWWAN = YES;
    [DFPlayer shareInstance].isNeedCache = NO;

    [[DFPlayer shareInstance] df_reloadData];//须在传入数据源后调用（类似UITableView的reloadData）
    CGRect buffRect = CGRectMake(CountWidth(50), topH-CountHeight(12), CountWidth(655), CountHeight(4));
    CGRect proRect  = CGRectMake(CountWidth(50), topH-CountHeight(30), CountWidth(655), CountHeight(40));
    CGRect currRect = CGRectMake(CountWidth(10), topH+CountHeight(8), CountWidth(90), CountHeight(40));
    CGRect totaRect = CGRectMake(SCREEN_WIDTH-CountWidth(100), topH+CountHeight(8), CountWidth(90), CountHeight(40));
    CGRect playRect = CGRectMake(CountWidth(317), topH+CountHeight(70), CountWidth(114), CountHeight(114));
    CGRect nextRext = CGRectMake(CountWidth(500), topH+CountHeight(110), CountWidth(48), CountHeight(48));
    CGRect lastRect = CGRectMake(CountWidth(200), topH+CountHeight(110), CountWidth(48), CountHeight(48));
    
    DFPlayerControlManager *manager = [DFPlayerControlManager shareInstance];
    //缓冲条
    [manager df_bufferProgressViewWithFrame:buffRect trackTintColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.5] progressTintColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.5] superView:self.audioPlayView];
    //进度条
    [manager df_sliderWithFrame:proRect minimumTrackTintColor:HDFGreenColor maximumTrackTintColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.0] trackHeight:CountHeight(4) thumbSize:(CGSizeMake(CountWidth(50), CountWidth(50))) superView:self.audioPlayView];
    //当前时间
    UILabel *curLabel = [manager df_currentTimeLabelWithFrame:currRect superView:self.audioPlayView];
    curLabel.textColor = KHEXRGB(0x44C08C);
    //总时间
    UILabel *totLabel = [manager df_totalTimeLabelWithFrame:totaRect superView:self.audioPlayView];
    totLabel.textColor = KHEXRGB(0x44C08C);
    
    @weakify(self);
    //播放暂停按钮
    [manager df_playPauseBtnWithFrame:playRect superView:self.audioPlayView block:^{
        @strongify(self);
        @weakify(self);
        if (!self.isCanPlay) {
            [self showAlertWithTitle:@"非wifi网络环境" message:@"继续播放将产生流量费用" viewController:self noBlock:^{
                @strongify(self);
                self.isCanPlay = NO;
                manager.isSetNotPlay = YES;
            } yseBlock:^{
                @strongify(self);
                [DFPlayer shareInstance].isObserveWWAN = NO;
                DFPlayerModel *model = self.df_ModelArray[self.index];
                [[DFPlayer shareInstance] df_playerPlayWithAudioId:model.audioId];
                self.isCanPlay = YES;
                manager.isSetNotPlay = NO;
            }];
        }
    }];
    
    //下一首按钮
    [manager df_nextAudioBtnWithFrame:nextRext superView:self.audioPlayView block:^{
        @strongify(self);
        self.audioPlayBottomView.index = (self.audioPlayBottomView.index + 1) == self.coursesModel.consumptionDetails.count ? 0 : self.audioPlayBottomView.index + 1;
        self.audioPlayView.index = self.audioPlayBottomView.index;
    }];
    //上一首按钮
    [manager df_lastAudioBtnWithFrame:lastRect superView:self.audioPlayView block:^{
        @strongify(self);
        self.audioPlayBottomView.index = self.audioPlayBottomView.index == 0 ? self.coursesModel.consumptionDetails.count - 1 : self.audioPlayBottomView.index - 1;
        self.audioPlayView.index = self.audioPlayBottomView.index;
    }];
    
    [[DFPlayer shareInstance] df_setPlayerWithPreviousAudioModel];
    
}

#pragma mark - DFPLayer dataSource
- (NSArray<DFPlayerModel *> *)df_playerModelArray{
    if (_df_ModelArray.count == 0) {
        _df_ModelArray = [NSMutableArray array];
    }else{
        [_df_ModelArray removeAllObjects];
    }
    for (int i = 0; i < self.dataArray.count; i++) {
        YourDataModel *yourModel    = self.dataArray[i];
        DFPlayerModel *model        = [[DFPlayerModel alloc] init];
        model.audioId               = i;//****重要。AudioId从0开始，仅标识当前音频在数组中的位置。
        if ([yourModel.yourUrl hasPrefix:@"http"]) {//网络音频
            model.audioUrl = [self translateIllegalCharacterWtihUrlStr:yourModel.yourUrl];
        }else{//本地音频
            NSString *path = [[NSBundle mainBundle] pathForResource:yourModel.yourUrl ofType:@""];
            if (path) {model.audioUrl = [NSURL fileURLWithPath:path];}
        }
        [_df_ModelArray addObject:model];
    }
    return self.df_ModelArray;
}

- (DFPlayerInfoModel *)df_playerAudioInfoModel:(DFPlayer *)player{
    YourDataModel *yourModel        = self.dataArray[player.currentAudioModel.audioId];
    DFPlayerInfoModel *infoModel    = [[DFPlayerInfoModel alloc] init];
    //音频名 歌手 专辑名
    infoModel.audioName     = yourModel.yourName;
    infoModel.audioSinger   = yourModel.yourSinger;
    infoModel.audioAlbum    = yourModel.yourAlbum;
    //歌词
    NSString *lyricPath     = [[NSBundle mainBundle] pathForResource:yourModel.yourLyric ofType:nil];
    infoModel.audioLyric    = [NSString stringWithContentsOfFile:lyricPath encoding:NSUTF8StringEncoding error:nil];
    //配图
    NSURL *imageUrl         = [NSURL URLWithString:yourModel.yourImage];
    NSData *imageData       = [NSData dataWithContentsOfURL:imageUrl];
    infoModel.audioImage    = [UIImage imageWithData: imageData];
    return infoModel;
}

#pragma mark - DFPlayer delegate
//加入播放队列
- (void)df_playerAudioWillAddToPlayQueue:(DFPlayer *)player{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *audioImage = player.currentAudioInfoModel.audioImage;
        if (audioImage) {
            CGFloat imgW = audioImage.size.height*SCREEN_WIDTH/SCREEN_HEIGHT;
            CGRect imgRect = CGRectMake((audioImage.size.width-imgW)/2, 0, imgW, audioImage.size.height);
            audioImage = [audioImage getSubImage:imgRect];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *audioName = player.currentAudioInfoModel.audioName;
            self.navigationItem.title = [NSString stringWithFormat:@"当前音频：%@",audioName];
//            self.backgroundImageView.image = audioImage;
        });
    });
}

//状态信息代理
- (void)df_player:(DFPlayer *)player didGetStatusCode:(DFPlayerStatusCode)statusCode{
    if (statusCode == 0) {
        [self showAlertWithTitle:@"没有网络连接，请检查网络设置" message:nil yesBlock:nil viewController:self];
    }else if(statusCode == 1){
        @weakify(self);
        [self showAlertWithTitle:@"非wifi网络环境" message:@"继续播放将产生流量费用" viewController:self noBlock:^{
            @strongify(self);
            self.isCanPlay = NO;
            [DFPlayerControlManager shareInstance].isSetNotPlay = YES;
        } yseBlock:^{
            @strongify(self);
            [DFPlayer shareInstance].isObserveWWAN = NO;
            [[DFPlayer shareInstance] df_playerPlayWithAudioId:player.currentAudioModel.audioId];
            self.isCanPlay = YES;
            [DFPlayerControlManager shareInstance].isSetNotPlay = NO;
        }];
        return;
    }else if(statusCode == 2){
        [self showAlertWithTitle:@"请求超时" message:nil yesBlock:nil viewController:self];
    }else if(statusCode == 8){
        return;
    }
}

#pragma mark - 从plist中加载音频数据
- (NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        for (int tag = 0; tag < 1; tag++) {
            for (int i = 0; i < self.coursesModel.consumptionDetails.count; i++) {
                FcCoursesDetailModel *detailModel = self.coursesModel.consumptionDetails[i];
                YourDataModel *model = [self setDataModelWithDic:detailModel];
                [_dataArray addObject:model];
            }
        }
    }
    return _dataArray;
}

- (YourDataModel *)setDataModelWithDic:(FcCoursesDetailModel *)detailModel {
    YourDataModel *model = [[YourDataModel alloc] init];
    model.yourUrl = detailModel.file.path;
    return model;
}

- (void)stopResumeBtnAction{
    if (self.stopUpdate) {
        [[DFPlayerControlManager shareInstance] df_playerLyricTableviewResumeUpdate];
        self.stopUpdate = NO;
    }else{
        [[DFPlayerControlManager shareInstance] df_playerLyricTableviewStopUpdate];
        self.stopUpdate = YES;
    }
}

- (NSURL *)translateIllegalCharacterWtihUrlStr:(NSString *)yourUrl{
    //如果链接中存在中文或某些特殊字符，需要通过以下代码转译
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)yourUrl, (CFStringRef)@"!NULL,'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
    //    NSString *encodedString = [yourUrl stringByAddingPercentEncodingWithAllowedCharacters:charactSet];
    return [NSURL URLWithString:encodedString];
}

- (void)applicationWillTerminate{
    [[DFPlayer shareInstance] df_setPreviousAudioModel];
}

#pragma mark -- 加入学习
- (void)addStudy {
    NSMutableDictionary *orderParams = [[NSMutableDictionary alloc] init];
    orderParams[@"user_id"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    orderParams[@"courses_id"] = self.coursesModel.courses_id;
    orderParams[@"price"] = self.coursesModel.price;
    orderParams[@"integral"] = self.coursesModel.integral;
    orderParams[@"order_no"] = @"";
    orderParams[@"consumptionType"] = [NSNumber numberWithInteger:3];
    orderParams[@"payTypeEnum"] = [NSNumber numberWithInteger:3];
    orderParams[@"body"] = self.coursesModel.title;
    orderParams[@"subject"] = @"一家老小_购买课程";
    orderParams[@"orderSources"] = @2;
    [[self.familyCoachVM.PlaceAnOrderCommand execute:orderParams] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            [ATYToast aty_bottomMessageToast:@"订阅成功"];
            self.coursesModel.isPurchase = [NSNumber numberWithInteger:1];
            self.audioPlayBottomView.model = self.coursesModel;
        }
    }];
}

#pragma mark -- 分享
- (void)fc_showShareView:(NSString *)shareUrl isDetailManuscript:(BOOL)isDetailManuscript{
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
    
    @weakify(self);
    shareView.clickCellBlock = ^(NSArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        if (([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 0) || (![QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 0)) {//分享到微信
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.scene = WXSceneSession;// 分享到会话
            WXMediaMessage *medMessage = [WXMediaMessage message];
            WXWebpageObject *webPageObj = [WXWebpageObject object];
            
            if (isDetailManuscript) {
                FcCoursesDetailModel *currentDetailModel = [self.coursesModel.consumptionDetails objectAtIndex:self.audioPlayBottomView.index];
                medMessage.title = currentDetailModel.title; // 标题
                medMessage.description = currentDetailModel.content;// 描述
            } else {
                medMessage.title = self.coursesModel.title; // 标题
                medMessage.description = self.coursesModel.content;// 描述
            }

            UIImage *thumbImage = [self compressImage:[self getImageFromURL:self.coursesModel.image.path] toByte:32768];
            [medMessage setThumbImage:thumbImage];
//            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
//                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=%@",self.coursesModel.courses_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
//            } else {
//                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=0",self.coursesModel.courses_id];
//            }
            webPageObj.webpageUrl = shareUrl;

            medMessage.mediaObject = webPageObj;
            req.message = medMessage;
            [WXApi sendReq:req];
        } else if (([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 1) || (![QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 1)) {//分享到朋友圈
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.scene = WXSceneTimeline;// 分享到朋友圈
            WXMediaMessage *medMessage = [WXMediaMessage message];
            WXWebpageObject *webPageObj = [WXWebpageObject object];
            
            if (isDetailManuscript) {
                FcCoursesDetailModel *currentDetailModel = [self.coursesModel.consumptionDetails objectAtIndex:self.audioPlayBottomView.index];
                medMessage.title = currentDetailModel.title; // 标题
                medMessage.description = currentDetailModel.content;// 描述
            } else {
                medMessage.title = self.coursesModel.title; // 标题
                medMessage.description = self.coursesModel.content;// 描述
            }
            
            UIImage *thumbImage = [self compressImage:[self getImageFromURL:self.coursesModel.image.path] toByte:32768];
            [medMessage setThumbImage:thumbImage];
//            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
//                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=%@",self.coursesModel.courses_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
//            } else {
//                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=0",self.coursesModel.courses_id];
//            }
            webPageObj.webpageUrl = shareUrl;
            medMessage.mediaObject = webPageObj;
            req.message = medMessage;
            [WXApi sendReq:req];
        } else if (([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 2) || ([QQApiInterface isQQInstalled] && ![WXApi isWXAppInstalled] && indexPath.item == 0)) {//分享到qq
            NSString *utf8String = nil;
//            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
//                utf8String = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=%@",self.coursesModel.courses_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
//            } else {
//                utf8String = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=0",self.coursesModel.courses_id];
//            }
            utf8String = shareUrl;
            
            NSString *title = nil;
            NSString *description = nil;
            
            if (isDetailManuscript) {
                FcCoursesDetailModel *currentDetailModel = [self.coursesModel.consumptionDetails objectAtIndex:self.audioPlayBottomView.index];
                title = currentDetailModel.title; // 标题
                description = currentDetailModel.content;// 描述
            } else {
                title = self.coursesModel.title;
                description = self.coursesModel.content;
            }
            
            NSString *previewImageUrl = self.coursesModel.image.path;
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
//            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
//                string = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=%@",self.coursesModel.courses_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
//            } else {
//                string = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=0",self.coursesModel.courses_id];
//            }
            string = shareUrl;
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

@end
