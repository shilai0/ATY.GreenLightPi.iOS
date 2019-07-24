//
//  FSDetailViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/14.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FSDetailViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "GKCover.h"
#import "HMShareView.h"
#import "HMShareFooterView.h"
#import "WFActivityRequset.h"
#import <WechatOpenSDK/WXApiObject.h>
#import <WechatOpenSDK/WXApi.h>
#import "FatherStudyCategoryModel.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import "TencentApiManager.h"
#import "FileEntityModel.h"
#import "ATYAlertViewController.h"

@interface FSDetailViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIButton *bottomButton;
@end

@implementation FSDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    self.view.backgroundColor = KHEXRGB(0xFFFFFF);
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self id_creatNav];
    [self id_loadWebView];
}

- (void)id_creatNav {
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setRightNavItemImg:@"hm_more" title:nil titleColor:0x333333 rightBlock:^{
        @strongify(self);
        [self hm_showShareView];
    }];
}

- (void)hm_showShareView {
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
         showAnimStyle:GKCoverShowAnimStyleBottom
         hideAnimStyle:GKCoverHideAnimStyleBottom
              notClick:NO
             showBlock:nil
             hideBlock:^{
                 [view removeFromSuperview];
                 view = nil;
             }];
    
    [[self.bottomButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [GKCover hideCover];
    }];
    
    shareView.clickCellBlock = ^(NSArray *dataArr, NSIndexPath *indexPath) {
        if (([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 0) || (![QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 0)) {//分享到微信
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.scene = WXSceneSession;// 分享到会话
            WXMediaMessage *medMessage = [WXMediaMessage message];
            WXWebpageObject *webPageObj = [WXWebpageObject object];
            medMessage.title = self.titleStr; // 标题
            medMessage.description = self.content;// 描述
            UIImage *thumbImage = [self compressImage:[self getImageFromURL:self.urlStr] toByte:32768];
            [medMessage setThumbImage:thumbImage];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=%@&aId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],self.aId];
            } else {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=0&aId=%@",self.aId];
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
            medMessage.title = self.titleStr; // 标题
            medMessage.description = self.content;// 描述
            UIImage *thumbImage = [self compressImage:[self getImageFromURL:self.urlStr] toByte:32768];
            [medMessage setThumbImage:thumbImage];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=%@&aId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],self.aId];
            } else {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=0&aId=%@",self.aId];
            }
            medMessage.mediaObject = webPageObj;
            req.message = medMessage;
            [WXApi sendReq:req];
        }
        else if (([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 2) || ([QQApiInterface isQQInstalled] && ![WXApi isWXAppInstalled] && indexPath.item == 0)) {//分享到qq
            NSString *utf8String = nil;
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                utf8String = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=%@&aId=%@",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],self.aId];
            } else {
                utf8String = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/pictrueBook.html?uId=0&aId=%@",self.aId];
            }
            NSString *title = self.titleStr;
            NSString *description = self.content;
            NSString *previewImageUrl = self.urlStr;
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
            NSString *string = self.urlString;
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

#pragma mark -- UIWebView
- (void)id_loadWebView {
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - KBottomSafeHeight)];
    
    web.delegate = self;
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    
    [self.view addSubview:web];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    WFActivityRequset *requset = [[WFActivityRequset alloc] init];
    context[@"AndroidWebView"] = requset;
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
    
    //点击了关注/取消关注
//    requset.fuctionBlock = ^(NSString *fuctionName) {
//        if ([fuctionName isEqualToString:@"isFocusAction"]) {
//            [KNotificationCenter postNotificationName:ISFOCUSACTION_CONTENT_NOTIFICATION object:nil userInfo:nil];
//        }
//    };
    
    //文章被发布者删除
    requset.errorAlertFnBlock = ^(NSString *errorMessage) {
        ATYAlertViewController *alertCtrl = [ATYAlertViewController alertControllerWithTitle:nil message:errorMessage];
        alertCtrl.messageAlignment = NSTextAlignmentCenter;
        @weakify(self);
        ATYAlertAction *done = [ATYAlertAction actionWithTitle:@"OK!" titleColor:0xFF632A handler:^(ATYAlertAction *action) {
            @strongify(self);
            [self.navigationController popViewControllerAnimated:YES];
        }];
        
        [alertCtrl addAction:done];
        [self presentViewController:alertCtrl animated:NO completion:nil];
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

@end
