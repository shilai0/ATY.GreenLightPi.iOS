//
//  PCForgetPassWordView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/16.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCForgetPassWordView.h"
#import "MyCardModel.h"

@implementation PCForgetPassWordView

- (void)xs_initializesOperating {
    [super xs_initializesOperating];
    self.rowHeight = 60;
    [self registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
}

- (void)setDataArr:(NSMutableArray *)dataArr {
    [super setDataArr:dataArr];
    
    [self xs_setTableViewEmptyImage:@"LackPage_content.png" emptyBtnTitle:@"NO" noneDataFooterTitle:@"已加载全部数据"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *styleCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    styleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 1) {
        styleCell.textLabel.text = @"添加银行卡";
    } else if (indexPath.section == 0) {
        styleCell.textLabel.text = [NSString stringWithFormat:@"%@(%@)",self.selectBankModel.BankName,[self.selectBankModel.CardNumber substringWithRange:NSMakeRange(self.selectBankModel.CardNumber.length - 4, 4)]];
    }
    return styleCell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 50)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, KSCREEN_WIDTH - 40, 20)];
    titleLabel.textColor = KHEXRGB(0x999999);
    titleLabel.font = [UIFont systemFontOfSize:13];
    if (section == 0) {
        titleLabel.text = @"请重新绑定银行卡以找回密码";
    } else if (section == 1) {
        titleLabel.text = @"添加新卡找回";
    }
    [headView addSubview:titleLabel];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.pushBlock){
        self.pushBlock(self.dataArr,indexPath);
    }
}

@end
