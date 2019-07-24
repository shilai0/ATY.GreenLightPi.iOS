//
//  PCEquityCenterProfitView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/6.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCEquityCenterProfitView.h"

@interface PCEquityCenterProfitView()
@property (nonatomic, strong) UILabel *profitCountLabel;
@property (nonatomic, strong) UILabel *profitNameLabel;
@end

@implementation PCEquityCenterProfitView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self creatProfitViews];
    }
    return self;
}

- (void)creatProfitViews {
    [self addSubview:self.profitCountLabel];
    [self addSubview:self.profitNameLabel];
    [self.profitCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(@5);
        make.height.equalTo(@9);
    }];
    
    [self.profitNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.profitCountLabel.mas_bottom).offset(2);
        make.height.equalTo(@9);
        make.bottom.equalTo(@(-5));
    }];
}

- (void)setProfitDic:(NSDictionary *)profitDic {
    _profitDic = profitDic;
    self.profitCountLabel.text = profitDic[@"profitCount"];
    self.profitNameLabel.text = profitDic[@"profitName"];
}

- (UILabel *)profitCountLabel {
    if (!_profitCountLabel) {
        _profitCountLabel = [[UILabel alloc] init];
        _profitCountLabel.textColor = KHEXRGB(0xFFFFFF);
        _profitCountLabel.font = [UIFont systemFontOfSize:11];
        _profitCountLabel.textAlignment = NSTextAlignmentCenter;
        _profitCountLabel.text = @"847569.88";
    }
    return _profitCountLabel;
}

- (UILabel *)profitNameLabel {
    if (!_profitNameLabel) {
        _profitNameLabel = [[UILabel alloc] init];
        _profitNameLabel.textColor = KHEXRGB(0xFFFFFF);
        _profitNameLabel.font = [UIFont systemFontOfSize:9];
        _profitNameLabel.textAlignment = NSTextAlignmentCenter;
        _profitNameLabel.alpha = 0.55;
        _profitNameLabel.text = @"直销收益";
    }
    return _profitNameLabel;
}

@end
