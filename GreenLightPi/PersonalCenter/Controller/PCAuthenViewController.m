//
//  PCAuthenViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/1.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCAuthenViewController.h"
#import "PCAuthenView.h"
#import "BaseFormModel.h"
#import "PersonalCenterViewModel.h"
#import "PCAuthenFooterView.h"
#import "TZImagePickerController.h"
#import "XSYTapSound.h"
#import "PCAuthenResultViewController.h"

@interface PCAuthenViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, TZImagePickerControllerDelegate>
@property (nonatomic, strong) PCAuthenView *authenView;
@property (nonatomic, strong) UIButton *submitBtn;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *idCardNo;
@property (nonatomic, copy) NSString *base64;
@end

@implementation PCAuthenViewController

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

- (UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [UIButton new];
        [_submitBtn setTitle:@"提 交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_submitBtn setBackgroundColor:KHEXRGB(0x44C08C)];
        XSViewBorderRadius(_submitBtn, 6, 0, KHEXRGB(0x44C08C));
    }
    return _submitBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"个人认证" titleColor:0x333333];
    
    [self pc_creatAuthenView];
    [self pc_creatBottomView];
}

- (void)pc_creatAuthenView {
    self.authenView = [[PCAuthenView alloc] initWithFrame:CGRectMake(0, 64, KSCREEN_WIDTH, KSCREENH_HEIGHT - 75 - KBottomSafeHeight - 64) style:UITableViewStyleGrouped];
    [self.view addSubview:self.authenView];
    NSString *plistStr = NSLocalizedString(@"PCAuthen.plist", nil);
    self.authenView.dataArr = [BaseFormModel xs_getDataWithPlist:plistStr];
    [self.authenView reloadData];
    
    @weakify(self);
    self.authenView.authenFooterView.addBtnBlock = ^{
        @strongify(self);
        [self selectImage];
    };
}

- (void)pc_creatBottomView {
    [self.view addSubview:self.submitBtn];
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@(-28));
        make.bottom.equalTo(@(- 27 - KBottomSafeHeight));
        make.height.equalTo(@48);
    }];
    
    @weakify(self);
    [[self.submitBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self submitAction];
    }];
}

#pragma mark -- 选择图片
- (void)selectImage {
    UIAlertController *alertCtrl;
    alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    @weakify(self);
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        if (![XSYTapSound ifCanUseSystemCamera]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"一家老小”已禁用相机" message:@"请在iPhone的“设置”选项中,允许“一家老小”访问你的相机" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alertView show];
            
            [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber * _Nullable x) {
                if ([x isEqual:@1]) {
                    [ATYUtils openSystemSettingView];
                }
            }];
        } else {
            [self mi_openCamera];
        }
    }];
    
    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        if (![XSYTapSound ifCanUseSystemPhoto]) {
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"一家老小”已禁用照片" message:@"请在iPhone的“设置”选项中,允许“一家老小”访问你的照片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
            [alertView show];
            
            [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber * _Nullable x) {
                if ([x isEqual:@1]) {
                    [ATYUtils openSystemSettingView];
                }
            }];
        } else {
            TZImagePickerController *imagePickerCtrl = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
            imagePickerCtrl.allowCrop = YES; // 允许裁剪
            imagePickerCtrl.cropRect = CGRectMake(0, (KSCREENH_HEIGHT-KSCREEN_WIDTH)/2, KSCREEN_WIDTH, KSCREEN_WIDTH); // 设置裁剪框尺寸
            imagePickerCtrl.navigationBar.translucent = NO;
            [self presentViewController:imagePickerCtrl animated:YES completion:nil];
            @weakify(self);
            [imagePickerCtrl setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                @strongify(self);
                [self mi_uploadMultiPicWithHeadImage:[photos firstObject]];
            }];
        }
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertCtrl addAction:cameraAction];
    [alertCtrl addAction:pictureAction];
    [alertCtrl addAction:cancelAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}

// 打开相机
- (void)mi_openCamera {
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type {
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *imagePC = [[UIImagePickerController alloc] init];
    imagePC.sourceType = type;
    imagePC.delegate = self;
    imagePC.allowsEditing = YES;
    [self presentViewController:imagePC animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 * 从UIImagePickerController选择完图片后就调用（拍照完毕或者选择相册图片完毕）
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    // info中就包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [self mi_uploadMultiPicWithHeadImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -上传头像
- (void)mi_uploadMultiPicWithHeadImage:(UIImage *)headImg {
    NSData *imageData = nil;
    NSString *mimeType = nil;
    imageData = UIImageJPEGRepresentation(headImg, 1.0f);
    mimeType = @"image/jpeg";
    
    NSString *pictureDataString= [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    self.base64 = pictureDataString;
    self.authenView.IdCardimage = headImg;
    [self.authenView reloadData];
}

#pragma mark -- 提交
- (void)submitAction {
    BaseFormModel *model = self.authenView.dataArr[1];
    BaseDetailFormModel *nameModel = model.itemsArr[0];
    BaseDetailFormModel *idCardNoModel = model.itemsArr[1];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"name"] = nameModel.text;
    params[@"idcardNo"] = idCardNoModel.text;
    params[@"cardType"] = @"身份证";
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"imageType"] = @".jpg";
    params[@"base64"] = self.base64;
    
    //校验字段
    if (![self checkParams:params]) {
        return;
    }
    
    @weakify(self);
    [[self.personalCenterVM.AiIdcard execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            PCAuthenResultViewController *authenResultVC = [[PCAuthenResultViewController alloc] init];
            authenResultVC.authenticationStatus = x[@"Data"][@"authenticationStatus"];
            [self.navigationController pushViewController:authenResultVC animated:YES];
        }
    }];
}

#pragma mark -- 字段校验
- (BOOL)checkParams:(NSMutableDictionary *)params {
    BOOL isTure = YES;
    if (StrEmpty(params[@"name"])) {
        [ATYToast aty_bottomMessageToast:@"请填写姓名"];
        isTure = NO;
        return isTure;
    }
    if (StrEmpty(params[@"idcardNo"])) {
        [ATYToast aty_bottomMessageToast:@"请填写身份证号码"];
        isTure = NO;
        return isTure;
    }
    if (!StrEmpty(params[@"idcardNo"]) && ![ATYUtils checkIDCardNumber:params[@"idcardNo"]]) {
        [ATYToast aty_bottomMessageToast:@"身份证号码格式不正确"];
        isTure = NO;
        return isTure;
    }
    if (!params[@"base64"]) {
        [ATYToast aty_bottomMessageToast:@"请上传身份证照片"];
        isTure = NO;
        return isTure;
    }
    return isTure;
}

@end
