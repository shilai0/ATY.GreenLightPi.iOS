//
//  PCEquityProfitView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/9.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCEquityProfitView.h"
#import "PCEquityProfitCell.h"
#import "UIButton+Common.h"

@implementation PCEquityProfitView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 100;
    [self registerClass:[PCEquityProfitCell class] forCellReuseIdentifier:NSStringFromClass([PCEquityProfitCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:@"NO" noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PCEquityProfitCell *equityProfitCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PCEquityProfitCell class])];
    equityProfitCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.profitViewType == ProfitViewTypeProfit) {
        equityProfitCell.incomeModel = self.dataArr[indexPath.row];
    } else if (self.profitViewType == ProfitViewTypeCashOutRecord) {
        equityProfitCell.myBillDetailModel = self.dataArr[indexPath.row];
    }
    return equityProfitCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 40)];
    headView.backgroundColor = KHEXRGB(0xF7F7F7);
    UIButton *timeBtn = [[UIButton alloc] initWithFrame:CGRectMake(12, 0, 150, 40)];
    [timeBtn setTitle:self.selectTime forState:UIControlStateNormal];
    [timeBtn setImage:[UIImage imageNamed:@"wf_select"] forState:UIControlStateNormal];
    [timeBtn setTitleColor:KHEXRGB(0x333333) forState:UIControlStateNormal];
    timeBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [timeBtn xs_layoutButtonWithButtonEdgeInsetsStyle:ButtonEdgeInsetsStyleRight WithImageAndTitleSpace:20];
    [headView addSubview:timeBtn];
    @weakify(self);
    [[timeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.selectTimeBlock) {
            self.selectTimeBlock();
        }
    }];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
