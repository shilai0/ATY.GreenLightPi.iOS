//
//  PCRebindToRetrievePWViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/16.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCRebindToRetrievePWViewController.h"
#import "PCRebindCardView.h"
#import "BaseFormModel.h"
#import "PersonalCenterViewModel.h"
#import "RLLoginRegisterViewModel.h"
#import "PCSendCodeViewController.h"
#import "MyCardModel.h"

@interface PCRebindToRetrievePWViewController ()
@property (nonatomic, strong) PCRebindCardView *rebindCardView;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) UIView *footerBackView;
@property (nonatomic, strong) UIButton *nextBtn;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, strong) PersonalCenterViewModel *peraonalCenterVM;
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegisterVM;
@end

@implementation PCRebindToRetrievePWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0
                      leftBlock:^{
                          @strongify(self);
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
    [self aty_setCenterNavItemtitle:@"找回密码" titleColor:0x333333];
    
    [self creatRebindViews];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self.view addGestureRecognizer:tap];
}

- (void)creatRebindViews {
    [self.footerBackView addSubview:self.nextBtn];
    self.rebindCardView.tableFooterView = self.footerBackView;
    [self.view addSubview:self.rebindCardView];
    NSString *plistStr = NSLocalizedString(@"PCRebindCard.plist", nil);
    self.dataArr = [BaseFormModel xs_getDataWithPlist:plistStr];
    [self pc_insertData:self.dataArr];
    
    @weakify(self);
    [[self.nextBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self nextBtnAction];
    }];
}

- (void)pc_insertData:(NSMutableArray *)dataArr {
    BaseFormModel *model = [dataArr firstObject];
    BaseDetailFormModel *nameModel = [model.itemsArr firstObject];
    NSString *defaultStr = [self.selectBankModel.BankTrueName stringByReplacingOccurrencesOfString:[self.selectBankModel.BankTrueName substringToIndex:self.selectBankModel.BankTrueName.length - 1] withString:@"*"];
    nameModel.placeholder = [NSString stringWithFormat:@"%@(请输入完整姓名)",defaultStr];
    
    BaseFormModel *model1 = [dataArr objectAtIndex:1];
    BaseDetailFormModel *bankCardModel = [model1.itemsArr firstObject];
    bankCardModel.placeholder = [NSString stringWithFormat:@"%@(请输入完整卡号)",self.selectBankModel.CardNumber];
    
    self.dataArr = dataArr;
    self.rebindCardView.dataArr = self.dataArr;
    [self.rebindCardView reloadData];
}

- (void)nextBtnAction {
    [self.rebindCardView endEditing:YES];
    if (![self checkBankCardParamsStr]) {
        return;
    }
    
    self.params[@"UserId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    self.params[@"BankCardId"] = [NSNumber numberWithInteger:self.selectBankModel.BankId];
    @weakify(self);
    [[self.peraonalCenterVM.ForgetDrawMoneyPassword execute:self.params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            if ([x[@"Msg"][@"code"] integerValue] == 1000) {
                //信息校验成功，调用发送验证码到预留手机号码的接口（type传12）
                [self sendMessage];
            }
        }
    }];
}

- (void)sendMessage {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"phone"] = self.params[@"Phone"];
    params[@"smsType"] = [NSNumber numberWithInteger:12];
    @weakify(self);
    [[self.loginRegisterVM.getVerificationCodeCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
//        if (x != nil) {
//            PCSendCodeViewController *sendCodeVC = [[PCSendCodeViewController alloc] init];
//            sendCodeVC.phoneStr = self.params[@"Phone"];
//            sendCodeVC.params = self.params;
//            sendCodeVC.sendMessageType = SendMessageTypeResetPassWord;
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
            sendCodeVC.sendMessageType = SendMessageTypeResetPassWord;
            [self.navigationController pushViewController:sendCodeVC animated:YES];
        }
    }];
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
    [self.params setObject:idCardModel.text forKey:@"IdCardNo"];
    
    BaseFormModel *model1 = [self.dataArr objectAtIndex:1];
    NSArray *detailModelArr1 = model1.itemsArr;
    BaseDetailFormModel *cardNoModel = [detailModelArr1 firstObject];
    NSString *cardStr =  [cardNoModel.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![self checkCardNo:cardStr]) {
        [ATYToast aty_bottomMessageToast:@"请输入正确的银行账号"];
        isTure = NO;
        return isTure;
    }
    [self.params setObject:cardStr forKey:@"CardNumber"];
    
    
    BaseDetailFormModel *phoneModel = [detailModelArr1 objectAtIndex:1];
    if (![ATYUtils isMobileNumber:phoneModel.text]) {
        [ATYToast aty_bottomMessageToast:@"请输入正确的手机号码"];
        isTure = NO;
        return isTure;
    }
    [self.params setObject:phoneModel.text forKey:@"Phone"];
    
    return isTure;
}

- (void)tap
{
    [self.rebindCardView endEditing:YES];
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


- (PCRebindCardView *)rebindCardView {
    if (!_rebindCardView) {
        _rebindCardView = [[PCRebindCardView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStyleGrouped];
    }
    return _rebindCardView;
}

- (UIView *)footerBackView {
    if (!_footerBackView) {
        _footerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 100)];
    }
    return _footerBackView;
}

- (UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 30, KSCREEN_WIDTH - 120, 50)];
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

- (PersonalCenterViewModel *)peraonalCenterVM {
    if (!_peraonalCenterVM) {
        _peraonalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _peraonalCenterVM;
}

- (RLLoginRegisterViewModel *)loginRegisterVM {
    if (!_loginRegisterVM) {
        _loginRegisterVM = [[RLLoginRegisterViewModel alloc] init];
    }
    return _loginRegisterVM;
}

@end
