//
//  FCAudioDetailViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCAudioDetailViewController.h"
#import "FCAudioDetailHeadView.h"
#import "FCCourseDetailBottomView.h"
#import "FCPurchaseCourseViewController.h"
#import "WXApiManager.h"
#import "AliPayManager.h"
#import "FcCoursesModel.h"
#import "LSPPageView.h"
#import "LSPTitleStyle.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "FamilyCoachViewModel.h"
#import "FCAudioDetailListCell.h"
#import "FCAudioDetailListView.h"
#import "FCAudioPlayViewController.h"
#import "FileEntityModel.h"
#import "FCCourseDetailTipView.h"
#import "GKCover.h"
#import "HMShareView.h"
#import "HMShareFooterView.h"
#import <WechatOpenSDK/WXApiObject.h>
#import <WechatOpenSDK/WXApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "HMDetailBottomView.h"
#import "FCAudioDetailListHeadView.h"
#import "ATYAlertViewController.h"
#import "RLFirstOpenAppViewController.h"
#import "BaseNavigationViewController.h"

@interface FCAudioDetailViewController ()<LSPPageViewDelegate,UIWebViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) FCAudioDetailHeadView *headView;
@property (nonatomic, strong) FCCourseDetailBottomView *bottomView;
@property (nonatomic, strong) NSMutableArray *childVCArr;
@property (nonatomic, strong) FamilyCoachViewModel *familyCoachVM;
@property (nonatomic, strong) FcCoursesModel *model;
@property (nonatomic, strong) FCAudioDetailListView *audioDetailListView;
@property (nonatomic, strong) FCCourseDetailTipView *tipView;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) FCAudioDetailListHeadView *listHeadView;

@end

@implementation FCAudioDetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHEXRGB(0xFFFFFF);
    [self fc_creatAudioDetailViews];
    [self fc_RequestData];
}

- (void)fc_creatAudioDetailViews {
    [self.view addSubview:self.headView];
    
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    
    NSArray *titleArr = @[@"介绍",@"节目"];
    for (int i = 0; i < titleArr.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        [self fc_loadView:vc index:i];
        [self.childVCArr addObject:vc];
    }
    LSPTitleStyle *style = [[LSPTitleStyle alloc] init];
    style.isAverage = YES;
    LSPPageView *pageView = [[LSPPageView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, KSCREENH_HEIGHT - 200 - KBottomSafeHeight) titles:titleArr style:style childVcs:self.childVCArr.mutableCopy parentVc:self];
    pageView.delegate = self;
    pageView.tag = 2000;
    pageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pageView];
    
    @weakify(self);
    self.headView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0://返回
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
                break;
            case 1://分享
            {
                [self fc_showShareView];
            }
                break;
            case 2://订阅
            {
                if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID ]) {
                    if ([self.model.isPurchase integerValue] == 0 && [self.model.consumptionType isEqualToString:@"free"]) {
                        [self addStudy];
                    } else if ([self.model.isPurchase integerValue] == 0 && ![self.model.consumptionType isEqualToString:@"free"]) {
                        FCPurchaseCourseViewController *purchaseCourseVC = [[FCPurchaseCourseViewController alloc] init];
                        purchaseCourseVC.coursesModel = self.model;
                        [WXApiManager sharedManager].model = self.model;
                        [AliPayManager sharedManager].model = self.model;
                        [self.navigationController pushViewController:purchaseCourseVC animated:YES];
                    }
                } else {
//                    [self gologinStr:@"需要登录才能订阅课程哦"];
                    [self loginAction];
                }
                
            }
                break;
            default:
                break;
        }
    };
}

