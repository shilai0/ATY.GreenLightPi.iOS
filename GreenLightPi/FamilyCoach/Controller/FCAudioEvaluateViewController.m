//
//  FCAudioEvaluateViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/16.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCAudioEvaluateViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "FCEvaluateViewController.h"
#import "FcCoursesModel.h"

@interface FCAudioEvaluateViewController ()<UIWebViewDelegate>

@end

@implementation FCAudioEvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"评论" titleColor:0x333333];
    [self fc_loadAudioEvaluateWebView];
}

- (void)fc_loadAudioEvaluateWebView {
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - KBottomSafeHeight)];
    web.delegate = self;
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    [self.view addSubview:web];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

@end
