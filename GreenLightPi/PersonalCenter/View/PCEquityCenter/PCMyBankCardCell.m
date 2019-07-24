//
//  PCMyBankCardCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/11.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCMyBankCardCell.h"
#import "MyCardModel.h"
#import "UIImageView+WebCache.h"

@interface PCMyBankCardCell()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *bankLogolBackImageView;
@property (nonatomic, strong) UIImageView *bankLogolImageView;
@property (nonatomic, strong) UILabel *bankNameLabel;
@property (nonatomic, strong) UILabel *cardTypeLabel;
@property (nonatomic, strong) UILabel *cardNoLabel;
@end

@implementation PCMyBankCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatMyBankCardCellViews];
    }
    return self;
}

- (void)creatMyBankCardCellViews {
    [self.contentView addSubview:self.backImageView];
    [self.backImageView addSubview:self.bankLogolBackImageView];
    [self.backImageView addSubview:self.bankLogolImageView];
    [self.backImageView addSubview:self.bankNameLabel];
    [self.backImageView addSubview:self.cardTypeLabel];
    [self.backImageView addSubview:self.cardNoLabel];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@13);
        make.right.equalTo(@(-16));
        make.top.equalTo(@10);
        make.bottom.equalTo(@(-10));
        make.height.equalTo(@133);
    }];
    
    [self.bankLogolBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@18);
        make.top.equalTo(@15);
        make.width.height.equalTo(@53);
    }];
    
    [self.bankLogolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bankLogolBackImageView.mas_centerX);
        make.centerY.equalTo(self.bankLogolBackImageView.mas_centerY);
        make.width.height.equalTo(@23);
    }];
    
    [self.bankNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankLogolBackImageView.mas_right).offset(6);
        make.top.equalTo(self.backImageView.mas_top).offset(24);
        make.height.equalTo(@15);
        make.right.equalTo(self.backImageView.mas_right).offset(-10);
    }];
    
    [self.cardTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankLogolBackImageView.mas_right).offset(6);
        make.top.equalTo(self.bankNameLabel.mas_bottom).offset(10);
        make.height.equalTo(@11);
        make.right.equalTo(self.backImageView.mas_right).offset(-10);
    }];
    
    [self.cardNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankLogolBackImageView.mas_right).offset(6);
        make.top.equalTo(self.cardTypeLabel.mas_bottom).offset(20);
        make.height.equalTo(@9);
        make.right.equalTo(self.backImageView.mas_right).offset(-10);
    }];
}

- (void)setMyCardModel:(MyCardModel *)myCardModel {
    _myCardModel = myCardModel;
    [self.bankLogolImageView sd_setImageWithURL:[NSURL URLWithString:_myCardModel.ImagePath]];
    self.bankNameLabel.text = _myCardModel.BankName;
    self.cardTypeLabel.text = _myCardModel.CardTypeName;
    self.cardNoLabel.text = [NSString stringWithFormat:@"%ld",_myCardModel.CardNumber];
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"bankCardBack"];
    }
    return _backImageView;
}

- (UIImageView *)bankLogolBackImageView {
    if (!_bankLogolBackImageView) {
        _bankLogolBackImageView = [[UIImageView alloc] init];
        _bankLogolBackImageView.image = [UIImage imageNamed:@"bankLogolBack"];
    }
    return _bankLogolBackImageView;
}

- (UIImageView *)bankLogolImageView {
    if (!_bankLogolImageView) {
        _bankLogolImageView = [[UIImageView alloc] init];
        _bankLogolImageView.image = [UIImage imageNamed:@"bankLogol"];
    }
    return _bankLogolImageView;
}

- (UILabel *)bankNameLabel {
    if (!_bankNameLabel) {
        _bankNameLabel = [[UILabel alloc] init];
        _bankNameLabel.text = @"中国建设银行";
        _bankNameLabel.textColor = KHEXRGB(0xFFFFFF);
        _bankNameLabel.font = [UIFont systemFontOfSize:15];
        _bankNameLabel.alpha = 0.80;
    }
    return _bankNameLabel;
}

- (UILabel *)cardTypeLabel {
    if (!_cardTypeLabel) {
        _cardTypeLabel = [[UILabel alloc] init];
        _cardTypeLabel.text = @"储蓄卡";
        _cardTypeLabel.textColor = KHEXRGB(0xFFFFFF);
        _cardTypeLabel.font = [UIFont systemFontOfSize:12];
        _cardTypeLabel.alpha = 0.80;
    }
    return _cardTypeLabel;
}

- (UILabel *)cardNoLabel {
    if (!_cardNoLabel) {
        _cardNoLabel = [[UILabel alloc] init];
        _cardNoLabel.text = @"0000 0000 0000 0011";
        _cardNoLabel.textColor = KHEXRGB(0xFFFFFF);
        _cardNoLabel.font = [UIFont systemFontOfSize:11];
    }
    return _cardNoLabel;
}


@end
