//
//  BabyInfoViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BabyInfoViewController.h"
#import "BabyInfoTableView.h"
#import "BaseFormModel.h"
#import "STPickerDate.h"
#import "XSYTapSound.h"
#import "TZImagePickerController.h"
#import "RLLoginRegisterViewModel.h"
#import "UserModel.h"
#import "ATYCache.h"

@interface BabyInfoViewController ()<STPickerDateDelegate,UIImagePickerControllerDelegate, UIActionSheetDelegate, TZImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) BabyInfoTableView *babyInfoTableView;
@property (nonatomic, strong) NSMutableDictionary *params;
@property (nonatomic, copy) NSNumber *selectSex;//当前选择性别
@property (nonatomic, strong) RLLoginRegisterViewModel *loginRegistVM;
@property (nonatomic, strong) UIButton *bottomBtn;
@property (nonatomic, strong) NSArray *imagePath;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation BabyInfoViewController

- (NSMutableDictionary *)params {
    if (!_params) {
        _params = [[NSMutableDictionary alloc] init];
    }
    return _params;
}

- (RLLoginRegisterViewModel *)loginRegistVM {
    if (_loginRegistVM == nil) {
        _loginRegistVM = [[RLLoginRegisterViewModel alloc] init];
    }
    return _loginRegistVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"宝宝信息";
    self.view.backgroundColor = KHEXRGB(0xFFFFFF);
    [self rl_creatBabyInfoViews];
}

- (void)rl_creatBabyInfoViews {
    self.babyInfoTableView = [[BabyInfoTableView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - KBottomSafeHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.babyInfoTableView];
    
    self.bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, KSCREENH_HEIGHT - KBottomSafeHeight - 10 - 50, KSCREEN_WIDTH - 20, 50)];
    [self.bottomBtn setTitle:@"添 加" forState:UIControlStateNormal];
    [self.bottomBtn setBackgroundColor:KHEXRGB(0x44C08C)];
    [self.bottomBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
    XSViewBorderRadius(self.bottomBtn, (20 * KHEIGHTRATE(0.96))/2.0, 0, KHEXRGB(0x44C08C));
    self.bottomBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.view addSubview:self.bottomBtn];
   
    NSString *plistStr = NSLocalizedString(@"BabyInfoPlist.plist", nil);
    self.dataArray = [BaseFormModel xs_getDataWithPlist:plistStr];
    if (self.isAdd) {
        self.babyInfoTableView.dataArr = self.dataArray;
        [self.babyInfoTableView reloadData];
    } else {
        [self rl_insertData:self.dataArray];
    }
    
    @weakify(self);
    self.babyInfoTableView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
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
    };
    
    self.babyInfoTableView.selectSexBlock = ^(NSInteger sexIndex) {//性别
        @strongify(self);
//        [self.babySexArr addObject:[NSNumber numberWithInteger:sexIndex]] ;
        self.selectSex = [NSNumber numberWithInteger:sexIndex];
    };
    
    [[self.bottomBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self commitBabyInfo];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    BaseFormModel *normalModel = self.babyInfoTableView.dataArr[0];
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
            [self presentViewController:imagePickerCtrl animated:YES completion:nil];
            @weakify(self);
            [imagePickerCtrl setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                @strongify(self);
                self.babyInfoTableView.picImage = [photos firstObject];
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
                [self.babyInfoTableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
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
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"moduleType"] = @0;
    NSArray *headImageArr = [NSArray arrayWithObject:headImg];
    @weakify(self);
    [[self.loginRegistVM.saveBabyImageCommand execute:@{@"params" : params, @"imgArr" : headImageArr}] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            self.imagePath = x[@"Data"];
        }
    }];
}

#pragma mark -- 图片格式
- (BOOL) imageHasAlpha: (UIImage *) image
{
    CGImageAlphaInfo alpha = CGImageGetAlphaInfo(image.CGImage);
    return (alpha == kCGImageAlphaFirst ||
            alpha == kCGImageAlphaLast ||
            alpha == kCGImageAlphaPremultipliedFirst ||
            alpha == kCGImageAlphaPremultipliedLast);
}

