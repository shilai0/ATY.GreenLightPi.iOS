//
//  PCAddBankCardViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/11.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCAddBankCardViewController.h"
#import "BaseFormModel.h"
#import "PCAddBankCardView.h"
#import "PersonalCenterViewModel.h"
#import "UIButton+Common.h"
#import "RLLoginRegisterViewModel.h"
#import "PCSendCodeViewController.h"

@interface PCAddBankCardViewController ()
@property (nonatomic, strong) PCAddBankCardView *addBankCardView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) PersonalCenterViewModel *peraonalCenterVM;
@property (nonatomic, strong) UIView *headBackView;
@property (nonatomic, strong) UILabel *headTipLabel;
@property (nonatomic, strong) UIView *footBackView;
@property (nonatomic, strong) UIButton *agreeBtn;
@property (nonatomic, strong) UILabel *agreementLabel;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign) BOOL keyboardIsVisible;
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegisterVM;
@end

@implementation PCAddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0
                      leftBlock:^{
                          @strongify(self);
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
    
    [self aty_setCenterNavItemtitle:@"添加银行卡" titleColor:0x333333];
    [self pc_creatAddBankCardTableView];
}

- (void)pc_creatAddBankCardTableView {
    [self.view addSubview:self.addBankCardView];
    [self.headBackView addSubview:self.headTipLabel];
    self.addBankCardView.tableHeaderView = self.headBackView;
    [self.footBackView addSubview:self.agreeBtn];
    [self.footBackView addSubview:self.agreementLabel];
    [self.footBackView addSubview:self.nextBtn];
    self.addBankCardView.tableFooterView = self.footBackView;
    NSString *plistStr = NSLocalizedString(@"PCAddBankCard.plist", nil);
    self.dataArr = [BaseFormModel xs_getDataWithPlist:plistStr];
    self.addBankCardView.dataArr = self.dataArr;
    [self.addBankCardView reloadData];
    
    @weakify(self);
    [[self.agreeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self agreeBtnAction:x];
    }];
    
    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self nextBtnAction];
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapShadowViewClick:)];
    [self.view addGestureRecognizer:tap];
}

- (void)nextBtnAction {
    if (![self checkBankCardParamsStr]) {
        return;
    }

    self.params[@"UserId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    
    @weakify(self);
    [[self.peraonalCenterVM.CreateBankCard execute:self.params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            if ([x[@"Msg"][@"code"] integerValue] == 1000) {
                //信息校验成功，调用发送验证码到预留手机号码的接口（type传11）
                [self sendMessage];
            }
        }
    }];
}

- (void)sendMessage {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = self.params[@"Phone"];
    params[@"smsType"] = [NSNumber numberWithInteger:11];
    @weakify(self);
    [[self.loginRegisterVM.getVerificationCodeCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
//        if (x != nil) {
//            PCSendCodeViewController *sendCodeVC = [[PCSendCodeViewController alloc] init];
//            sendCodeVC.phoneStr = self.params[@"Phone"];
//            sendCodeVC.params = self.params;
//            if (self.addBankCardType == AddBankCardTypeForRessetPassword) {
//                sendCodeVC.sendMessageType = SendMessageTypeAddResetPasssWord;
//            } else if (self.addBankCardType == AddBankCardTypeSelectBankCard) {
//                sendCodeVC.sendMessageType = SendMessageTypeSelectBankCard;
//            }
//            [ATYToast aty_bottomMessageToast:@"验证码发送成功"];
//            [self.navigationController pushViewController:sendCodeVC animated:YES];
//        }
        
        NSString *message = x[@"Msg"][@"message"];
        NSNumber *success = x[@"Success"];
        if (message.length > 0) {
            [ATYToast aty_bottomMessageToast:message];
        }
        if ([success boolValue]) {
            PCSendCodeViewController *sendCodeVC = [[PCSendCodeViewController alloc] init];
            sendCodeVC.phoneStr = self.params[@"Phone"];
            sendCodeVC.params = self.params;
            if (self.addBankCardType == AddBankCardTypeForRessetPassword) {
                sendCodeVC.sendMessageType = SendMessageTypeAddResetPasssWord;
            } else if (self.addBankCardType == AddBankCardTypeSelectBankCard) {
                sendCodeVC.sendMessageType = SendMessageTypeSelectBankCard;
            }
            [self.navigationController pushViewController:sendCodeVC animated:YES];
        }
        
    }];
}

