//
//  HMFamilyDetailViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/9.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMFamilyDetailViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "HMSelectFamilyViewController.h"
#import "HMManageFamilyViewController.h"
#import "HMFamilyDetailFooterView.h"
#import "HMFamilyDetailCell.h"
#import <WechatOpenSDK/WXApiObject.h>
#import <WechatOpenSDK/WXApi.h>
#import "HMRelationView.h"
#import "FamilyApiModel.h"
#import "HomeViewModel.h"

@interface HMFamilyDetailViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *familyDetailView;
@property (nonatomic, strong) HomeViewModel *homeVM;
@property (nonatomic, strong) HMRelationView *relationView;
@property (nonatomic, assign) BOOL keyBoardlsVisible;
@property (nonatomic, strong) UITapGestureRecognizer *tap;
@end

@implementation HMFamilyDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar=NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar=YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // 添加通知监听见键盘弹出/退出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAction:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"邀请家人" titleColor:0x333333];
    
    if (self.isCreater) {
        NSMutableArray *memberArr = [[NSMutableArray alloc] initWithArray:[self.dataArray firstObject]];
        [memberArr enumerateObjectsUsingBlock:^(FamilyMemberApiModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.userId == [[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID] integerValue]) {
                [memberArr removeObject:obj];
                *stop = YES;
            }
        }];
        if (memberArr.count > 0) {
            [self aty_setRightNavItemImg:nil title:@"管理" titleColor:0x333333 rightBlock:^{
                HMManageFamilyViewController *managerFamilyVC = [[HMManageFamilyViewController alloc] init];
                managerFamilyVC.familyMemberArr = memberArr;
                [self.navigationController pushViewController:managerFamilyVC animated:YES];
            }];
        }
    }
    
    self.keyBoardlsVisible = NO;
    [self familyDetailView];
    [self.familyDetailView addSubview:self.relationView];
    [self.relationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(60);
        make.height.equalTo(@60);
    }];
    
    self.relationView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        if (self.relationView.relationTextField.text.length == 0) {
            [ATYToast aty_bottomMessageToast:@"请输入被邀请人与宝宝的关系！"];
            return ;
        }
        [self.relationView.relationTextField resignFirstResponder];
        [self inivateAction:nil];
    };
    
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    if (self.keyBoardlsVisible) {
        [self.relationView.relationTextField resignFirstResponder];
    }
}

