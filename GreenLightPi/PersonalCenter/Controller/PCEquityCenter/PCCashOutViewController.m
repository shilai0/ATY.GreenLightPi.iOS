//
//  PCCashOutViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/13.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCCashOutViewController.h"
#import "PCCashOutView.h"
#import "PCSelectBankCardView.h"
#import "ATYCache.h"
#import "MyCardModel.h"
#import "PersonalCenterViewModel.h"
#import "PCSelectCardTableView.h"
#import "PCInputPassWordView.h"
#import "PCCashOutResultViewController.h"
#import "PCSetCashOutPassWordView.h"
#import "ATYAlertViewController.h"
#import "PCForgetPassWordViewController.h"
#import "PCAddBankCardViewController.h"

@interface PCCashOutViewController ()
@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) PCCashOutView *cashOutView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) PCSelectBankCardView *selectBankCardView;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, strong) MyCardModel *selectBankModel;
@property (nonatomic, strong) NSMutableArray *cardArr;
@property (nonatomic, strong) PCInputPassWordView *inputPassWordView;
@end

@implementation PCCashOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.backImageView];
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@200);
    }];
    
    [self creatCashOutViews];
    [self.cashOutView.inputTextField becomeFirstResponder];
    
    @weakify(self);
    [[KNotificationCenter rac_addObserverForName:ADDBANKSUCCASHOUT_NOTIFICATION object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self getCardList];
    }];
}

- (void)creatCashOutViews {
    [self.view addSubview:self.returnBtn];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.cashOutView];
    [self.view addSubview:self.sureBtn];
    
    [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.width.height.equalTo(@28);
        make.top.equalTo(@(28+KTopBarSafeHeight));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(@(33+KTopBarSafeHeight));
        make.height.equalTo(@13);
    }];
    
    [self.cashOutView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(@(KNavgationBarHeight + 50));
        make.height.equalTo(@260);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@60);
        make.right.equalTo(@(-60));
        make.top.equalTo(self.cashOutView.mas_bottom).offset(50);
        make.height.equalTo(@50);
    }];
    
    @weakify(self);
    [[self.returnBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self cashOutAction];
    }];
    
    self.cashOutView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0://选择银行卡
            {
                [self selectBankCard];
            }
                break;
            case 1://全部提现
            {
                [self cashOutAll];
            }
                break;
            case 2://输入提现金额
            {
                if (content1.length > 0) {
                    if ([content1 floatValue] > [self.cashOutValue floatValue]) {
                        self.cashOutView.tipLabel.text = [NSString stringWithFormat:@"输入金额大于最大可提现额度"];
                        self.sureBtn.alpha = 0.8;
                        self.sureBtn.enabled = NO;
                    } else {
                        self.cashOutView.tipLabel.text = [NSString stringWithFormat:@"提现需扣除%.2f税费（税率5%%）",[self.cashOutView.inputTextField.text floatValue]*0.05];
                        self.sureBtn.alpha = 1;
                        self.sureBtn.enabled = YES;
                    }
                } else {
                    self.cashOutView.tipLabel.text = [NSString stringWithFormat:@"可提现余额%.2f",[self.cashOutValue floatValue]];
                }
            }
                break;
                
            default:
                break;
        }
    };
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
    
    self.cashOutView.cashOutValue = self.cashOutValue;
    self.cardArr = [ATYCache readCache:BANKCARDARR];
    if (self.cardArr) {
        if (!self.selectBankModel) {
            MyCardModel *cardModel = [self.cardArr firstObject];
            self.cashOutView.bankNameStr = cardModel.BankName;
            self.selectBankModel = cardModel;
        }
    } else {
        //获取我的银行卡列表
        [self getCardList];
    }
}

- (void)tap
{
    [self.cashOutView endEditing:YES];
}

#pragma mark -- 选择银行卡
- (void)selectBankCard {
    [self.cashOutView.inputTextField resignFirstResponder];
    self.selectBankCardView = [[PCSelectBankCardView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT)];
    for (MyCardModel *cardModel in self.cardArr) {
        if ([cardModel.BankName isEqualToString:self.selectBankModel.BankName]) {
            cardModel.isSelect = YES;
        } else {
            cardModel.isSelect = NO;
        }
    }
    self.selectBankCardView.cardArr = self.cardArr;
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.selectBankCardView];

    @weakify(self);
    self.selectBankCardView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        switch (index) {
            case 0:
            {
                [self.selectBankCardView removeFromSuperview];
                self.selectBankCardView = nil;
            }
                break;
            case 1:
            {
                [self.selectBankCardView removeFromSuperview];
                self.selectBankCardView = nil;
                PCAddBankCardViewController *addBankCardVC = [[PCAddBankCardViewController alloc] init];
                addBankCardVC.addBankCardType = AddBankCardTypeSelectBankCard;
                [self.navigationController pushViewController:addBankCardVC animated:YES];
            }
                break;
            default:
                break;
        }
    };
    
    self.selectBankCardView.selectCardTableView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        MyCardModel *selectCardModel = dataArr[indexPath.row];
        for (MyCardModel *cardModel in dataArr) {
            if (cardModel.BankId == selectCardModel.BankId) {
                cardModel.isSelect = YES;
                self.selectBankModel = cardModel;
                self.cashOutView.bankNameStr = self.selectBankModel.BankName;
            } else {
                cardModel.isSelect = NO;
            }
        }
        [self.selectBankCardView.selectCardTableView reloadData];
    };
}

