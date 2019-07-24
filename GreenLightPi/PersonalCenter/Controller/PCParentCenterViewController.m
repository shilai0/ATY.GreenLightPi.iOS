//
//  PCParentCenterViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/11.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "PCParentCenterViewController.h"
#import "PersonalCenterViewModel.h"
#import "PCParentCenterView.h"
#import "BoxTimeRemindModel.h"
#import "QFTimePickerView.h"
#import "BoxUseTimeModel.h"
#import "BaseFormModel.h"

@interface PCParentCenterViewController ()
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, strong) PCParentCenterView *parentCenterView;
@property (nonatomic, strong) BoxUseTimeModel *useTimeModel;
@property (nonatomic, strong) BoxTimeRemindModel *timeRemindModel;
@property (nonatomic, strong) NSMutableArray *dataArr;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
@end

@implementation PCParentCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self aty_setCenterNavItemtitle:@"家长中心" titleColor:0x333333];
    [self creatParentCenterViews];
    [self requestBoxTimeData];
}

- (void)creatParentCenterViews {
    self.parentCenterView = [[PCParentCenterView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStyleGrouped];
    [self.view addSubview:self.parentCenterView];
    
    @weakify(self);
    self.parentCenterView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        if (indexPath.section == 0) {
            if (indexPath.row == 1) {
                [self selectTimeIsEndTime:NO];
            } else if (indexPath.row == 2) {
                if (self.startTime.length == 0) {
                    [ATYToast aty_bottomMessageToast:@"请选择开始时间"];
                    return;
                }
                [self selectTimeIsEndTime:YES];
            }
        } else {
            //设置时间提醒
            [self setTimeRemind];
        }
    };
    
    self.parentCenterView.openOrCloseSwitchBlock = ^(BOOL isOpen) {
        @strongify(self);
        [self setUseTime:isOpen];
    };
}

- (void)requestBoxTimeData {
    dispatch_group_t parentCenterGroup =   dispatch_group_create();
    dispatch_group_enter(parentCenterGroup);
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"boxId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_BOXID];
    @weakify(self);
    [[self.personalCenterVM.GetBoxUseTime execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            BoxUseTimeModel *useTimeModel = [BoxUseTimeModel mj_objectWithKeyValues:x[@"Data"]];
            self.useTimeModel = useTimeModel;
            self.startTime = useTimeModel.startTime;
            self.endTime = useTimeModel.endTime;
        }
        dispatch_group_leave(parentCenterGroup);
    }];
    
    dispatch_group_enter(parentCenterGroup);
    [[self.personalCenterVM.GetBoxTimeRemind execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            BoxTimeRemindModel *timeRemindModle = [BoxTimeRemindModel mj_objectWithKeyValues:x[@"Data"]];
            self.timeRemindModel = timeRemindModle;
        }
        dispatch_group_leave(parentCenterGroup);
    }];
    
    dispatch_group_notify(parentCenterGroup, dispatch_get_main_queue(), ^{
        [self pc_insertData];
    });
}

#pragma mark -- 设置提醒时间
- (void)setTimeRemind {
    UIAlertController *alertCtrl;
    alertCtrl = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    @weakify(self);
    UIAlertAction *fiftyAction = [UIAlertAction actionWithTitle:@"15分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self setTimeRemind:15 iscustom:NO];
    }];
    
    UIAlertAction *thirtyAction = [UIAlertAction actionWithTitle:@"30分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self setTimeRemind:30 iscustom:NO];
    }];
    
    UIAlertAction *fortyFiveAction = [UIAlertAction actionWithTitle:@"45分钟" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self setTimeRemind:45 iscustom:NO];
    }];
    
    UIAlertAction *hourAction = [UIAlertAction actionWithTitle:@"1小时" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self setTimeRemind:60 iscustom:NO];
    }];
    
    UIAlertAction *customAction = [UIAlertAction actionWithTitle:@"自定义时间" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        [self inputRemindTime];
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alertCtrl addAction:fiftyAction];
    [alertCtrl addAction:thirtyAction];
    [alertCtrl addAction:fortyFiveAction];
    [alertCtrl addAction:hourAction];
    [alertCtrl addAction:customAction];
    [alertCtrl addAction:cancelAction];
    [self presentViewController:alertCtrl animated:YES completion:nil];
}

- (void)setTimeRemind:(NSInteger)time iscustom:(BOOL)isCustime {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"boxId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_BOXID];
    if (isCustime) {
        params[@"customTime"] = [NSNumber numberWithInteger:time];
        params[@"isUseCustom"] = [NSNumber numberWithInteger:1];
        params[@"defaultTime"] = [NSNumber numberWithInteger:self.timeRemindModel.defaultTime];
    } else {
        params[@"customTime"] = [NSNumber numberWithInteger:self.timeRemindModel.customTime];;
        params[@"defaultTime"] = [NSNumber numberWithInteger:time];
        params[@"isUseCustom"] = [NSNumber numberWithInteger:0];
    }
    @weakify(self);
    [[self.personalCenterVM.SetBoxTimeRemind execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            BaseFormModel *model1 = [self.dataArr objectAtIndex:1];
            BaseDetailFormModel *timeRemindModel = [model1.itemsArr firstObject];
            timeRemindModel.text = [NSString stringWithFormat:@"%ld分钟",time];
            self.timeRemindModel.isUseCustom = isCustime;
            self.parentCenterView.dataArr = self.dataArr;
            [self.parentCenterView reloadData];
        }
    }];
}

