//
//  PCCashOutResultHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/16.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCCashOutResultHeadView.h"

@interface PCCashOutResultHeadView()
@property (nonatomic, strong) UIImageView *logolImageView;
@property (nonatomic, strong) UILabel *tipLabel1;
@property (nonatomic, strong) UILabel *tipLabel2;
@end

@implementation PCCashOutResultHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatCashOutResultHeadViews];
    }
    return self;
}

- (void)creatCashOutResultHeadViews {
    [self addSubview:self.logolImageView];
    [self addSubview:self.tipLabel1];
    [self addSubview:self.tipLabel2];
    
    [self.logolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@20);
        make.width.height.equalTo(@67);
    }];
    
    [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logolImageView.mas_bottom).offset(28);
        make.height.equalTo(@15);
        make.left.right.equalTo(self);
    }];
    
    [self.tipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipLabel1.mas_bottom).offset(14);
        make.height.equalTo(@11);
        make.left.right.equalTo(self);
    }];
}

- (UIImageView *)logolImageView {
    if (!_logolImageView) {
        _logolImageView = [[UIImageView alloc] init];
        _logolImageView.image = [UIImage imageNamed:@"cashOutResult"];
    }
    return _logolImageView;
}

- (UILabel *)tipLabel1 {
    if (!_tipLabel1) {
        _tipLabel1 = [[UILabel alloc] init];
        _tipLabel1.textAlignment = NSTextAlignmentCenter;
        _tipLabel1.text = @"提现申请成功，等待银行处理";
        _tipLabel1.textColor = KHEXRGB(0xFF5931);
        _tipLabel1.font = [UIFont systemFontOfSize:15];
    }
    return _tipLabel1;
}

- (UILabel *)tipLabel2 {
    if (!_tipLabel2) {
        _tipLabel2 = [[UILabel alloc] init];
        _tipLabel2.text = @"预估2-4个工作日";
        _tipLabel2.textColor = KHEXRGB(0x939393);
        _tipLabel2.font = [UIFont systemFontOfSize:11];
        _tipLabel2.textAlignment = NSTextAlignmentCenter;
        _tipLabel2.alpha = 0.8;
    }
    return _tipLabel2;
}


@end
