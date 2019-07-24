//
//  HMBabyInfoViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/1.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMBabyInfoViewController.h"
#import "TZImagePickerController.h"
#import "ATYAlertViewController.h"
#import "HMMyBabyViewController.h"
#import "BabyInfoTableView.h"
#import "BaseFormModel.h"
#import "HomeViewModel.h"
#import "BaseFormModel.h"
#import "STPickerDate.h"
#import "XSYTapSound.h"
#import "UserModel.h"
#import "BabyModel.h"

@interface HMBabyInfoViewController ()<STPickerDateDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate, TZImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) BabyInfoTableView *babyInfoTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, copy) NSNumber *selectedSex;
@property (nonatomic, copy) NSNumber *selectedRelation;
@property (nonatomic, strong) HomeViewModel *homeVM;
@property (nonatomic, strong) NSArray *imagePathArr;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, assign) BOOL isEdit;
@end

@implementation HMBabyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = KHEXRGB(0xFFFFFF);
    
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self aty_backItemClick];
    }];
    
    if (self.babyInfoType == 0) {
        [self aty_setCenterNavItemtitle:@"宝宝信息" titleColor:0x333333];
    } else {
        [self aty_setCenterNavItemtitle:@"添加宝宝" titleColor:0x333333];
    }
    
    [self rl_creatBabyInfoViews];
}

- (void)rl_creatBabyInfoViews {
    [self.view addSubview:self.babyInfoTableView];
    [self.view addSubview:self.sureBtn];
    self.sureBtn.hidden = YES;
    
    [self.babyInfoTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@(KNavgationBarHeight));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(@(-KBottomSafeHeight));
        make.height.equalTo(@49);
    }];
    
    if (self.babyInfoType == 0) {
        [self.footerView addSubview:self.deleteBtn];
        self.babyInfoTableView.tableFooterView = self.footerView;
        NSString *plistStr = NSLocalizedString(@"BabyInfoPlist.plist", nil);
        self.dataArray = [BaseFormModel xs_getDataWithPlist:plistStr];
        [self hm_insertData:self.dataArray];
    } else {
        self.sureBtn.hidden = NO;
        NSString *plistStr = NSLocalizedString(@"AddBabyInfoPlist.plist", nil);
        self.dataArray = [BaseFormModel xs_getDataWithPlist:plistStr];
        self.babyInfoTableView.dataArr = self.dataArray;
        [self.babyInfoTableView reloadData];
    }
    
    @weakify(self);
    self.babyInfoTableView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        switch (indexPath.section) {
            case 0:
            {
                switch (indexPath.row) {
                    case 0:
                        //选择宝宝头像
                    {
                        [self.view endEditing:YES];
                        [self selectBabyImage];
                    }
                        break;
                    case 2:
                        //选择宝宝性别
                    {
                        [self.view endEditing:YES];
                    }
                        break;
                    case 3:
                        //选择宝宝生日
                    {
                        [self.view endEditing:YES];
                        [self selectBabyBirthday];
                    }
                        break;
                    default:
                        break;
                }
            }
                break;
            default:
                break;
        }
    };
    
    self.babyInfoTableView.selectSexBlock = ^(NSInteger sexIndex) {//性别
        @strongify(self);
        self.selectedSex = [NSNumber numberWithInteger:sexIndex];
    };
    
    self.babyInfoTableView.selectRelationBlock = ^(NSInteger relationIndex) {//与宝宝的关系
        @strongify(self);
        self.selectedRelation = [NSNumber numberWithInteger:relationIndex];
    };
    
    [[self.sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self hm_addOrEditorBabyInfo];
    }];
    
    [[self.deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self hm_deleteBabyInfo];
    }];
    
}

#pragma mark -- 选择宝宝生日
- (void)selectBabyBirthday {
    STPickerDate *birthdayData = [[STPickerDate alloc]init];
    birthdayData.delegate = self;
    [birthdayData show];
}

#pragma mark -STPickerDateDelegate
- (void)pickerDate:(STPickerDate *)pickerDate year:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year, month,day];
    BaseFormModel *normalModel = [self.babyInfoTableView.dataArr firstObject];
    BaseDetailFormModel *birthdayModel = normalModel.itemsArr[3];
    birthdayModel.text = dateStr;
    [self.babyInfoTableView reloadData];
}

