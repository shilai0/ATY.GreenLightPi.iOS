//
//  PCEquityProfitCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/9.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCEquityProfitCell.h"
#import "IncomeModel.h"
#import "UIImageView+WebCache.h"
#import "MyTeamModel.h"
#import "MyBillDetailModel.h"

@interface PCEquityProfitCell()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nikeLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIButton *valueBtn;
@end

@implementation PCEquityProfitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = KHEXRGB(0xF7F7F7);
        [self creatEquityProfitCellViews];
    }
    return self;
}

- (void)creatEquityProfitCellViews {
    [self.contentView addSubview:self.backImageView];
    [self.backImageView addSubview:self.headImageView];
    [self.backImageView addSubview:self.nikeLabel];
    [self.backImageView addSubview:self.timeLabel];
    [self.backImageView addSubview:self.valueBtn];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.right.equalTo(@(-18));
        make.top.equalTo(@6);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-7);
        make.height.equalTo(@55);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backImageView.mas_centerY);
        make.left.equalTo(@8);
        make.width.height.equalTo(@41);
    }];
    
    [self.nikeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@11);
        make.left.equalTo(self.headImageView.mas_right).offset(12);
        make.height.equalTo(@12);
        make.right.equalTo(@(-90));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(12);
        make.bottom.equalTo(self.headImageView.mas_bottom).offset(-3);
        make.height.equalTo(@10);
        make.right.equalTo(@(-90));
    }];
    
    [self.valueBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backImageView.mas_centerY);
        make.right.equalTo(self.backImageView);
        make.height.equalTo(@35);
        make.width.equalTo(@81);
    }];
    
}

- (void)setIncomeModel:(IncomeModel *)incomeModel {
    _incomeModel = incomeModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_incomeModel.ImagePath] placeholderImage:[UIImage imageNamed:@"profitheadBack"]];
    self.nikeLabel.text = [NSString stringWithFormat:@"昵称 %@",_incomeModel.NickName];
    self.timeLabel.text = [NSString stringWithFormat:@"时间: %@",_incomeModel.CreateTime];
    [self.valueBtn setTitle:_incomeModel.Money forState:UIControlStateNormal];
}

- (void)setMyTeamModel:(MyTeamModel *)myTeamModel {
    _myTeamModel = myTeamModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_myTeamModel.ImagePath] placeholderImage:[UIImage imageNamed:@"profitheadBack"]];
    self.nikeLabel.text = [NSString stringWithFormat:@"昵称 %@",_myTeamModel.NickName];
    self.timeLabel.text = [NSString stringWithFormat:@"时间: %@",_myTeamModel.CreateTime];
    [self.valueBtn setTitle:[NSString stringWithFormat:@"%ld",_myTeamModel.Count] forState:UIControlStateNormal];
}

- (void)setMyBillDetailModel:(MyBillDetailModel *)myBillDetailModel {
    _myBillDetailModel = myBillDetailModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_myBillDetailModel.ImagePath] placeholderImage:[UIImage imageNamed:@"profitheadBack"]];
    self.nikeLabel.text = _myBillDetailModel.Remark;
    self.timeLabel.text = [NSString stringWithFormat:@"时间: %@",_myBillDetailModel.DateTime];
    [self.valueBtn setTitle:myBillDetailModel.Money forState:UIControlStateNormal];
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backImageView, 5, 0, KHEXRGB(0xFFFFFF));
    }
    return _backImageView;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"profitheadBack"];
//        XSViewBorderRadius(_headImageView, 20.5, 0, KHEXRGB(0xFFFFFF));
    }
    return _headImageView;
}

- (UILabel *)nikeLabel {
    if (!_nikeLabel) {
        _nikeLabel = [[UILabel alloc] init];
        _nikeLabel.text = @"昵称 购买独角兽乐园";
        _nikeLabel.textColor = KHEXRGB(0x000000);
        _nikeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _nikeLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:10];
        _timeLabel.textColor = KHEXRGB(0x000000);
        _timeLabel.alpha = 0.6;
        _timeLabel.text = @"时间: 7月22日  12:11";
    }
    return _timeLabel;
}

- (UIButton *)valueBtn {
    if (!_valueBtn) {
        _valueBtn = [[UIButton alloc] init];
        [_valueBtn setBackgroundImage:[UIImage imageNamed:@"teamCountBack"] forState:UIControlStateNormal];
        [_valueBtn setTitle:@"  +88888  " forState:UIControlStateNormal];
        [_valueBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        _valueBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        _valueBtn.titleLabel.adjustsFontSizeToFitWidth=YES;
    }
    return _valueBtn;
}

@end
