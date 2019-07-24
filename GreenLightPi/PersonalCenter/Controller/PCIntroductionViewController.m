//
//  PCIntroductionViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCIntroductionViewController.h"
#import "PersonalCenterViewModel.h"

@interface PCIntroductionViewController ()<UITextViewDelegate>
@property (nonatomic, strong) UITextView *introTextView;
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@end

@implementation PCIntroductionViewController

- (UITextView *)introTextView {
    if (!_introTextView) {
        _introTextView = [[UITextView alloc] init];
        _introTextView.textColor = KHEXRGB(0x333333);
        _introTextView.font = [UIFont systemFontOfSize:15];
    }
    return _introTextView;
}

- (UILabel *)numberLabel {
    if (!_numberLabel) {
        _numberLabel = [[UILabel alloc] init];
        _numberLabel.textColor = KHEXRGB(0x646464);
        _numberLabel.font = [UIFont systemFontOfSize:12];
        _numberLabel.textAlignment = NSTextAlignmentRight;
    }
    return _numberLabel;
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"" title:@"取消" titleColor:0x646464 leftBlock:^{
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self aty_setCenterNavItemtitle:@"介绍" titleColor:0x333333];
    
    [self aty_setRightNavItemImg:@"" title:@"确定" titleColor:0x44C08C rightBlock:^{
        @strongify(self);
        [self updateIntroduction];
    }];
    
    [self pc_creatIntroductionUI];
}

- (void)pc_creatIntroductionUI {
    [self.view addSubview:self.introTextView];
    _introTextView.text = self.introductionStr;
    _introTextView.delegate = self;
    
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/20", (unsigned long)_introTextView.text.length];
    [self.introTextView addSubview:self.numberLabel];
    
    [self.introTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@(KNavgationBarHeight + 8));
        make.height.equalTo(@181);
    }];
    
    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.introTextView.mas_top).offset(159);
        make.left.equalTo(@(KSCREEN_WIDTH - 56));
        make.width.equalTo(@40);
        make.height.equalTo(@12);
    }];
}

- (void)textViewDidChange:(UITextView *)textView
{
    //实时显示字数
    self.numberLabel.text = [NSString stringWithFormat:@"%lu/20", (unsigned long)textView.text.length];
    //字数限制操作
    if (textView.text.length >= 20) {
        textView.text = [textView.text substringToIndex:20];
        self.numberLabel.text = @"20/20";
    }
}

- (void)updateIntroduction {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"resume"] = _introTextView.text;
    @weakify(self);
    [[self.personalCenterVM.UpdatePersonal execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            if (self.updateBlock) {
                self.updateBlock(self.introTextView.text);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
