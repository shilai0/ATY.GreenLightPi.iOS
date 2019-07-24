//
//  PCProfitViewController.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/9.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCProfitViewController.h"
#import "PCEquityProfitView.h"
#import "PersonalCenterViewModel.h"
#import "IncomeModel.h"
#import "BRPickerView.h"

@interface PCProfitViewController ()
@property (nonatomic, strong) PCEquityProfitView *equityProfitView;
@property (nonatomic, strong) PersonalCenterViewModel *personalCenterVM;
@property (nonatomic, copy) NSString *selectTime;
@end

@implementation PCProfitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    @weakify(self);
    [self aty_setLeftNavItemImg:@"return" title:nil titleColor:0
                      leftBlock:^{
                          @strongify(self);
                          [self.navigationController popViewControllerAnimated:YES];
                      }];
    
    NSString *titleStr = @"";
    switch (self.profitType) {
        case 1:
            titleStr = @"直销收益";
            break;
        case 2:
            titleStr = @"裂变收益";
            break;
        case 3:
            titleStr = @"团队销售奖励";
            break;
        case 4:
            titleStr = @"发展合伙人奖励";
            break;
        case 5:
            titleStr = @"所选城市销售收益";
            break;
        default:
            break;
    }
    
    [self aty_setCenterNavItemtitle:titleStr titleColor:0x333333];
    
    [self creatEquityProfitViews];
    
    [self getEquityProfitData:nil];
}

- (void)creatEquityProfitViews {
    [self.view addSubview:self.equityProfitView];
    
    @weakify(self);
    self.equityProfitView.selectTimeBlock = ^{
        @strongify(self);
        //弹出时间选择器选择年月
        [self alertTimeSelect];
    };
}

- (void)getEquityProfitData:(NSString *)dateStr {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"userId"] = [[NSUserDefaults standardUserDefaults] objectForKey:PROJECT_USER_ID];
    params[@"incomeType"] = [NSNumber numberWithInteger:self.profitType];
    params[@"pageIndex"] = [NSNumber numberWithInteger:1];
    params[@"pageSize"] = [NSNumber numberWithInteger:8];
    if (!dateStr) {
        dateStr = [self getCurrentDay];
    }
    self.selectTime = dateStr;
    params[@"startTime"] = [NSString stringWithFormat:@"%@-01",dateStr];
    params[@"endTime"] = [NSString stringWithFormat:@"%@-%ld",dateStr,[self daysCountOfMonth:[dateStr substringWithRange:NSMakeRange(5, 2)] andYear:[dateStr substringWithRange:NSMakeRange(0, 4)]]];
    __block NSInteger pageindex = 1;
    @weakify(self);
    [[self.personalCenterVM.GetIncomeList execute:params] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (x != nil) {
            NSMutableArray *dataArr = [IncomeModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
            self.equityProfitView.dataArr = dataArr;
            self.equityProfitView.selectTime = [dateStr substringWithRange:NSMakeRange(0, 7)];
            [self.equityProfitView reloadData];
            pageindex = 2;
        }
    }];
    
    // 上拉加载更多数据指令
    self.equityProfitView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        params[@"pageIndex"] = [NSNumber numberWithInteger:pageindex];
        [[self.personalCenterVM.GetIncomeList execute:params] subscribeNext:^(id  _Nullable x) {
            [self.equityProfitView.mj_footer endRefreshing];
            if (x != nil) {
                NSMutableArray *newDataArr = [IncomeModel mj_objectArrayWithKeyValuesArray:x[@"Data"]];
                NSMutableArray *oldArr = self.equityProfitView.dataArr;
                NSMutableArray *allDataArr = [NSMutableArray arrayWithArray:oldArr];
                [allDataArr addObjectsFromArray:newDataArr];
                self.equityProfitView.dataArr = allDataArr;
                [self.equityProfitView reloadData];
                pageindex ++;
            }
        }];
    }];
    
}

#pragma mark -- 弹出时间选择器
- (void)alertTimeSelect {
    NSDate *minDate = [NSDate br_setYear:1990 month:1 day:1];
    NSDate *maxDate = [NSDate date];
    [BRDatePickerView showDatePickerWithTitle:@"请选择日期" dateType:BRDatePickerModeYM defaultSelValue:self.selectTime minDate:minDate maxDate:maxDate isAutoSelect:NO themeColor:nil resultBlock:^(NSString *selectValue) {
        [self getEquityProfitData:selectValue];
    } cancelBlock:^{
        NSLog(@"点击了背景或取消按钮");
    }];
}

#pragma mark -- 传入对应的年与月，就能获得该年该月的天数
-(NSInteger) daysCountOfMonth:(NSString *) month andYear:(NSString *)year {
    if(([month isEqualToString:@"01"])||([month isEqualToString:@"03"])||([month isEqualToString:@"05"])||([month isEqualToString:@"07"])||([month isEqualToString:@"08"])||([month isEqualToString:@"10"])||([month isEqualToString:@"12"])) {
        return 31;
    } else if (([month isEqualToString:@"04"])||([month isEqualToString:@"06"])||([month isEqualToString:@"09"])||([month isEqualToString:@"11"])) {
        return 30;
    } else {
        if ([year integerValue]%4==0 && [year integerValue]%100!=0) {
            //普通年份，非100整数倍
            return 29;
        }
        if ([year integerValue]%400 == 0) {
            //世纪年份
            return 29;
        }
        return 28;
    }
}
    
    
#pragma mark -- 获取日期
- (NSString *)getCurrentDay {
    NSDate *date=[NSDate date];
    NSDateFormatter *format1=[[NSDateFormatter alloc] init];
    [format1 setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateStr;
    dateStr=[format1 stringFromDate:date];
    return [dateStr substringWithRange:NSMakeRange(0, 7)];
}

- (PCEquityProfitView *)equityProfitView {
    if (!_equityProfitView) {
        _equityProfitView = [[PCEquityProfitView alloc] initWithFrame:CGRectMake(0, KNavgationBarHeight, KSCREEN_WIDTH, KSCREENH_HEIGHT - KNavgationBarHeight) style:UITableViewStylePlain];
    }
    return _equityProfitView;
}

- (PersonalCenterViewModel *)personalCenterVM {
    if (!_personalCenterVM) {
        _personalCenterVM = [[PersonalCenterViewModel alloc] init];
    }
    return _personalCenterVM;
}

@end
