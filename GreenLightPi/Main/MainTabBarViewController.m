//
//  MainTabBarViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/25.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "BaseNavigationViewController.h"
#import "HMMainViewController.h"
#import "FCMainViewController.h"
#import "PCMainViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //创建并添加子控制器
    [[UITabBar appearance] setTranslucent:NO];
}

- (void)hm_creatSubControllers {
    [self hm_addSubControllersWithControllerName:@"HMMainViewController" title:@"首页" imageName:@"Home"];
    [self hm_addSubControllersWithControllerName:@"ReadingCompanionViewController" title:@"AI阅读" imageName:@"fatherstudy"];
    [self hm_addSubControllersWithControllerName:@"FCMainViewController" title:@"好家长" imageName:@"familycoach"];
    [self hm_addSubControllersWithControllerName:@"PCMainViewController" title:@"我的" imageName:@"mine"];
}

- (void)hm_addSubControllersWithControllerName:(NSString *)name title:(NSString *)title imageName:(NSString *)imageName {
    UIViewController *childCtrl = [[NSClassFromString(name) alloc] init];
    if ([childCtrl isKindOfClass:[HMMainViewController class]]) {
        HMMainViewController *hmMainVC = (HMMainViewController *)childCtrl;
        hmMainVC.isFirstRegister = self.isFirstRegister;
        childCtrl = hmMainVC;
    }
    BaseNavigationViewController *navigationVC = [[BaseNavigationViewController alloc] initWithRootViewController:childCtrl];
    childCtrl.tabBarItem.image = [UIImage imageNamed:imageName];
    UIImage *selectImg =  [UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted",imageName]];
    childCtrl.tabBarItem.selectedImage = [selectImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBar.tintColor = KHEXRGB(0xFFFFFF);
    childCtrl.tabBarItem.title = title;
    NSMutableDictionary *attrSelected = [NSMutableDictionary dictionary];
    attrSelected[NSFontAttributeName] = [UIFont boldSystemFontOfSize:12];
    attrSelected[NSForegroundColorAttributeName] = KHEXRGB(0x44C08C);
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrSelected forState:UIControlStateSelected];
    [self addChildViewController:navigationVC];
}

- (void)setIsFirstRegister:(BOOL)isFirstRegister {
    _isFirstRegister = isFirstRegister;
    [self hm_creatSubControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