#pragma mark -- 全部提现
- (void)cashOutAll {
    self.cashOutView.inputTextField.text = [NSString stringWithFormat:@"%.2f",[self.cashOutValue floatValue]];
    self.cashOutView.tipLabel.text = [NSString stringWithFormat:@"提现需扣除%.2f税费（税率5%%）",[self.cashOutValue floatValue]*0.05];
    self.sureBtn.alpha = 1;
    self.sureBtn.enabled = YES;
}

#pragma mark -- 获取我的银行卡列表
- (void)getCardList {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    @weakify(self);
    [[self.personalCenterVM.GetMyBankCard execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            NSMutableArray *dataArr = [MyCardModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
            self.cardArr = dataArr;
            if (!self.selectBankModel) {
                MyCardModel *cardModel = [self.cardArr firstObject];
                self.cashOutView.bankNameStr = cardModel.BankName;
                self.selectBankModel = cardModel;
            }
            [ATYCache saveDataCache:dataArr forKey:BANKCARDARR];
        }
    }];
}

#pragma mark -- 确认提现按钮事件
- (void)cashOutAction {
    [self.cashOutView.inputTextField resignFirstResponder];

    if (self.selectBankModel == nil) {
        [ATYToast aty_bottomMessageToast:@"请选择银行卡"];
        return;
    }
    
    if ([self.cashOutView.inputTextField.text floatValue] > 0) {
        self.inputPassWordView = [[PCInputPassWordView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT)];
        self.inputPassWordView.cashoutValue = self.cashOutView.inputTextField.text;
        [[UIApplication sharedApplication].keyWindow addSubview:self.inputPassWordView];
        
        [self.inputPassWordView.passWordView.textField becomeFirstResponder];
        
        
        UITapGestureRecognizer *tapGestureRecongnizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
        [self.inputPassWordView addGestureRecognizer:tapGestureRecongnizer];
        @weakify(self);
        self.inputPassWordView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
            @strongify(self);
            [self.inputPassWordView removeFromSuperview];
            self.inputPassWordView = nil;
        };
        
        self.inputPassWordView.passWordView.inputFinishBlock = ^(NSString * _Nonnull code, BOOL isSure) {
            @strongify(self);
            [self.inputPassWordView removeFromSuperview];
            self.inputPassWordView = nil;
            [self cashOutToBankCard:code];
        };
    } else {//没有输入提现金额或者输入的提现金额为0
        [ATYToast aty_bottomMessageToast:@"提现金额不能为空或者为0"];
    }
    
}

#pragma mark -- 点击输入密码背景的手势方法
- (void)tapClick {
    [self.inputPassWordView.passWordView.textField resignFirstResponder];
}

#pragma mark -- 键盘
- (void)keyboardDidShow
{
    if (self.inputPassWordView) {
        [self.inputPassWordView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(-60));
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(KSCREENH_HEIGHT));
        }];
    }
}

- (void)keyboardDidHide
{
    if (self.inputPassWordView) {
        [self.inputPassWordView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(KSCREENH_HEIGHT));
        }];
    }
}

#pragma mark -- 提现到银行卡
- (void)cashOutToBankCard:(NSString *)passWordCode {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"amount"] = self.cashOutView.inputTextField.text;
    params[@"bankId"] = [NSNumber numberWithInteger:self.selectBankModel.BankId];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"password"] = passWordCode;

    @weakify(self);
    [[self.personalCenterVM.DrawMoneyToBank execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        NSNumber *code = x[@"Msg"][@"code"];
        NSNumber *success = x[@"Success"];
        if (x != nil && [success boolValue] && [code isEqual:@1000]) {
            //校验成功
            PCCashOutResultViewController *cashOutResultVC = [[PCCashOutResultViewController alloc] init];
            cashOutResultVC.cashoutValue = self.cashOutView.inputTextField.text;
            cashOutResultVC.bankName = self.selectBankModel.BankName;
            [KNotificationCenter postNotificationName:CASHOUTSUCCESS_NOTIFICATION object:nil userInfo:@{@"cashoutValue":[NSString stringWithFormat:@"%.2f",[self.cashOutView.inputTextField.text floatValue]*1.05]}];
            [self.navigationController pushViewController:cashOutResultVC animated:YES];
        } else if (x != nil && [code isEqual:@1004]) {
            //密码错误
            ATYAlertViewController *alertCtrl = [ATYAlertViewController alertControllerWithTitle:nil message:@"支付密码错误，请重试"];
            alertCtrl.messageAlignment = NSTextAlignmentCenter;
            ATYAlertAction *cancelAction = [ATYAlertAction actionWithTitle:@"重试" titleColor:0x1F1F1F handler:^(ATYAlertAction *action) {
                [self cashOutAction];
            }];
            @weakify(self);
            ATYAlertAction *doneAction = [ATYAlertAction actionWithTitle:@"忘记密码" titleColor:0x44C08C handler:^(ATYAlertAction *action) {
                @strongify(self);
                PCForgetPassWordViewController *forgetPassWordVC = [[PCForgetPassWordViewController alloc] init];
                forgetPassWordVC.selectBankModel = self.selectBankModel;
                [self.navigationController pushViewController:forgetPassWordVC animated:YES];
            }];
            
            [alertCtrl addAction:cancelAction];
            [alertCtrl addAction:doneAction];
            [self presentViewController:alertCtrl animated:NO completion:nil];
        }
    }];
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        [_sureBtn setBackgroundImage:[UIImage imageNamed:@"finished"] forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确认提现" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _sureBtn;
}

- (PCCashOutView *)cashOutView {
    if (!_cashOutView) {
        _cashOutView = [[PCCashOutView alloc] init];
    }
    return _cashOutView;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"cashOutBack"];
        _backImageView.backgroundColor = [UIColor orangeColor];
    }
    return _backImageView;
}

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
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"提现";
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
