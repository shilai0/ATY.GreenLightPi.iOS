//
//  PCAboutViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/3.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCAboutViewController.h"
#import "BaseFormModel.h"
#import "PCAboutAtyView.h"
#import "PCAboutAtyHeadView.h"

@interface PCAboutViewController ()
@property (nonatomic, strong) PCAboutAtyView *aboutAtyView;
@property (nonatomic, strong) PCAboutAtyHeadView *aboutHeadView;
@property (nonatomic, strong) UILabel *nameLabel;
@end

@implementation PCAboutViewController

- (PCAboutAtyView *)aboutAtyView {
    if (!_aboutAtyView) {
        _aboutAtyView = [[PCAboutAtyView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStylePlain];
    }
    return _aboutAtyView;
}

- (PCAboutAtyHeadView *)aboutHeadView {
    if (!_aboutHeadView) {
        _aboutHeadView = [[PCAboutAtyHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 184)];
    }
    return _aboutHeadView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, KSCREENH_HEIGHT - KBottomSafeHeight - KNavgationBarHeight - 32, KSCREEN_WIDTH, 12)];
        _nameLabel.text = @"深圳市一家老小信息科技有限公司";
        _nameLabel.textColor = KHEXRGB(0x999999);
        _nameLabel.font = FONT(12);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"关于" titleColor:0x333333];
    [self pc_creatAboutViews];
}

- (void)pc_creatAboutViews {
    self.aboutAtyView.tableHeaderView = self.aboutHeadView;
    [self.view addSubview:self.aboutAtyView];
    [self.aboutAtyView addSubview:self.nameLabel];
    
    NSString *plistStr = NSLocalizedString(@"PCAboutAty.plist", nil);
    self.aboutAtyView.dataArr = [BaseFormModel xs_getDataWithPlist:plistStr];
    [self.aboutAtyView reloadData];
}

@end
