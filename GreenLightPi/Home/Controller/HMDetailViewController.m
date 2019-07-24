//
//  HMDetailViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/26.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "HMDetailViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "GKCover.h"
#import "HMShareView.h"
#import "HMShareFooterView.h"
#import <WechatOpenSDK/WXApiObject.h>
#import <WechatOpenSDK/WXApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "TencentApiManager.h"
#import "HMDetailBottomView.h"
#import "HomeViewModel.h"
#import "ATYAlertViewController.h"
#import "WFActivityRequset.h"
#import <IQKeyboardManager/IQKeyboardManager.h>


@interface HMDetailViewController ()<UIWebViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UIButton *returnButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *bottomButton;
@property (nonatomic, strong) HMDetailBottomView *bottomView;
@property (nonatomic, strong) HomeViewModel *homeVM;

@end

@implementation HMDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar=NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar=YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHEXRGB(0xFFFFFF);
    [self hm_creatNav];
    [self loadWebView];
    [self hm_creatDtailBottomView];
    
    if (self.contentHtmlStr) {
        self.contentStr = [self filterHTML:self.contentHtmlStr];
    }
}

#pragma mark -- Nav
- (void)hm_creatNav {
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setRightNavItemImg:@"fc_audioShare" title:nil titleColor:0 rightBlock:^{
        @strongify(self);
        [self hm_showShareView];
    }];
    
}

#pragma mark -- bottom
- (void)hm_creatDtailBottomView {
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(@(-KBottomSafeHeight));
        make.height.equalTo(@49);
    }];
    
    @weakify(self);
    self.bottomView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0://发表评论
            {
                [self hm_commentArtical];
            }
                break;
            case 1://查看评论
            {
                [self.webView stringByEvaluatingJavaScriptFromString:@"article.moveScoll()"];
            }
                break;
            case 2://收藏
            {
                if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                    [self hm_collectArticalWithIsCancle:content1];
                } else {
                    [self loginAction];
                }
            };
                break;
            case 3://点击评论框
            {
                if (![[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                    [self loginAction];
                    [self.bottomView.inputTextField resignFirstResponder];
                }
            };
                break;
            default:
                break;
        }
    };
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
    
    @weakify(self);
    shareView.clickCellBlock = ^(NSArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        if (([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 0) || (![QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 0)) {//分享到微信
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
            req.bText = NO;
            req.scene = WXSceneSession;// 分享到会话
            WXMediaMessage *medMessage = [WXMediaMessage message];
            WXWebpageObject *webPageObj = [WXWebpageObject object];
            medMessage.title = self.titleStr; // 标题
            medMessage.description = self.contentStr;// 描述
            UIImage *thumbImage = [self compressImage:[self getImageFromURL:self.urlStr] toByte:32768];
            [medMessage setThumbImage:thumbImage];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/articleShare.html?uId=%@&aId=%@&moduleType=%ld",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],self.aid,self.moduleType];
            } else {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/articleShare.html?uId=0&aId=%@&moduleType=%ld",self.aid,self.moduleType];
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
            medMessage.description = self.contentStr;// 描述
            UIImage *thumbImage = [self compressImage:[self getImageFromURL:self.urlStr] toByte:32768];
            [medMessage setThumbImage:thumbImage];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/articleShare.html?uId=%@&aId=%@&moduleType=%ld",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],self.aid,self.moduleType];
            } else {
                webPageObj.webpageUrl = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/articleShare.html?uId=0&aId=%@&moduleType=%ld",self.aid,self.moduleType];
            }
            medMessage.mediaObject = webPageObj;
            req.message = medMessage;
            [WXApi sendReq:req];
        } else if (([QQApiInterface isQQInstalled] && [WXApi isWXAppInstalled] && indexPath.item == 2) || ([QQApiInterface isQQInstalled] && ![WXApi isWXAppInstalled] && indexPath.item == 0)) {//分享到qq
            NSString *utf8String = nil;
            if ([[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]) {
                utf8String = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/articleShare.html?uId=%@&aId=%@&moduleType=%ld",[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID],self.aid,self.moduleType];
            } else {
                utf8String = [NSString stringWithFormat:@"http://business.aiteyou.net/h5/articleShare.html?uId=0&aId=%@&moduleType=%ld",self.aid,self.moduleType];
            }
            NSString *title = self.titleStr;
            NSString *description = self.contentStr;
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
- (void)loadWebView {
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KBottomSafeHeight - 49 - KNavgationBarHeight)];
    
    self.webView.delegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    
    [self.view addSubview:self.webView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    WFActivityRequset *requset = [[WFActivityRequset alloc] init];
    context[@"AndroidWebView"] = requset;
    
    @weakify(self);
    //获取是否收藏和评论数
    requset.getIsCollectBlock = ^(NSInteger isCollect, NSInteger commentCount) {
        @strongify(self);
        self.bottomView.isCollect = [[NSNumber numberWithInteger:isCollect] boolValue];
        self.bottomView.commentNum = commentCount;
    };
}

#pragma mark -- html转字符串
- (NSString *)filterHTML:(NSString *)html {
    
    //  过滤html标签
    NSScanner *theScanner;
    NSString *text = nil;
    theScanner = [NSScanner scannerWithString:html];
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text] withString:@""];
    }
    //  过滤html中的\n\r\t换行空格等特殊符号
    NSMutableString *str1 = [NSMutableString stringWithString:html];
    for (int i = 0; i < str1.length; i++) {
        unichar c = [str1 characterAtIndex:i];
        NSRange range = NSMakeRange(i, 1);
        
        //  在这里添加要过滤的特殊符号
        if ( c == '\r' || c == '\n' || c == '\t' ) {
            [str1 deleteCharactersInRange:range];
            --i;
        }
    }
    
    html  = str1.length > 100 ? [NSString stringWithString:[str1 substringToIndex:100]] : str1;
    return [self getChineseStringWithString:html];
}