#pragma mark -UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataArray.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HMFamilyDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HMFamilyDetailCell" forIndexPath:indexPath];
    cell.memberModel = self.dataArray[indexPath.section][indexPath.row];
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:@"UICollectionElementKindSectionFooter"]) {
        if (indexPath.section == (self.dataArray.count - 1)) {
            HMFamilyDetailFooterView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HMFamilyDetailFooterView" forIndexPath:indexPath];
            if (self.isCreater) {
                reusableView.otherBtn.hidden = YES;
            } else {
                reusableView.otherBtn.hidden = NO;
            }
            @weakify(self);
            reusableView.invitationBlock = ^(NSInteger index) {
                @strongify(self);
                switch (index) {
                    case 0://邀请
                    {
                        [self.relationView.relationTextField becomeFirstResponder];
                    }
                        break;
                    case 1://退出家庭组
                    {
                        [self quitFamilyAction];
                    }
                        break;
                    default:
                        break;
                }
            };
            return reusableView;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == (self.dataArray.count - 1)) {
        return CGSizeMake(KSCREEN_WIDTH, 180);
    } else {
        return CGSizeZero;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.keyBoardlsVisible && indexPath.section == (self.dataArray.count - 1)) {
        [self inivateAction:self.dataArray[indexPath.section][indexPath.item]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(68, 90);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(20, 20, 30, 20);
}

#pragma mark -- 邀请
- (void)inivateAction:(FamilyMemberApiModel *)memberModel {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (memberModel == nil) {
        FamilyMemberApiModel *defaultModel = [[self.dataArray firstObject] firstObject];
        params[@"familyId"] = [NSNumber numberWithInteger:defaultModel.familyId];
        params[@"relationCode"] = @"other";
        params[@"relationRemark"] = self.relationView.relationTextField.text;
    } else {
        params[@"familyId"] = [NSNumber numberWithInteger:memberModel.familyId];
        params[@"relationCode"] = memberModel.relationCode;
        params[@"relationRemark"] = memberModel.relationRemark;
    }
    
    srand((unsigned)time(0));
    NSInteger i = rand();
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    NSInteger userId = [[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID] integerValue];
    params[@"guidCode"] = [NSString stringWithFormat:@"%ld%ld",(long)i,(long)userId];
    
    @weakify(self);
    [[self.homeVM.InviteFamilyMemberCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            __block NSString *descriptionStr = @"";
            [[self.dataArray firstObject] enumerateObjectsUsingBlock:^(FamilyMemberApiModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSInteger userId = [[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID] integerValue];
                if (obj.userId == userId) {
                    descriptionStr = obj.name;
                    if (obj.name.length == 0) {
                        descriptionStr = @"您的好友";
                    }
                }
            }];
            
            SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
            req.bText = NO;
            req.scene = WXSceneSession;// 分享到会话
            WXMediaMessage *medMessage = [WXMediaMessage message];
            WXWebpageObject *webPageObj = [WXWebpageObject object];
            medMessage.title = @"来自一家老小的邀请"; // 标题
            medMessage.description = [NSString stringWithFormat:@"%@邀请您一起加入他的大家庭",descriptionStr];// 描述
            UIImage *thumbImage = [self compressImage:[UIImage imageNamed:@"fs_shareBind"] toByte:32768];
            [medMessage setThumbImage:thumbImage];
            webPageObj.webpageUrl = [NSString stringWithFormat:@"http://garden.aiteyou.net/h5/invitation/index.html?guidCode=%@&name=%@",[self utf8ToUnicode:[NSString stringWithFormat:@"%ld%ld",(long)i,(long)userId]],[self utf8ToUnicode:descriptionStr]];
            medMessage.mediaObject = webPageObj;
            req.message = medMessage;
            [WXApi sendReq:req];
        } else {
            [ATYToast aty_bottomMessageToast:@"邀请发送失败！"];
            return ;
        }
    }];
    
}

#pragma mark -- 退出家庭组
- (void)quitFamilyAction {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    FamilyMemberApiModel *defaultModel = [[self.dataArray firstObject] firstObject];
    params[@"familyId"] = [NSNumber numberWithInteger:defaultModel.familyId];
    params[@"quitUserIds"] = [NSArray arrayWithObject:[[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID]];
    @weakify(self);
    [[self.homeVM.QuitCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            for (UIViewController *vc in self.navigationController.viewControllers) {
                if ([vc isKindOfClass:[HMSelectFamilyViewController class]]) {
                    [KNotificationCenter postNotificationName:DELETEFAMILYMEMBER_NOTIFICATION object:nil];
                    HMSelectFamilyViewController *viewController = (HMSelectFamilyViewController *)vc;
                    [self.navigationController popToViewController:viewController animated:YES];
                    NSString *message = x[@"Msg"][@"message"];
                    if (message.length > 0) {
                        [ATYToast aty_bottomMessageToast:message];
                    } else {
                        [ATYToast aty_bottomMessageToast:@"操作成功"];
                    }
                }
            }
        }
    }];
}

#pragma mark -- 键盘监听事件
- (void)keyboardAction:(NSNotification*)sender{
    // 通过通知对象获取键盘frame: [value CGRectValue]
    NSDictionary *useInfo = [sender userInfo];
    NSValue *value = [useInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    // <注意>具有约束的控件通过改变约束值进行frame的改变处理
    if([sender.name isEqualToString:UIKeyboardWillShowNotification]){
        self.keyBoardlsVisible = YES;
        [self.relationView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(-([value CGRectValue].size.height));
        }];
        self.tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self.view addGestureRecognizer:self.tap];
    } else {
        [self.view removeGestureRecognizer:self.tap];
        self.keyBoardlsVisible = NO;
        [self.relationView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.view.mas_bottom).offset(60);
        }];
    }
}

#pragma mark -- 转化编码
- (NSString *)utf8ToUnicode:(NSString *)string{
    NSUInteger length = [string length];
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++){
        NSMutableString *s = [NSMutableString stringWithCapacity:0];
        unichar _char = [string characterAtIndex:i];
        // 判断是否为英文和数字
        if (_char <= '9' && _char >='0'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='a' && _char <= 'z'){
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else if(_char >='A' && _char <= 'Z')
        {
            [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
        }else{
            // 中文和字符
            [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
            // 不足位数补0 否则解码不成功
            if(s.length == 4) {
                [s insertString:@"00" atIndex:2];
            } else if (s.length == 5) {
                [s insertString:@"0" atIndex:2];
            }
        }
        [str appendFormat:@"%@", s];
    }
    return str;
    
}

- (UIImage *)compressImage:(UIImage *)image toByte:(NSUInteger)maxLength {
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) return image;
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    UIImage *resultImage = [UIImage imageWithData:data];
    if (data.length < maxLength) return resultImage;
    
    // Compress by size
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return resultImage;
}

-(UICollectionView *)familyDetailView
{
    if (!_familyDetailView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectNull collectionViewLayout:flowLayout];
        [self.view addSubview:collectionView];
        collectionView.backgroundColor = KHEXRGB(0xFFFFFF);
        _familyDetailView = collectionView;
        [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(KNavgationBarHeight));
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        
        [_familyDetailView registerClass:[HMFamilyDetailCell class] forCellWithReuseIdentifier:@"HMFamilyDetailCell"];
        [_familyDetailView registerClass:[HMFamilyDetailFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"HMFamilyDetailFooterView"];
        
        _familyDetailView.delegate = self;
        _familyDetailView.dataSource = self;
        
    }
    return _familyDetailView;
}

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

- (HMRelationView *)relationView {
    if (!_relationView) {
        _relationView = [[HMRelationView alloc] init];
    }
    return _relationView;
}

@end
