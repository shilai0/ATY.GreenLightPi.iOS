//
//  FCEvaluateViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/21.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCEvaluateViewController.h"
#import "FCEvaluateView.h"
#import "FamilyCoachViewModel.h"
#import "FcCoursesModel.h"

@interface FCEvaluateViewController ()
@property (nonatomic, strong) FCEvaluateView *evaluateView;
@property (nonatomic, strong) FamilyCoachViewModel *familyCoachVM;
@property (nonatomic, copy) NSNumber *sorceNum;
@end

@implementation FCEvaluateViewController

- (FamilyCoachViewModel *)familyCoachVM {
    if (!_familyCoachVM) {
        _familyCoachVM = [[FamilyCoachViewModel alloc] init];
    }
    return _familyCoachVM;
}

- (FCEvaluateView *)evaluateView {
    if (!_evaluateView) {
        _evaluateView = [[FCEvaluateView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight - KBottomSafeHeight)];
    }
    return _evaluateView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self fc_setEvalusteVCNavigation];
    [self fc_creatEvaluateView];
}

- (void)fc_setEvalusteVCNavigation {
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    @weakify(self);
    [self aty_setLeftNavItemImg:@"" title:@"取消" titleColor:0x646464 leftBlock:^{
        @strongify(self);
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [self aty_setCenterNavItemtitle:@"我的评论" titleColor:0x333333];
    
    [self aty_setRightNavItemImg:@"" title:@"发布" titleColor:0x44C08C rightBlock:^{
        @strongify(self);
        [self fc_giveEvaluate];
    }];
}

- (void)fc_creatEvaluateView {
    [self.view addSubview:self.evaluateView];
    
    @weakify(self);
    self.evaluateView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
        @strongify(self);
        NSString *str = nil;
        if (index == 1) {
            str = @"极差，课程很糟糕，我要吐槽";
        } else if (index == 2) {
            str = @"差，我对课程不满意";
        } else if (index == 3) {
            str = @"中评，课程很一般";
        } else if (index == 4) {
            str = @"良好，课程还可以";
        } else if (index == 5) {
            str = @"推荐，课程非常棒";
        }
        self.sorceNum = [NSNumber numberWithInteger:index];
        self.evaluateView.dicData = @{@"starValue":[NSNumber numberWithInteger:index],@"titleValue":str};
    };
}

- (void)fc_giveEvaluate {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"score"] = self.sorceNum;
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"coursesId"] = self.coursesModel.courses_id;
    params[@"commentStr"] = self.evaluateView.descriptionTextView.text;
    params[@"commentId"] = @0;
    @weakify(self);
    [[self.familyCoachVM.GiveCommentCommand execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            if (self.evaluateBlock) {
                self.evaluateBlock();
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

@end
