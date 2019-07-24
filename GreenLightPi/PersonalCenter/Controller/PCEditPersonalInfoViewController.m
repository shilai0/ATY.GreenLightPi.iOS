//
//  PCEditPersonalInfoViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/24.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCEditPersonalInfoViewController.h"
#import "PCPersonalInfoTableView.h"
#import "BaseFormModel.h"
#import "PersonalCenterUserModel.h"
#import "FileEntityModel.h"
#import "PCModifyNikeNameViewController.h"
#import "PersonalCenterViewModel.h"
#import "PCIntroductionViewController.h"
#import "XSYTapSound.h"
#import "TZImagePickerController.h"
#import "PCAuthenViewController.h"
#import "ATYCache.h"
#import "UserModel.h"

@interface PCEditPersonalInfoViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate, TZImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, strong) PCPersonalInfoTableView *personalInfoView;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, strong) NSMutableArray *pictureArr;
@end

@implementation PCEditPersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"修改资料" titleColor:0x333333];
    
    [self pc_creatPerconalInfoTableView];
}

- (void)pc_creatPerconalInfoTableView {
    self.personalInfoView = [[PCPersonalInfoTableView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.personalInfoView];
    NSString *plistStr = NSLocalizedString(@"PersonalCenter.plist", nil);
    self.dataArr = [BaseFormModel xs_getDataWithPlist:plistStr];
    [self pc_insertDataForArray:self.dataArr];
    
    @weakify(self);
    self.personalInfoView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        if (indexPath.section == 0) {//修改头像
            [self selectHeadImage];
        } else if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0://修改昵称
                {
                    PCModifyNikeNameViewController *modifyNikeNameVC = [[PCModifyNikeNameViewController alloc] init];
                    modifyNikeNameVC.nikeName = self.personalUserModel.nikename;
                    @weakify(self);
                    modifyNikeNameVC.updateBlock = ^(NSString *nikeName) {
                        @strongify(self);
                        self.personalUserModel.nikename = nikeName;
                        [self getChangeDataWithText:nikeName indexPath:indexPath];
                        if (self.updateInfoBlock) {
                            self.updateInfoBlock(self.personalUserModel);
                        }
                    };
                    [self.navigationController pushViewController:modifyNikeNameVC animated:YES];
                }
                    break;
                case 1://修改简介
                {
                    PCIntroductionViewController *introductionVC = [[PCIntroductionViewController alloc] init];
                    introductionVC.introductionStr = self.personalUserModel.resume;
                    @weakify(self);
                    introductionVC.updateBlock = ^(NSString *introductionStr) {
                        @strongify(self);
                        self.personalUserModel.resume = introductionStr;
                        [self getChangeDataWithText:introductionStr indexPath:indexPath];
                        if (self.updateInfoBlock) {
                            self.updateInfoBlock(self.personalUserModel);
                        }
                    };
                    [self.navigationController pushViewController:introductionVC animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
    };
    
}

- (void)pc_insertDataForArray:(NSMutableArray *)dataArr {
    self.personalInfoView.HeadPicUrl = self.personalUserModel.image.path;
    
    BaseFormModel *secTwoModel = dataArr[1];
    BaseDetailFormModel *secTwoItemOneModel = secTwoModel.itemsArr[0];
    secTwoItemOneModel.text = self.personalUserModel.nikename;
    
    BaseDetailFormModel *secTwoItemFourModel = secTwoModel.itemsArr[1];
    secTwoItemFourModel.text = self.personalUserModel.resume;
    
    self.personalInfoView.dataArr = self.dataArr;
    [self.personalInfoView reloadData];
}

#pragma mark -- 数据处理
- (void)getChangeDataWithText:(NSString *)text indexPath:(NSIndexPath *)indexPath {
    BaseFormModel *model = self.dataArr[indexPath.section];
    BaseDetailFormModel *vaModel = model.itemsArr[indexPath.row];
    vaModel.text = text;
    [self.personalInfoView reloadData];
//    [self.personalInfoView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark -- 选择头像
- (void)selectHeadImage {
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
                [self mi_uploadMultiPicWithHeadImage:[photos lastObject]];
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
    UIImage *image = info[UIImagePickerControllerEditedImage];
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
            [self updateHeadImagewithPath:[x[@"Data"] firstObject]];
        }
    }];
}

#pragma mark -- 修改头像
- (void)updateHeadImagewithPath:(NSString *)imagePath {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"imagePath"] = imagePath;
    params[@"fileId"] = self.personalUserModel.image.file_id;
    @weakify(self);
    [[self.personalCenterVM.UpdatePersonal execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            self.personalInfoView.HeadPicUrl = imagePath;
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            [self.personalInfoView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            UserModel *userModel = [ATYCache readCache:PROJECT_USER];
            userModel.image.path = imagePath;
            [ATYCache saveDataCache:userModel forKey:PROJECT_USER];
            [KNotificationCenter postNotificationName:CHANGEHEADIMAGE_CONTENT_NOTIFICATION object:nil userInfo:@{@"imagePath":imagePath}];
        }
    }];
}

- (NSMutableArray *)pictureArr {
    if (!_pictureArr) {
        _pictureArr = [[NSMutableArray alloc] init];
    }
    return _pictureArr;
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

@end
