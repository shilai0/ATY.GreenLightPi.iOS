//
//  PCModifyNikeNameViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCModifyNikeNameViewController.h"
#import "PersonalCenterViewModel.h"

@interface PCModifyNikeNameViewController ()
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@end

@implementation PCModifyNikeNameViewController

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textColor = KHEXRGB(0x333333);
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"" title:@"取消" titleColor:0x646464 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"修改昵称" titleColor:0x333333];
    
    [self aty_setRightNavItemImg:@"" title:@"确定" titleColor:0x44C08C rightBlock:^{
        @strongify(self);
        [self modifyNikeName];
    }];
    
    [self pc_creatUI];
}

- (void)pc_creatUI {
    self.textField.frame = CGRectMake(0, KNavgationBarHeight + 13, KSCREEN_WIDTH, 55);
    [self.view addSubview:self.textField];
    _textField.text = self.nikeName;
}

- (void)modifyNikeName {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"nikename"] = _textField.text;
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    @weakify(self);
    [[self.personalCenterVM.UpdatePersonal execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            if (self.updateBlock) {
                self.updateBlock(self.textField.text);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
