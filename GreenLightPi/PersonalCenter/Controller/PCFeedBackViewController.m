//
//  PCFeedBackViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/3.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCFeedBackViewController.h"
#import "PCFeedBackView.h"
#import "TZImagePickerController.h"
#import "XSYTapSound.h"
#import "PersonalCenterViewModel.h"

@interface PCFeedBackViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, TZImagePickerControllerDelegate>
@property (nonatomic, strong) PCFeedBackView *feedBackView;
@property (nonatomic, strong) UIButton *bottomBtn;
@property (nonatomic, strong) NSMutableArray *pictureArr;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, strong) NSMutableArray *picUrlArr;
@end

@implementation PCFeedBackViewController

- (PCFeedBackView *)feedBackView {
    if (!_feedBackView) {
        _feedBackView = [PCFeedBackView new];
    }
    return _feedBackView;
}

- (UIButton *)bottomBtn {
    if (!_bottomBtn) {
        _bottomBtn = [UIButton new];
        [_bottomBtn setBackgroundColor:KHEXRGB(0x44C08C)];
        [_bottomBtn setTitle:@"提 交" forState:UIControlStateNormal];
        [_bottomBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _bottomBtn.titleLabel.font = FONT(16);
        XSViewBorderRadius(_bottomBtn, 6, 0, KHEXRGB(0xFFFFFF));
    }
    return _bottomBtn;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"意见反馈" titleColor:0x333333];
    [self pc_creatFeedBackViews];
}

- (void)pc_creatFeedBackViews {
    [self.view addSubview:self.feedBackView];
    [self.feedBackView addSubview:self.bottomBtn];
    
    [self.feedBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@(KNavgationBarHeight));
        make.bottom.equalTo(self.view);
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@(-28));
        make.bottom.equalTo(@(- KBottomSafeHeight - 71));
        make.height.equalTo(@48);
    }];
    
    @weakify(self);
    self.feedBackView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        [self selectImage];
    };
    
    [[self.bottomBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self commitFeedBack];
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
    [self.pictureArr addObject:headImg];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"moduleType"] = @0;
    @weakify(self);
    [[self.personalCenterVM.UpdateFile execute:@{@"params" : params, @"imgArr" : self.pictureArr}] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            self.feedBackView.picImage = [self.pictureArr firstObject];
            self.picUrlArr = x[@"Data"];
        }
    }];
}

- (void)commitFeedBack {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"user_id"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"content"] = self.feedBackView.descriptView.text;
    params[@"imageList"] = self.picUrlArr;
    
    @weakify(self);
    [[self.personalCenterVM.FeedbackMessage execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            [self.navigationController popViewControllerAnimated:YES];
            [ATYToast aty_bottomMessageToast:@"意见反馈成功，非常感谢"];
        }
    }];
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

- (NSMutableArray *)pictureArr {
    if (!_pictureArr) {
        _pictureArr = [[NSMutableArray alloc] init];
    }
    return _pictureArr;
}

- (NSMutableArray *)picUrlArr {
    if (!_picUrlArr) {
        _picUrlArr = [[NSMutableArray alloc] init];
    }
    return _picUrlArr;
}

@end