#pragma mark -- 选择宝宝头像
- (void)selectBabyImage {
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
            imagePickerCtrl.delegate = self;
            [self presentViewController:imagePickerCtrl animated:YES completion:nil];
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

#pragma mark -TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    [picker dismissViewControllerAnimated:YES completion:nil];
    self.babyInfoTableView.picImage = [photos firstObject];
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.babyInfoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    [self mi_uploadMultiPicWithHeadImage:[photos lastObject]];
}


#pragma mark - UIImagePickerControllerDelegate
/**
 * 从UIImagePickerController选择完图片后就调用（拍照完毕或者选择相册图片完毕）
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    // info中就包含了选择的图片
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.babyInfoTableView.picImage = image;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    [self.babyInfoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    [self mi_uploadMultiPicWithHeadImage:image];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -上传头像
- (void)mi_uploadMultiPicWithHeadImage:(UIImage *)headImg {
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"moduleType"] = @0;
    NSArray *headImageArr = [NSArray arrayWithObject:headImg];
    @weakify(self);
    [[self.homeVM.saveBabyImageCommand execute:@{@"params" : params, @"imgArr" : headImageArr}] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            self.imagePathArr = x[@"Data"];
        }
    }];
}

#pragma mark -- 提交保存
- (void)hm_addOrEditorBabyInfo {
    //校验字段
    if (![self hm_checkParamsStr]) {
        return;
    }
    
    self.params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    
    if (self.babyInfoType == 0) {
        self.params[@"babyId"] = [NSNumber numberWithInteger:self.babyModel.baby_id];
    }
    
    @weakify(self);
    [[self.homeVM.AddOrEditorBaby execute:self.params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            if (self.saveBlock) {
                self.saveBlock();
            }
            
            if (self.babyInfoType == 2) {
                for (UIViewController *vc in self.navigationController.viewControllers) {
                    if ([vc isKindOfClass:[HMMyBabyViewController class]]) {
                        HMMyBabyViewController *myBabyVC = (HMMyBabyViewController *)vc;
                        [self.navigationController popToViewController:myBabyVC animated:YES];
                    }
                }
            } else if (self.babyInfoType == 3) {
                [self.navigationController popToRootViewControllerAnimated:YES];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }
    }];
}

#pragma mark - 删除宝宝信息
- (void)hm_deleteBabyInfo {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"babyId"] = [NSNumber numberWithInteger:self.babyModel.baby_id];
    [[self.homeVM.DeleteBaby execute:params] subscribeNext:^(id  _Nullable x) {
        if (x != nil) {
            if (self.saveBlock) {
                self.saveBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

#pragma mark -- 返回（处理是否有要保存的信息）
- (void)aty_backItemClick {
    BaseFormModel *model = [self.dataArray firstObject];
    
    BaseDetailFormModel *nikenameModel = model.itemsArr[1];
    
    BaseDetailFormModel *birthDayModel = model.itemsArr[3];
    
    if (self.babyInfoType == 0 && ((self.imagePathArr.count > 0 && ![self.babyModel.path isEqualToString:[self.imagePathArr firstObject]]) || ![nikenameModel.text isEqualToString:self.babyModel.nikename] || (self.selectedSex != nil && [self.selectedSex integerValue] != self.babyModel.sex) || ![birthDayModel.text isEqualToString:self.babyModel.birthday])) {
        [self hm_addOrEditorBabyInfo];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (self.babyInfoType != 0 && (self.imagePathArr.count > 0 || nikenameModel.text.length > 0 || birthDayModel.text.length > 0)) {
        ATYAlertViewController *alertCtrl = [ATYAlertViewController alertControllerWithTitle:nil message:@"确定退出当前编辑？"];
        alertCtrl.messageAlignment = NSTextAlignmentCenter;
        ATYAlertAction *cancel = [ATYAlertAction actionWithTitle:@"取消" titleColor:0x1F1F1F handler:nil];
        ATYAlertAction *done = [ATYAlertAction actionWithTitle:@"确定" titleColor:0x1F1F1F handler:^(ATYAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [alertCtrl addAction:cancel];
        [alertCtrl addAction:done];
        [self presentViewController:alertCtrl animated:NO completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- 赋值
- (void)hm_insertData:(NSMutableArray *)dataArr {
    BaseFormModel *model = [dataArr firstObject];
    self.babyInfoTableView.imagePathStr = self.babyModel.path;
    
    BaseDetailFormModel *nikenameModel = model.itemsArr[1];
    nikenameModel.text = self.babyModel.nikename;
    
    self.babyInfoTableView.sex = [NSNumber numberWithInteger:self.babyModel.sex];
    
    BaseDetailFormModel *birthDayModel = model.itemsArr[3];
    birthDayModel.text = self.babyModel.birthday;
    
    self.babyInfoTableView.relation = [NSNumber numberWithInteger:self.babyModel.userRole];
    
    self.dataArray = dataArr;
    self.babyInfoTableView.dataArr = self.dataArray;
    [self.babyInfoTableView reloadData];
}

#pragma mark -- 校验字段
- (BOOL)hm_checkParamsStr {
    BOOL isTure = YES;
    BaseFormModel *model = [self.dataArray firstObject];
    NSArray *detailModelArr = model.itemsArr;
    if (self.imagePathArr.count == 0 && self.babyModel.path.length == 0) {
        [ATYToast aty_bottomMessageToast:@"请上传宝宝头像"];
        isTure = NO;
        return isTure;
    }
    if (self.imagePathArr.count > 0) {
        [self.params setObject:self.imagePathArr forKey:@"imagePath"];
    }
    if (self.babyInfoType == 0 && self.imagePathArr.count == 0) {
        [self.params setObject:@[self.babyModel.path] forKey:@"imagePath"];
    }
    
    BaseDetailFormModel *nameModel = [detailModelArr objectAtIndex:1];
    if (nameModel.text.length == 0) {
        [ATYToast aty_bottomMessageToast:@"请填写宝宝昵称"];
        isTure = NO;
        return isTure;
    }
    [self.params setObject:nameModel.text forKey:@"nikename"];
    
    if (self.selectedSex) {
        [self.params setObject:self.selectedSex forKey:@"sex"];
    } else {
        [self.params setObject:[NSNumber numberWithInt:0] forKey:@"sex"];
    }
    if (self.babyInfoType == 0 && !self.selectedSex) {
        [self.params setObject:[NSNumber numberWithInteger:self.babyModel.sex] forKey:@"sex"];
    }
    
    if (self.selectedRelation) {
        [self.params setObject:self.selectedRelation forKey:@"userRole"];
    } else {
        [self.params setObject:[NSNumber numberWithInt:0] forKey:@"userRole"];
    }
    if (self.babyInfoType == 0 && !self.selectedRelation) {
        [self.params setObject:[NSNumber numberWithInteger:self.babyModel.userRole] forKey:@"userRole"];
    }
    
    BaseDetailFormModel *birthdayModel = [detailModelArr objectAtIndex:3];
    if (birthdayModel.text.length == 0) {
        [ATYToast aty_bottomMessageToast:@"请选择宝宝生日"];
        isTure = NO;
        return isTure;
    }
    [self.params setObject:birthdayModel.text forKey:@"birthday"];
    
    return isTure;
}


#pragma mark -- 懒加载

- (BabyInfoTableView *)babyInfoTableView {
    if (!_babyInfoTableView) {
        _babyInfoTableView = [[BabyInfoTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _babyInfoTableView;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [[UIButton alloc] init];
        _sureBtn.backgroundColor = KHEXRGB(0x00D399);
        [_sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _sureBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        _deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 65, KSCREEN_WIDTH - 32, 48)];
        [_deleteBtn setBackgroundColor:KHEXRGB(0xFF7976)];
        [_deleteBtn setTitle:@"删 除" forState:UIControlStateNormal];
        [_deleteBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _deleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        XSViewBorderRadius(_deleteBtn, 24, 0, KHEXRGB(0xFF7976));
    }
    return _deleteBtn;
}

- (UIView *)footerView {
    if (!_footerView) {
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 113)];
        _footerView.backgroundColor = KHEXRGB(0xF7F7F7);
    }
    return _footerView;
}

- (HomeViewModel *)homeVM {
    if (!_homeVM) {
        _homeVM = [[HomeViewModel alloc] init];
    }
    return _homeVM;
}

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [[NSMutableDictionary alloc] init];
    }
    return _params;
}

@end