- (void)agreeBtnAction:(UIButton *)agreeBtn {
    agreeBtn.selected = !agreeBtn.selected;
    if (agreeBtn.selected) {
        [agreeBtn setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
        _nextBtn.enabled = YES;
        _nextBtn.alpha = 1;
    } else {
        [agreeBtn setImage:[UIImage imageNamed:@"noAgree"] forState:UIControlStateNormal];
        _nextBtn.enabled = NO;
        _nextBtn.alpha = 0.8;
    }
}

#pragma mark -- 隐藏
- (void)tapShadowViewClick:(UITapGestureRecognizer *)tap
{
    if (self.keyboardIsVisible) {
        [self.view endEditing:YES];
    } else {
        
    }
}

#pragma mark -- 校验字段
- (BOOL)checkBankCardParamsStr {
    BOOL isTure = YES;
    BaseFormModel *model = [self.dataArr firstObject];
    NSArray *detailModelArr = model.itemsArr;
    
    BaseDetailFormModel *nameModel = [detailModelArr firstObject];
    if (nameModel.text.length == 0) {
        [ATYToast aty_bottomMessageToast:@"请输入持卡人姓名"];
        isTure = NO;
        return isTure;
    }
    [self.params setObject:nameModel.text forKey:@"Name"];
    
    BaseDetailFormModel *idCardModel = [detailModelArr objectAtIndex:1];
    if (idCardModel.text.length == 0 || ![ATYUtils checkUserIdCard:idCardModel.text]) {
        [ATYToast aty_bottomMessageToast:@"请输入正确的身份证号码"];
        isTure = NO;
        return isTure;
    }
    [self.params setObject:idCardModel.text forKey:@"IDCardNo"];
    
    BaseDetailFormModel *cardNoModel = [detailModelArr objectAtIndex:2];
    if (![self checkCardNo:cardNoModel.text]) {
        [ATYToast aty_bottomMessageToast:@"请输入正确的银行账号"];
        isTure = NO;
        return isTure;
    }
    [self.params setObject:cardNoModel.text forKey:@"CardNumber"];
    
    BaseDetailFormModel *bankNameModel = [detailModelArr objectAtIndex:3];
    if (bankNameModel.text.length == 0) {
        [ATYToast aty_bottomMessageToast:@"请输入开户银行"];
        isTure = NO;
        return isTure;
    }
    [self.params setObject:bankNameModel.text forKey:@"BankName"];
    
    BaseDetailFormModel *phoneModel = [detailModelArr objectAtIndex:4];
    if (![ATYUtils isMobileNumber:phoneModel.text]) {
        [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码"];
        isTure = NO;
        return isTure;
    }
    [self.params setObject:phoneModel.text forKey:@"Phone"];
    
    return isTure;
}

#pragma mark -- 校验银行账号
- (BOOL) checkCardNo:(NSString*) cardNo{
    if (cardNo.length<15) {
        return NO;
    }
    int oddsum = 0;     //奇数求和
    int evensum = 0;    //偶数求和
    int allsum = 0;
    int cardNoLength = (int)[cardNo length];
    int lastNum = [[cardNo substringFromIndex:cardNoLength-1] intValue];
    
    cardNo = [cardNo substringToIndex:cardNoLength - 1];
    for (int i = cardNoLength -1 ; i>=1;i--) {
        NSString *tmpString = [cardNo substringWithRange:NSMakeRange(i-1, 1)];
        int tmpVal = [tmpString intValue];
        if (cardNoLength % 2 ==1 ) {
            if((i % 2) == 0){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }else{
            if((i % 2) == 1){
                tmpVal *= 2;
                if(tmpVal>=10)
                    tmpVal -= 9;
                evensum += tmpVal;
            }else{
                oddsum += tmpVal;
            }
        }
    }
    
    allsum = oddsum + evensum;
    allsum += lastNum;
    if((allsum % 10) == 0)
        return YES;
    else
        return NO;
}

#pragma mark -- 键盘
- (void)keyboardDidShow
{
    self.keyboardIsVisible = YES;
}

- (void)keyboardDidHide
{
    self.keyboardIsVisible = NO;
}


#pragma mark -- 懒加载
- (PCAddBankCardView *)addBankCardView {
    if (!_addBankCardView) {
        _addBankCardView = [[PCAddBankCardView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStyleGrouped];
    }
    return _addBankCardView;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

- (PersonalCenterViewModel *)peraonalCenterVM {
    if (!_peraonalCenterVM) {
        _peraonalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _peraonalCenterVM;
}

- (UIView *)headBackView {
    if (!_headBackView) {
        _headBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 50)];
    }
    return _headBackView;
}

- (UILabel *)headTipLabel {
    if (!_headTipLabel) {
        _headTipLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, KSCREEN_WIDTH - 25, 50)];
        _headTipLabel.text = @"提醒：后续只能绑定该持卡人的银行卡";
        _headTipLabel.textColor = KHEXRGB(0xF37065);
        _headTipLabel.font = [UIFont systemFontOfSize:15];
    }
    return _headTipLabel;
}

- (UIView *)footBackView {
    if (!_footBackView) {
        _footBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 110)];
    }
    return _footBackView;
}

