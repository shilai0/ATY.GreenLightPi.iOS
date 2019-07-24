//
//  PCMyCashCouponViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/30.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCMyCashCouponViewController.h"
#import "MyCashCouponUserdRecordView.h"
#import "PersonalCenterUserModel.h"
#import "MyCashCouponCanUseView.h"
#import "LSPPageView.h"

@interface PCMyCashCouponViewController ()
@property (nonatomic, strong) MyCashCouponUserdRecordView *cashCouponUsedRecordView;
@property (nonatomic, strong) MyCashCouponCanUseView *cashCouponCanUseView;
@property (nonatomic,strong) NSMutableArray *childVcArray;
@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation PCMyCashCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHEXRGB(0xFFFFFF);
    [self creatMyCashCouponViews];
}

- (void)creatMyCashCouponViews {
    [self.view addSubview:self.returnBtn];
    [self.view addSubview:self.titleLabel];
    
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@(28+KTopBarSafeHeight));
        make.width.height.equalTo(@28);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@(33+KTopBarSafeHeight));
        make.height.equalTo(@13);
        make.width.equalTo(@100);
    }];
    
    NSArray *titleArr = [NSArray arrayWithObjects:@"可用",@"使用记录", nil];
    for (int i = 0; i < titleArr.count; i++) {
        UIViewController *vc = [[UIViewController alloc] init];
        if (i == 0) {
            self.cashCouponCanUseView = [[MyCashCouponCanUseView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - 44) style:UITableViewStylePlain];
            self.cashCouponUsedRecordView.tag = 10 + i;
            [vc.view addSubview:self.cashCouponCanUseView];
            self.cashCouponCanUseView.dataArr = [[NSMutableArray alloc] initWithObjects:self.personalCenterModel, nil];
            [self.cashCouponCanUseView reloadData];
        } else {
            self.cashCouponUsedRecordView = [[MyCashCouponUserdRecordView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - 44) style:UITableViewStylePlain];
            self.cashCouponUsedRecordView.tag = 10 + i;
            [vc.view addSubview:self.cashCouponUsedRecordView];
            self.cashCouponUsedRecordView.dataArr = [[NSMutableArray alloc] init];
            [self.cashCouponUsedRecordView reloadData];
        }
        [self.childVcArray addObject:vc];
    }
    LSPTitleStyle *style = [[LSPTitleStyle alloc] init];
    style.index = 0;
    style.isAverage = YES;
    style.isNeedScale = YES;
    style.isShowBottomLine = YES;
    style.normalColor = KHEXRGB(0x646464);
    style.font = [UIFont boldSystemFontOfSize:14];
    LSPPageView *pageView = [[LSPPageView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) titles:titleArr style:style childVcs:self.childVcArray.mutableCopy parentVc:self];
    pageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:pageView];

//    [self requestReadBarData];

    @weakify(self);
    [[self.returnBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
}

#pragma mark -- 懒加载
- (UIButton *)returnBtn {
    if (!_returnBtn) {
        _returnBtn = [[UIButton alloc] init];
        [_returnBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    }
    return _returnBtn;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"代金券";
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (NSMutableArray *)childVcArray {
    if (!_childVcArray) {
        _childVcArray = [[NSMutableArray alloc] init];
    }
    return _childVcArray;
}

@end
