//
//  PCSelectBankCardCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/14.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCSelectBankCardCell.h"
#import "MyCardModel.h"
#import "UIImageView+WebCache.h"

@interface PCSelectBankCardCell()
@property (nonatomic, strong) UIImageView *logolImageView;
@property (nonatomic, strong) UILabel *bankInfoLabel;
@property (nonatomic, strong) UIButton *selectBtn;
@end

@implementation PCSelectBankCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatSelecBankCardCellViews];
    }
    return self;
}

- (void)creatSelecBankCardCellViews {
    [self.contentView addSubview:self.logolImageView];
    [self.contentView addSubview:self.bankInfoLabel];
    [self.contentView addSubview:self.selectBtn];
    
    [self.logolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.width.height.equalTo(@23);
        make.bottom.equalTo(@(-10));
    }];
    
    [self.bankInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.logolImageView.mas_centerY);
        make.left.equalTo(self.logolImageView.mas_right).offset(10);
        make.right.equalTo(@(-50));
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.right.equalTo(@(-10));
        make.width.height.equalTo(@30);
    }];
}

- (void)setMyCardModel:(MyCardModel *)myCardModel {
    _myCardModel = myCardModel;
    [self.logolImageView sd_setImageWithURL:[NSURL URLWithString:_myCardModel.ImagePath]];
    self.bankInfoLabel.text = [NSString stringWithFormat:@"%@(%@)",_myCardModel.BankName,[_myCardModel.CardNumber substringWithRange:NSMakeRange(_myCardModel.CardNumber.length - 4, 4)]];
    if (_myCardModel.isSelect) {
        [self.selectBtn setImage:[UIImage imageNamed:@"pc_equipSelect"] forState:UIControlStateNormal];
    } else {
        [self.selectBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    }
}

- (UIImageView *)logolImageView {
    if (!_logolImageView) {
        _logolImageView = [[UIImageView alloc] init];
        _logolImageView.image = [UIImage imageNamed:@"bankLogol"];
    }
    return _logolImageView;
}

- (UILabel *)bankInfoLabel {
    if (!_bankInfoLabel) {
        _bankInfoLabel = [[UILabel alloc] init];
        _bankInfoLabel.text = @"中国建设银行（0011）";
        _bankInfoLabel.textColor = KHEXRGB(0x333333);
        _bankInfoLabel.font = [UIFont systemFontOfSize:15];
    }
    return _bankInfoLabel;
}

- (UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [[UIButton alloc] init];
        [_selectBtn setImage:[UIImage imageNamed:@"PC_Normal"] forState:UIControlStateNormal];
    }
    return _selectBtn;
}

@end
