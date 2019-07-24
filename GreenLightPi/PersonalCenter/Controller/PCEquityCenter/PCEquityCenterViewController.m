//
//  PCEquityCenterViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/6.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCEquityCenterViewController.h"
#import "PCEquityCenterMainView.h"
#import "PCEquityCenterMainHeadView.h"
#import "PCEquityCenterMainFootSubView.h"
#import "PersonalCenterViewModel.h"
#import "IncomeCenterModel.h"
#import "PCProfitViewController.h"
#import "PCMyTeamViewController.h"
#import "PCMyBankCardViewController.h"
#import <WechatOpenSDK/WXApiObject.h>
#import <WechatOpenSDK/WXApi.h>
#import "PCDevelopQRView.h"
#import "PCCashOutViewController.h"
#import "PCMyCashOutRecordViewController.h"

@interface PCEquityCenterViewController ()
@property (nonatomic, strong) PCEquityCenterMainView *equityCenterMainView;
@property (nonatomic, strong) PCEquityCenterMainHeadView *equityCentermainHeadView;
@property (nonatomic, strong) UIView *equityCentermainFootView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, strong) IncomeCenterModel *incomeCenterModel;
@property (nonatomic, strong) PCDevelopQRView *qrCodeView;
@end

@implementation PCEquityCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = KHEXRGB(0xFFFFFF);
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0
                      leftBlock:^{
                          @strongify(self);
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
    
    [self aty_setCenterNavItemtitle:@"权益中心" titleColor:0x333333];
    
    [self creatEquityCenterMainViews];
    
    [[KNotificationCenter rac_addObserverForName:CASHOUTSUCCESS_NOTIFICATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        NSDictionary *dic = x.userInfo;
        NSString *cashOutStr = dic[@"cashoutValue"];
        CGFloat lastFloat = [self.incomeCenterModel.Income floatValue];
        CGFloat cashOutFloat = [cashOutStr floatValue];
        self.incomeCenterModel.Income = [NSNumber numberWithFloat:(lastFloat - cashOutFloat)];
        self.equityCentermainHeadView.incomeModel = self.incomeCenterModel;
    }];
}

- (void)creatEquityCenterMainViews {
    [self.view addSubview:self.equityCenterMainView];
    self.equityCenterMainView.tableHeaderView = self.equityCentermainHeadView;
    [self getIncomeCenterData];
    
    @weakify(self);
    self.equityCentermainHeadView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0:
            {
                PCCashOutViewController *cashOutVC = [[PCCashOutViewController alloc] init];
                cashOutVC.cashOutValue = [NSString stringWithFormat:@"%@",self.incomeCenterModel.Income];
                [self.navigationController pushViewController:cashOutVC animated:YES];
            }
                break;
            case 1:
            {
                PCMyCashOutRecordViewController *myCashOutRecordVC = [[PCMyCashOutRecordViewController alloc] init];
                [self.navigationController pushViewController:myCashOutRecordVC animated:YES];
            }
                break;
            default:
                break;
        }
        
    };
    
    self.equityCentermainHeadView.profitClickBlock = ^(NSArray * _Nonnull profitArr, NSInteger index) {
        @strongify(self);
        PCProfitViewController *profitVC = [[PCProfitViewController alloc] init];
        if (profitArr.count == 3) {
            switch (index) {
                case 0:
                    profitVC.profitType = ProfitTypeDirectSaleIncome;
                    break;
                case 1:
                    profitVC.profitType = ProfitTypeTeamIncome;
                    break;
                case 2:
                    profitVC.profitType = ProfitTypeFissionIncome;
                    break;
                default:
                    break;
            }
        } else if (profitArr.count == 5) {
            switch (index) {
                case 0:
                    profitVC.profitType = ProfitTypeDirectSaleIncome;
                    break;
                case 1:
                    profitVC.profitType = ProfitTypeTeamIncome;
                    break;
                case 2:
                    profitVC.profitType = ProfitTypeCityIncome;
                    break;
                case 3:
                    profitVC.profitType = ProfitTypeDevelopIncome;
                    break;
                case 4:
                    profitVC.profitType = ProfitTypeFissionIncome;
                    break;
                default:
                    break;
            }
        }
        [self.navigationController pushViewController:profitVC animated:YES];
    };
    
    self.equityCenterMainView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        if (indexPath.row == 0) {
            PCMyTeamViewController *myTeamVC = [[PCMyTeamViewController alloc] init];
            myTeamVC.userLevel = self.incomeCenterModel.UserGrade;
            [self.navigationController pushViewController:myTeamVC animated:YES];
        } else if (indexPath.row == 1) {
            PCMyBankCardViewController *myBankCardVC = [[PCMyBankCardViewController alloc] init];
            [self.navigationController pushViewController:myBankCardVC animated:YES];
        }
    };
    
}

- (void)getIncomeCenterData {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    [[self.personalCenterVM.GetIncomeCenter execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            self.incomeCenterModel = [IncomeCenterModel mj_objectWithKeyValues:x[@"Data"]];
            self.equityCentermainHeadView.incomeModel = self.incomeCenterModel;
            
            NSArray *dataArr = [[NSArray alloc] initWithObjects:@{@"imageName":@"myTeam",@"title":@"我的团队",@"value":[NSString stringWithFormat:@"%ld",self.incomeCenterModel.TeamMemberCount]},@{@"imageName":@"bankCard",@"title":@"我的银行卡",@"value":@""}, nil];
            self.equityCenterMainView.dataArr = [dataArr mutableCopy];
            [self creatfooterViews];
            [self.equityCenterMainView reloadData];
        }
    }];
}