#pragma mark -- 底部按钮
- (void)fc_creatBottomView {
    /***版本1.3.1暂时隐藏立即购买的下单入口（后面如果开放，替换下面btnArr代码即可）***/
//        NSMutableArray *btnArr = [NSMutableArray arrayWithObjects:@{@"imageName":@"",@"title":[NSString stringWithFormat:@"￥%@",self.model.price],@"titleColor":@"0x646464",@"backColor":KHEXRGB(0xFFFFFF)}, @{@"imageName":@"",@"title":@"VIP免费",@"titleColor":@"0x646464",@"backColor":KHEXRGB(0xD9D295)},@{@"imageName":@"fc_addStudy",@"title":@"立即购买",@"titleColor":@"0xFFFFFF",@"backColor":KHEXRGB(0x44C08C)},nil];
    
    NSMutableArray *btnArr = [NSMutableArray arrayWithObjects:@{@"imageName":@"",@"title":[NSString stringWithFormat:@"￥%@",self.model.price],@"titleColor":@"0x646464",@"backColor":KHEXRGB(0xFFFFFF)}, @{@"imageName":@"",@"title":@"VIP免费",@"titleColor":@"0x646464",@"backColor":KHEXRGB(0xD9D295)},nil];
    
        self.bottomView = [[FCCourseDetailBottomView alloc] initWithData:btnArr];
        [self.view addSubview:self.bottomView];
        
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.bottom.equalTo(@(-KBottomSafeHeight));
            make.height.equalTo(@49);
        }];
        
        __weak typeof(self) weakSelf = self;
        self.bottomView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
            if (index == 1) {
                [weakSelf.view addSubview:weakSelf.tipView];
                weakSelf.tipView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
                    [weakSelf.tipView removeFromSuperview];
                };
            } else if (index == 2) {
                FCPurchaseCourseViewController *purchaseCourseVC = [[FCPurchaseCourseViewController alloc] init];
                purchaseCourseVC.coursesModel = weakSelf.model;
                [WXApiManager sharedManager].model = weakSelf.model;
                [AliPayManager sharedManager].model = weakSelf.model;
                [weakSelf.navigationController pushViewController:purchaseCourseVC animated:YES];
            }
        };
    
    LSPPageView *pageView = [self.view viewWithTag:2000];
    CGRect temp = pageView.frame;
    temp.size.height = (KSCREENH_HEIGHT - 200 - KBottomSafeHeight - 49);
    pageView.frame = temp;
}

- (void)fc_loadView:(UIViewController *)VC index:(int)index {
    if (index == 0) {
        NSString *urlString = nil;
        if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
            urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/famailyVideo.html?coursesId=%@&userId=%@&type=3",self.courses_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
        } else {
            urlString = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/famailyVideo.html?coursesId=%@&userId=0&type=3",self.courses_id];
        }
        UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - 200 - KBottomSafeHeight - 44)];
        web.delegate = self;
        [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
        [VC.view addSubview:web];
    } else {
        self.audioDetailListView = [[FCAudioDetailListView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - 200 - KBottomSafeHeight - 44) style:UITableViewStylePlain];
        self.audioDetailListView.tableHeaderView = self.listHeadView;
        [VC.view addSubview:self.audioDetailListView];
        
        @weakify(self);
        self.audioDetailListView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
            @strongify(self);
            FcCoursesDetailModel *currentDetailModel = [self.model.consumptionDetails objectAtIndex:indexPath.row];
            if (currentDetailModel.isLock == 0 && ([self.model.isPurchase integerValue] == 1 || [self.model.consumptionType isEqualToString:@"free"])) {
                FCAudioPlayViewController *audioPlayVC = [[FCAudioPlayViewController alloc] init];
                audioPlayVC.coursesModel = self.model;
                audioPlayVC.index = indexPath.row;
                UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:audioPlayVC];
                [self presentViewController:nav animated:YES completion:nil];
            } else if (currentDetailModel.isLock == 1) {
                [ATYToast aty_bottomMessageToast:@"课程暂未开放，敬请期待"];
            } else {
                [ATYToast aty_bottomMessageToast:@"付费音频购买后才可收听"];
            }
            
        };
    }
}

#pragma mark - LSPPageViewDelegate
- (void)pageViewScollEndView:(LSPPageView *)pageView WithIndex:(NSInteger)index
{
    //    UIViewController *currentVC = self.childVCArr[index];
    //    UIWebView *currentView = (UIWebView *)[currentVC.view viewWithTag:(10 + index)];
    //    [currentView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//    WFActivityRequset *requset = [[WFActivityRequset alloc] init];
//    context[@"AndroidWebView"] = requset;
//    @weakify(self);
//    requset.getUserBlock = ^(NSInteger userId, NSString *userType) {
//        @strongify(self);
//        if ([userType isEqualToString:@"coachUser"] || [userType isEqualToString:@"businessUser"]) {
//            FCCoachCenterViewController *coachCenterVC = [[FCCoachCenterViewController alloc] init];
//            coachCenterVC.userType = userType;
//            coachCenterVC.userId = [NSNumber numberWithInteger:userId];
//            [self.navigationController pushViewController:coachCenterVC animated:YES];
//        } else if ([userType isEqualToString:@"appUser"]) {
//            PCOtherUserCenterViewController *otherUserCenterVC = [[PCOtherUserCenterViewController alloc] init];
//            otherUserCenterVC.userType = userType;
//            otherUserCenterVC.userId = [NSNumber numberWithInteger:userId];            [self.navigationController pushViewController:otherUserCenterVC animated:YES];
//        }
//    };
//
//    requset.fuctionBlock = ^(NSString *fuctionName) {
//        if ([fuctionName isEqualToString:@"isFocusAction"]) {
//            [KNotificationCenter postNotificationName:ISFOCUSACTION_CONTENT_NOTIFICATION object:nil userInfo:nil];
//        }
//    };
}