- (NSString *)getChineseStringWithString:(NSString *)string
{
    //(unicode中文编码范围是0x4e00~0x9fa5)
    for (int i = 0; i < string.length; i++) {
        int utfCode = 0;
        void *buffer = &utfCode;
        NSRange range = NSMakeRange(i, 1);
        
        BOOL b = [string getBytes:buffer maxLength:2 usedLength:NULL encoding:NSUTF16LittleEndianStringEncoding options:NSStringEncodingConversionExternalRepresentation range:range remainingRange:NULL];
        
        if (b && (utfCode >= 0x4e00 && utfCode <= 0x9fa5)) {
            return [string substringFromIndex:i];
        }
    }
    return nil;
}

#pragma mark -- 发表评论
- (void)hm_commentArtical {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"user_id"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"content"] = self.bottomView.inputTextField.text;
    params[@"content_id"] = self.aid;
    params[@"moduleType"] = [NSNumber numberWithInteger:self.moduleType];
    params[@"fid"] = @0;
    params[@"comment_id"] = @0;
    @weakify(self);
    [[self.homeVM.CreateContentCommentCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            [ATYToast aty_bottomMessageToast:@"评论成功"];
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@&isCommentSuccess=0",self.urlString]]]];
            [self.bottomView.inputTextField setText:@""];
        }
    }];
}

#pragma mark -- 收藏
- (void)hm_collectArticalWithIsCancle:(NSString *)isCancle {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"articleId"] = self.aid;
    params[@"moduleType"] = [NSNumber numberWithInteger:self.moduleType];
    if ([isCancle isEqualToString:@"1"]) {
        params[@"isCancel"] = [NSNumber numberWithInteger:1];
    } else {
        params[@"isCancel"] = [NSNumber numberWithInteger:0];
    }
    [[self.homeVM.CollectArticleCommand execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            self.bottomView.isCollect = !self.bottomView.isCollect;
            if ([isCancle isEqualToString:@"1"]) {
                [ATYToast aty_bottomMessageToast:@"取消收藏成功"];
            } else {
                [ATYToast aty_bottomMessageToast:@"收藏成功"];
            }
        }
    }];
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

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

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

- (UIButton *)returnButton {
    if (!_returnButton) {
        _returnButton = [[UIButton alloc] init];
        [_returnButton setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    }
    return _returnButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [[UIButton alloc] init];
        [_shareButton setImage:[UIImage imageNamed:@"hm_more"] forState:UIControlStateNormal];
    }
    return _shareButton;
}

- (void)dealloc {
    [KNotificationCenter removeObserver:self];
}

@end
