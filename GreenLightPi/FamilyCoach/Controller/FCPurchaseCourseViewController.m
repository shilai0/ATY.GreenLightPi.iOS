//
//  FCPurchaseCourseViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/11.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCPurchaseCourseViewController.h"
#import "FCPurchaseTableView.h"
#import "FCPurchaseModel.h"
#import "FamilyCoachViewModel.h"
#import "FcCoursesModel.h"
#import "FCAddPayModel.h"
#import <AlipaySDK/AlipaySDK.h>
#import <WechatOpenSDK/WXApiObject.h>
#import <WechatOpenSDK/WXApi.h>
#import "FCPurchaseTableHeadView.h"

@interface FCPurchaseCourseViewController ()
@property (nonatomic, strong) FCPurchaseTableView *purchaseView;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) FamilyCoachViewModel *familyCoachVM;
@property (nonatomic, strong) FCPurchaseTableHeadView *purchaseHeadView;
@property (nonatomic, assign) NSInteger selectRow;
@end

@implementation FCPurchaseCourseViewController

- (FamilyCoachViewModel *)familyCoachVM {
    if (_familyCoachVM == nil) {
        _familyCoachVM = [[FamilyCoachViewModel alloc] init];
    }
    return _familyCoachVM;
}

- (FCPurchaseTableHeadView *)purchaseHeadView {
    if (!_purchaseHeadView) {
        _purchaseHeadView = [[FCPurchaseTableHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 119)];
    }
    return _purchaseHeadView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"购买课程" titleColor:0x333333];
    [self fc_creatPurchaseViews];
}

- (void)fc_creatPurchaseViews {
    self.purchaseView = [[FCPurchaseTableView alloc] initWithFrame:CGRectMake(0, 72, KSCREEN_WIDTH, KSCREENH_HEIGHT - 100 - 72) style:UITableViewStylePlain];
    self.purchaseHeadView.coursesModel = self.coursesModel;
    self.purchaseView.tableHeaderView = self.purchaseHeadView;
    [self.view addSubview:self.purchaseView];
    
    NSMutableArray *muArr = [[NSMutableArray alloc] initWithObjects:@{@"imageName":@"fc_wachat",@"title":@"微信支付  ",@"isSelect":@1},@{@"imageName":@"fc_alipay",@"title":@"支付宝支付",@"isSelect":@0}, nil];
    NSArray *modelArr = [FCPurchaseModel mj_objectArrayWithKeyValuesArray:muArr];
    self.purchaseView.dataArr = [modelArr mutableCopy];
    [self.purchaseView reloadData];
    
    @weakify(self);
    self.purchaseView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        FCPurchaseModel *currentModel = dataArr[indexPath.row];
        self.selectRow = indexPath.row + 1;
        for (FCPurchaseModel *model in dataArr) {
            if (![currentModel isEqual:model]) {
                model.isSelect = NO;
                currentModel.isSelect = YES;
            }
        }
        [self.purchaseView reloadData];
    };
    
    self.sureButton = [UIButton new];
    [self.sureButton setBackgroundColor:KHEXRGB(0x44C08C)];
    [self.sureButton setTitle:@"确认支付" forState:UIControlStateNormal];
    [self.sureButton setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
    self.sureButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:self.sureButton];

    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@49);
    }];
    
    [[self.sureButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        /**
         user_id (integer, optional): 下单用户 ,
         courses_id (integer, optional): 课程编号 ,
         price (number, optional): 课程价格 ,
         integral (integer, optional): 积分 ,
         order_no (string, optional): 订单编号 ,
         consumptionType (integer, optional): 消费方式 = ['1'金钱, '2'积分, '3'免费, '4'积分抵扣一部分],
         payTypeEnum (integer, optional): 支付方式 = ['1'微信, '2'支付宝, '3'积分(积分和免费)],
         spbill_create_ip (string, optional): 终端IP ,
         body (string, optional): 订单描述 ,
         subject (string, optional): 订单标题 ,
         orderSources (integer, optional): 订单来源 1安卓 2ios
         **/
        NSMutableDictionary *orderParams = [[NSMutableDictionary alloc] init];
        orderParams[@"user_id"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
        orderParams[@"courses_id"] = self.coursesModel.courses_id;
        orderParams[@"price"] = self.coursesModel.price;
        orderParams[@"integral"] = self.coursesModel.integral;
        orderParams[@"order_no"] = @"";
        orderParams[@"consumptionType"] = @1;
        orderParams[@"payTypeEnum"] = self.selectRow ? [NSNumber numberWithInteger:self.selectRow] : [NSNumber numberWithInteger:1];
        orderParams[@"body"] = self.coursesModel.title;
        orderParams[@"subject"] = [NSString stringWithFormat:@"一家老小_购买%@",self.coursesModel.title];
        orderParams[@"orderSources"] = @2;
        @weakify(self);
        [[self.familyCoachVM.PlaceAnOrderCommand execute:orderParams] subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if (x != nil) {
                FCAddPayModel *payModel = [FCAddPayModel mj_objectWithKeyValues:x[@"Data"]];
                [self fc_payOrder:payModel];
            }
        }];
    }];
    
}

#pragma mark -- 下单成功，调起支付
- (void)fc_payOrder:(FCAddPayModel *)payModel {
    if ([payModel.payType integerValue] == 1) {//微信支付
        PayReq *req = [[PayReq alloc] init];
        AwakenMos *wxModel = payModel.wxAddPay;
        req.openID = wxModel.appid;
        req.partnerId = wxModel.partnerid;
        req.prepayId= wxModel.prepayid;
        req.package = @"Sign=WXPay";
        req.nonceStr = wxModel.noncestr;
        req.timeStamp= [wxModel.timestamp intValue];
        req.sign= wxModel.sign;
        [WXApi sendReq:req];
    } else if ([payModel.payType integerValue] == 2) {//支付宝支付
        //包含订单信息和签名（服务器端返回）
        NSString *signedString = payModel.zfbSigmStr.signStr;
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"alisdkGreenLightPi";
        
        //     NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:signedString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            /**
             result = {
             memo = "";
             result = "{\"alipay_trade_app_pay_response\":{\"code\":\"10000\",\"msg\":\"Success\",\"app_id\":\"2018061360379278\",\"auth_app_id\":\"2018061360379278\",\"charset\":\"UTF-8\",\"timestamp\":\"2018-07-13 10:33:42\",\"total_amount\":\"0.01\",\"trade_no\":\"2018071321001004350529800754\",\"seller_id\":\"2088131506762346\",\"out_trade_no\":\"K180713103316193907\"},\"sign\":\"lpjyPLlirXSzM10iHNdYfRvqallZWWwousPJX1YkrQ0EPAfPiymgAwjQlAnPgqL5+EF63aW+bDR9TjDarM5m8ecdPcawpp9K4GQZIfzq8yCh6bIa5L9wAqEz0eonTgaUcAsRQpU1e/vMi4Epq9vX0e2xDkPxCMc0jJVD1kJk3QsDCRtZcFYfXjN/svoM2vPyQ60D5Bopyz3N0j6Jen5PV8JPWULlCt0E/E6xILfMWn/gqiMLvIpvMiVYduWDEthay0H5yLQrObVbw5IQgC+4N3QTBzwlsEnZV9upV9VOTbQJB1hrncZH4BtoDJ3WABA9G/2XP2Dn9YQiYW+NVjEwLg==\",\"sign_type\":\"RSA2\"}";
             resultStatus = 9000;
             }
             **/
            NSLog(@"aaaaaaaaaaaaaareslut = %@",resultDic);
            
        }];
    }
    
}

@end