#pragma mark -- 提交宝宝信息
- (void)commitBabyInfo {
        //校验字段
        if (![self RL_checkParamsStr]) {
            return;
        }
    if (self.saveBabyInfoBlock) {
        self.saveBabyInfoBlock(self.dataArray,self.params);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -- 校验字段
- (BOOL)RL_checkParamsStr {
    BOOL isTure = YES;
    BaseFormModel *model = [self.dataArray firstObject];
    NSArray *detailModelArr = model.itemsArr;
    NSArray *imagePathArr = [self.dataParams objectForKey:@"imagePath"];
    if (self.imagePath.count == 0 && imagePathArr.count == 0) {
        [ATYToast aty_bottomMessageToast:@"请上传宝宝头像"];
        isTure = NO;
        return isTure;
    }
    if (self.imagePath.count > 0) {
        [self.params setObject:self.imagePath forKey:@"imagePath"];
    }
    if (!self.isAdd && self.imagePath.count == 0) {
        [self.params setObject:self.dataParams[@"imagePath"] forKey:@"imagePath"];
    }
    
    BaseDetailFormModel *nameModel = [detailModelArr objectAtIndex:1];
    if (nameModel.text.length == 0) {
        [ATYToast aty_bottomMessageToast:@"请填写宝宝昵称"];
        isTure = NO;
        return isTure;
    }
    [self.params setObject:nameModel.text forKey:@"nikename"];

    
//    if (!self.selectSex && ![self.dataParams objectForKey:@"sex"]) {
//        [ATYToast aty_bottomMessageToast:@"请选择宝宝性别"];
//        isTure = NO;
//        return isTure;
//    }
    if (self.selectSex) {
        [self.params setObject:self.selectSex forKey:@"sex"];
    } else {
        [self.params setObject:[NSNumber numberWithInt:0] forKey:@"sex"];
    }
    if (!self.isAdd && !self.selectSex) {
        [self.params setObject:self.dataParams[@"sex"] forKey:@"sex"];
    }
    
    BaseDetailFormModel *birthdayModel = [detailModelArr objectAtIndex:3];
    if (birthdayModel.text.length == 0) {
        [ATYToast aty_bottomMessageToast:@"请选择宝宝生日"];
        isTure = NO;
        return isTure;
    }
    [self.params setObject:birthdayModel.text forKey:@"birthday"];
    
    BaseDetailFormModel *weightModel = [detailModelArr objectAtIndex:4];
    if (weightModel.text.length == 0) {
        [self.params setObject:[NSNumber numberWithInt:0] forKey:@"weight"];
    } else {
        [self.params setObject:weightModel.text forKey:@"weight"];
    }
    
    BaseDetailFormModel *heightModel = [detailModelArr objectAtIndex:5];
    if (heightModel.text.length == 0) {
        [self.params setObject:[NSNumber numberWithInt:0] forKey:@"height"];
    } else {
        [self.params setObject:heightModel.text forKey:@"height"];
    }

    return isTure;
}

- (void)rl_insertData:(NSMutableArray *)dataArr {
    BaseFormModel *model = [dataArr firstObject];
    self.babyInfoTableView.imagePathStr = [[self.dataParams objectForKey:@"imagePath"] firstObject];

    BaseDetailFormModel *nikenameModel = model.itemsArr[1];
    nikenameModel.text = [self.dataParams objectForKey:@"nikename"];
 
    self.babyInfoTableView.sex = [self.dataParams objectForKey:@"sex"];

    BaseDetailFormModel *birthDayModel = model.itemsArr[3];
    birthDayModel.text = [self.dataParams objectForKey:@"birthday"];

    BaseDetailFormModel *weightModel = model.itemsArr[4];
    weightModel.text = [NSString stringWithFormat:@"%@",[self.dataParams objectForKey:@"weight"]];

    BaseDetailFormModel *heightModel = model.itemsArr[5];
    heightModel.text = [NSString stringWithFormat:@"%@",[self.dataParams objectForKey:@"height"]];
    
    self.dataArray = dataArr;
    self.babyInfoTableView.dataArr = self.dataArray;
    [self.babyInfoTableView reloadData];
}

@end