- (UIButton *)agreeBtn {
    if (!_agreeBtn) {
        _agreeBtn = [[UIButton alloc] initWithFrame:CGRectMake(15, 10, 55, 14)];
        [_agreeBtn setTitle:@"同意" forState:UIControlStateNormal];
        [_agreeBtn setTitleColor:KHEXRGB(0x333333) forState:UIControlStateNormal];
        [_agreeBtn setImage:[UIImage imageNamed:@"agree"] forState:UIControlStateNormal];
        _agreeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_agreeBtn xs_layoutButtonWithButtonEdgeInsetsStyle:ButtonEdgeInsetsStyleLeft WithImageAndTitleSpace:5];
        _agreeBtn.selected = YES;
    }
    return _agreeBtn;
}

- (UILabel *)agreementLabel {
    if (!_agreementLabel) {
        _agreementLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 10, 150, 14)];
        _agreementLabel.font = [UIFont systemFontOfSize:15];
        _agreementLabel.textColor = KHEXRGB(0x333333);
        NSString *defaultStr = @"《用户服务协议》";
        NSMutableAttributedString *mutableAttriteStr = [[NSMutableAttributedString alloc] initWithString:defaultStr];
        //设置颜色
        [mutableAttriteStr addAttribute:NSForegroundColorAttributeName value:KHEXRGB(0xF37065) range:NSMakeRange(1, defaultStr.length - 2)]; // 0为起始位置 length是从起始位置开始 设置指定颜色的长度
        _agreementLabel.attributedText = mutableAttriteStr;
    }
    return _agreementLabel;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(56, 50, KSCREEN_WIDTH - 120, 50)];
        [_nextBtn setBackgroundImage:[UIImage imageNamed:@"nextBack"] forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _nextBtn;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [[NSMutableDictionary alloc] init];
    }
    return _params;
}

- (RLLoginRegisterViewModel *)loginRegisterVM {
    if (!_loginRegisterVM) {
        _loginRegisterVM = [[RLLoginRegisterViewModel alloc] init];
    }
    return _loginRegisterVM;
}

@end