- (void)creatfooterViews {
    [self.equityCentermainFootView addSubview:self.titleLabel];
    PCEquityCenterMainFootSubView *footSubView1 = [[PCEquityCenterMainFootSubView alloc] init];
    [self.equityCentermainFootView addSubview:footSubView1];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@12);
        make.left.equalTo(@16);
        make.right.equalTo(@(-12));
        make.height.equalTo(@17);
    }];
    
    [footSubView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.left.equalTo(@15);
        make.height.equalTo(@71);
        make.width.equalTo(@(KSCREEN_WIDTH/2 - 15));
    }];
    
    PCEquityCenterMainFootSubView *footSubView2 = [[PCEquityCenterMainFootSubView alloc] init];
    [self.equityCentermainFootView addSubview:footSubView2];
    [footSubView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
        make.right.equalTo(@(-10));
        make.height.equalTo(@71);
        make.width.equalTo(@(KSCREEN_WIDTH/2 - 15));
    }];
    
    footSubView2.identifitext = @"发展消费代言人";
    if ([self.incomeCenterModel.UserGrade isEqualToString:@"A"]) {
        footSubView1.identifitext = @"发展城市合伙人";
    }
    
    if ([self.incomeCenterModel.UserGrade isEqualToString:@"B"]) {
        footSubView1.identifitext = @"发展推广合伙人";
    }
    
    if ([self.incomeCenterModel.UserGrade isEqualToString:@"C"]) {
        footSubView1.identifitext = @"发展消费代言人";
        footSubView2.hidden = YES;
    }
    
    self.equityCenterMainView.tableFooterView = self.equityCentermainFootView;
    
    @weakify(self);
    footSubView1.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        if (index == 0) {
            //发送链接给好友
            [self sendLinkToWX:1];
        } else if (index == 1) {
            //生成二维码
            [self generatExtendQR:1];
        }
    };
    
    footSubView2.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        if (index == 0) {
            //发送链接给好友
            [self sendLinkToWX:2];
        } else if (index == 1) {
            //生成二维码
            [self generatExtendQR:2];
        }
    };
}

#pragma mark -- 发送链接给好友
- (void)sendLinkToWX:(NSInteger)index {
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
    req.bText = NO;
    req.scene = WXSceneSession;// 分享到会话
    WXMediaMessage *medMessage = [WXMediaMessage message];
    WXWebpageObject *webPageObj = [WXWebpageObject object];
    if ([self.incomeCenterModel.UserGrade isEqualToString:@"C"]) {
        webPageObj.webpageUrl = self.incomeCenterModel.ExtensionLink;
    } else if (![self.incomeCenterModel.UserGrade isEqualToString:@"C"] && index == 1) {
        webPageObj.webpageUrl = self.incomeCenterModel.DevelopLink;
    } else if (![self.incomeCenterModel.UserGrade isEqualToString:@"C"] && index == 2) {
        webPageObj.webpageUrl = self.incomeCenterModel.ExtensionLink;
    }
    medMessage.mediaObject = webPageObj;
    req.message = medMessage;
    [WXApi sendReq:req];
}

#pragma mark -- 生成二维码
- (void)generatExtendQR:(NSInteger)index {
    self.qrCodeView = [[PCDevelopQRView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT)];
    if ([self.incomeCenterModel.UserGrade isEqualToString:@"C"]) {
        self.qrCodeView.codeStr = self.incomeCenterModel.ExtensionQRCode;
    } else if (![self.incomeCenterModel.UserGrade isEqualToString:@"C"] && index == 1) {
        self.qrCodeView.codeStr = self.incomeCenterModel.DevelopQRCode;
    } else if (![self.incomeCenterModel.UserGrade isEqualToString:@"C"] && index == 2) {
        self.qrCodeView.codeStr = self.incomeCenterModel.ExtensionQRCode;
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.qrCodeView];
    
    @weakify(self);
    self.qrCodeView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        [self.qrCodeView removeFromSuperview];
        self.qrCodeView = nil;
    };
}

#pragma mark -- 懒加载
- (PCEquityCenterMainView *)equityCenterMainView {
    if (!_equityCenterMainView) {
        _equityCenterMainView = [[PCEquityCenterMainView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStyleGrouped];
    }
    return _equityCenterMainView;
}

- (PCEquityCenterMainHeadView *)equityCentermainHeadView {
    if (!_equityCentermainHeadView) {
        _equityCentermainHeadView = [[PCEquityCenterMainHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 135)];
    }
    return _equityCentermainHeadView;
}

- (UIView *)equityCentermainFootView {
    if (!_equityCentermainFootView) {
        _equityCentermainFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 115)];
    }
    return _equityCentermainFootView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"发展合伙人";
        _titleLabel.textColor = KHEXRGB(0x1A1A1A);
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    return _titleLabel;
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

- (void)dealloc {
    [KNotificationCenter removeObserver:self];
}

@end