- (void)inputRemindTime {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"单位：分钟" message:@"请输入提醒时间" preferredStyle:UIAlertControllerStyleAlert];
    //增加确定按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //获取第1个输入框；
        UITextField *inputTimeTextField = alertController.textFields.firstObject;
        if (inputTimeTextField.text.length == 0) {
            [ATYToast aty_bottomMessageToast:@"设置时间不可为空"];
            return ;
        }
        if (inputTimeTextField.text && [inputTimeTextField.text integerValue] == 0) {
            [ATYToast aty_bottomMessageToast:@"设置时间不可为0"];
            return ;
        }
        [self setTimeRemind:[inputTimeTextField.text integerValue] iscustom:YES];
    }]];
    
    //增加取消按钮；
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
    
    //定义第一个输入框；
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入...";
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    
    [self presentViewController:alertController animated:true completion:nil];
}

#pragma mark -- 设置使用时间
- (void)setUseTime:(BOOL)isUse {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"boxId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_BOXID];
    params[@"startTime"] = self.startTime;
    params[@"endTime"] = self.endTime;
    if (isUse) {
        params[@"isUse"] = [NSNumber numberWithInteger:1];
    } else {
        params[@"isUse"] = [NSNumber numberWithInteger:0];
    }

    @weakify(self);
    [[self.personalCenterVM.SetBoxUseTime execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            self.useTimeModel.isUse = [[NSNumber numberWithBool:isUse] integerValue];
            self.useTimeModel.startTime = self.startTime;
            self.useTimeModel.endTime = self.endTime;
            [self pc_insertData];
        }
    }];
}

#pragma 选择使用时间
- (void)selectTimeIsEndTime:(BOOL)isEndTime {
    @weakify(self);
    NSString *selectStr = self.useTimeModel.startTime;
    if (isEndTime) {
        selectStr = self.useTimeModel.endTime;
    }
    QFTimePickerView *pickerView = [[QFTimePickerView alloc]initDatePackerWithStartHour:@"00" endHour:@"24" selectedHour:selectStr.length > 1 ? [selectStr substringWithRange:NSMakeRange(0, 2)] :@"00" selectedMin:selectStr.length > 1 ? [selectStr substringWithRange:NSMakeRange(selectStr.length - 2, 2)] :@"00"  period:1 response:^(NSString *str) {
        @strongify(self);
        BaseFormModel *model = [self.dataArr firstObject];
        if (isEndTime) {
            self.endTime = str;
            BaseDetailFormModel *endTimeModel = model.itemsArr[2];
            endTimeModel.text = str;
            [self setUseTime:YES];
        } else {
            self.startTime = str;
            BaseDetailFormModel *starTimeModel = model.itemsArr[1];
            starTimeModel.text = str;
            if (self.endTime.length == 0) {
                [ATYToast aty_bottomMessageToast:@"请选择结束时间"];
                return ;
            }
            [self setUseTime:YES];
        }
        [self.parentCenterView reloadData];
    }];
    [pickerView show];
};

#pragma mark -- 插入数据
- (void)pc_insertData {
    
    NSString *plistStr = NSLocalizedString(@"PCParentCenter.plist", nil);
    if (self.useTimeModel.isUse) {
        plistStr = NSLocalizedString(@"ParentCenterOpen.plist", nil);
    } else {
        plistStr = NSLocalizedString(@"PCParentCenter.plist", nil);
    }
    self.dataArr = [BaseFormModel xs_getDataWithPlist:plistStr];
    
    BaseFormModel *model = [self.dataArr firstObject];
    self.parentCenterView.isOpen = self.useTimeModel.isUse;
    if (self.useTimeModel.isUse) {
        BaseDetailFormModel *startTimeModel = model.itemsArr[1];
        startTimeModel.text = self.useTimeModel.startTime;
        BaseDetailFormModel *endTimeModel = model.itemsArr[2];
        endTimeModel.text = self.useTimeModel.endTime;
    }
    
    BaseFormModel *model1 = [self.dataArr objectAtIndex:1];
    BaseDetailFormModel *timeRemindModel = [model1.itemsArr firstObject];
    if (self.timeRemindModel.isUseCustom) {
        timeRemindModel.text = [NSString stringWithFormat:@"%ld分钟",self.timeRemindModel.customTime];
    } else {
        if (self.timeRemindModel.defaultTime == 0) {
            timeRemindModel.text = @"15分钟";
        } else {
            timeRemindModel.text = [NSString stringWithFormat:@"%ld分钟",self.timeRemindModel.defaultTime];
        }
    }
    
    self.parentCenterView.dataArr = self.dataArr;
    [self.parentCenterView reloadData];
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end
