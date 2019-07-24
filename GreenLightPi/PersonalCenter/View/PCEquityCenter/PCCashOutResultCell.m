//
//  PCCashOutResultCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/16.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCCashOutResultCell.h"

@interface PCCashOutResultCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@end

@implementation PCCashOutResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatCashOutResultCellViews];
    }
    return self;
}

- (void)creatCashOutResultCellViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.valueLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@15);
        make.bottom.equalTo(@(-15));
        make.height.equalTo(@20);
        make.width.equalTo(@100);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@15);
        make.bottom.right.equalTo(@(-15));
        make.height.equalTo(@20);
        make.left.equalTo(self.titleLabel.mas_right).offset(20);

    }];
}

- (void)setDataDic:(NSDictionary *)dataDic {
    _dataDic = dataDic;
    self.titleLabel.text = _dataDic[@"title"];
    self.valueLabel.text = _dataDic[@"value"];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"提现金额";
        _titleLabel.textColor = KHEXRGB(0x1A1A1A);
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textColor = KHEXRGB(0x1A1A1A);
        _valueLabel.text = @"￥1000";
        _valueLabel.font = [UIFont systemFontOfSize:14];
        _valueLabel.textAlignment = NSTextAlignmentRight;
        _valueLabel.alpha = 0.5;
    }
    return _valueLabel;
}

@end
