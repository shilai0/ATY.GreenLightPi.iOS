//
//  PCUserAgreementViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/26.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCUserAgreementViewController.h"

@interface PCUserAgreementViewController ()
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation PCUserAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"用户协议" titleColor:0x333333];
    
    //初始化myWebView
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight)];
    self.webView.backgroundColor = [UIColor whiteColor];
    NSURL *filePath = [NSURL URLWithString:@"http://business.aiteyou.net/h5/agreement.html"];
    NSURLRequest *request = [NSURLRequest requestWithURL: filePath];
    [self.webView loadRequest:request];
    //使文档的显示范围适合UIWebView的bounds
    [self.webView setScalesPageToFit:YES];
    [self.view addSubview:self.webView];
}

@end