#pragma mark -- RequestData
- (void)fc_RequestData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"coursesId"] = self.courses_id;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
        params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    } else {
        params[@"userId"] = [NSNumber numberWithInteger:0];
    }
    @weakify(self);
    [[self.familyCoachVM.GetCoursesForIdCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            FcCoursesModel *model = [FcCoursesModel mj_objectWithKeyValues:x[@"Data"]];
            self.model = model;
            self.headView.model = model;
            [model.consumptionDetails enumerateObjectsUsingBlock:^(FcCoursesDetailModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                obj.itemNum = [NSString stringWithFormat:@"第%@课",idx > 8 ? [NSString stringWithFormat:@"%ld",idx + 1] : [NSString stringWithFormat:@"0%ld",idx + 1]];
            }];
            self.audioDetailListView.dataArr = [model.consumptionDetails mutableCopy];
            [self.audioDetailListView reloadData];
            if ([self.model.isPurchase integerValue] == 0 && ![self.model.consumptionType isEqualToString:@"free"]) {
                [self fc_creatBottomView];
            }
        }
    }];
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
    @weakify(self);
    [[self.familyCoachVM.PlaceAnOrderCommand execute:orderParams] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            [ATYToast aty_bottomMessageToast:@"订阅成功"];
            [self fc_RequestData];
        }
    }];
}

#pragma mark -- 分享
- (void)fc_showShareView {
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
            medMessage.title = self.model.title; // 标题
            medMessage.description = self.model.content;// 描述
            UIImage *thumbImage = [self compressImage:[self getImageFromURL:self.model.image.path] toByte:32768];
            [medMessage setThumbImage:thumbImage];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=%@",self.model.courses_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
            } else {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=0",self.model.courses_id];
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
            medMessage.title = self.model.title; // 标题
            medMessage.description = self.model.content;// 描述
            UIImage *thumbImage = [self compressImage:[self getImageFromURL:self.model.image.path] toByte:32768];
            [medMessage setThumbImage:thumbImage];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=%@",self.model.courses_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
            } else {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=0",self.model.courses_id];
            }            medMessage.mediaObject = webPageObj;
            req.message = medMessage;
            [WXApi sendReq:req];
        } else if (([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 2) || ([QQApiInterface isQQInstalled] && ![WXApi isWXAppInstalled] && indexPath.item == 0)) {//分享到qq
            NSString *utf8String = nil;
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                utf8String = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=%@",self.model.courses_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
            } else {
                utf8String = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=0",self.model.courses_id];
            }
            NSString *title = self.model.title;
            NSString *description = self.model.content;
            NSString *previewImageUrl = self.model.image.path;
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
                string = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=%@",self.model.courses_id,[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
            } else {
                string = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/familyAudioShare.html?coursesId=%@&userId=0",self.model.courses_id];
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


- (FCAudioDetailListHeadView *)listHeadView {
    if (!_listHeadView) {
        _listHeadView = [[FCAudioDetailListHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 62)];
    }
    return _listHeadView;
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

- (FamilyCoachViewModel *)familyCoachVM {
    if (!_familyCoachVM) {
        _familyCoachVM = [[FamilyCoachViewModel alloc] init];
    }
    return _familyCoachVM;
}

- (NSMutableArray *)childVCArr {
    if (!_childVCArr) {
        _childVCArr = [[NSMutableArray alloc] init];
    }
    return _childVCArr;
}

- (FCAudioDetailHeadView *)headView {
    if (!_headView) {
        _headView = [FCAudioDetailHeadView new];
    }
    return _headView;
}

- (void)dealloc {
    [KNotificationCenter removeObserver:self];
}

@end
