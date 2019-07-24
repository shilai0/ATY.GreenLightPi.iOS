//
//  PCEquityCenterMainHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/6.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCEquityCenterMainHeadView.h"
#import "IncomeCenterModel.h"
#import "UIImageView+WebCache.h"
#import "PCEquityCenterProfitView.h"

@interface PCEquityCenterMainHeadView()
@property (nonatomic, strong) UIImageView *headBackImageView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *identityLogol;
@property (nonatomic, strong) UILabel *identityLabel;
@property (nonatomic, strong) UIButton *profitCountBtn;
@property (nonatomic, strong) UIButton *crashWithdrawalBtn;
@property (nonatomic, strong) NSMutableArray *profitArr;
@end

@implementation PCEquityCenterMainHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame ]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self creatEquityCenterHeadViews];
    }
    return self;
}

- (void)creatEquityCenterHeadViews {
    [self addSubview:self.headBackImageView];
    [self.headBackImageView addSubview:self.headImageView];
    [self.headBackImageView addSubview:self.nameLabel];
    [self.headBackImageView addSubview:self.identityLogol];
    [self.headBackImageView addSubview:self.identityLabel];
    [self.headBackImageView addSubview:self.profitCountBtn];
    [self.headBackImageView addSubview:self.crashWithdrawalBtn];
    
    [self.headBackImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.right.equalTo(@(-15));
        make.top.equalTo(self);
        make.height.equalTo(@125);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@18);
        make.width.height.equalTo(@53);
    }];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@30);
        make.left.equalTo(self.headImageView.mas_right).offset(5);
        make.height.equalTo(@15);
    }];

    [self.identityLogol mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLabel.mas_bottom).offset(9);
        make.left.equalTo(self.headImageView.mas_right).offset(4);
        make.width.height.equalTo(@13);
    }];

    [self.identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.identityLogol.mas_right).offset(4);
        make.centerY.equalTo(self.identityLogol.mas_centerY);
        make.height.equalTo(@9);
    }];

    [self.profitCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(-16));
        make.centerY.equalTo(self.nameLabel.mas_centerY);
        make.height.equalTo(@16);
    }];

    [self.crashWithdrawalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.profitCountBtn.mas_bottom).offset(10);
        make.centerX.equalTo(self.profitCountBtn.mas_centerX);
        make.height.equalTo(@18);
        make.width.equalTo(@63);
    }];
    
    @weakify(self);
    [[self.crashWithdrawalBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
    
    [[self.profitCountBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(1, nil, nil);
        }
    }];
}

- (void)setIncomeModel:(IncomeCenterModel *)incomeModel {
    _incomeModel = incomeModel;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:_incomeModel.imagePath] placeholderImage:[UIImage imageNamed:@"headDefault"]];
    self.nameLabel.text = _incomeModel.nikeName;
    self.identityLabel.text = _incomeModel.GradeStr;
    [self.profitCountBtn setTitle:[NSString stringWithFormat:@"￥ %0.2f",[_incomeModel.Income floatValue]] forState:UIControlStateNormal];
    //UserGrade (string, optional): 用户分销等级 //A联合创始人 B城市合伙人 C推广合伙人 D消费代言人 E普通用户
    if ([_incomeModel.UserGrade isEqualToString:@"C"]) {
        [self.profitArr addObjectsFromArray:@[@{@"profitName":@"直销收益",@"profitCount":[NSString stringWithFormat:@"%.2f",[_incomeModel.DirectSaleIncome floatValue]]},@{@"profitName":@"团队销售奖金",@"profitCount":[NSString stringWithFormat:@"%.2f",[_incomeModel.TeamIncome floatValue]]},@{@"profitName":@"裂变收益",@"profitCount":[NSString stringWithFormat:@"%.2f",[_incomeModel.FissionIncome floatValue]]},]];
    } else {
        [self.profitArr addObjectsFromArray:@[@{@"profitName":@"直销收益",@"profitCount":[NSString stringWithFormat:@"%.2f",[_incomeModel.DirectSaleIncome floatValue]]},@{@"profitName":@"团队销售奖金",@"profitCount":[NSString stringWithFormat:@"%.2f",[_incomeModel.TeamIncome floatValue]]},@{@"profitName":@"所选城市销售收益",@"profitCount":[NSString stringWithFormat:@"%.2f",[_incomeModel.CityIncome floatValue]]},@{@"profitName":@"发展合伙人收益",@"profitCount":[NSString stringWithFormat:@"%.2f",[_incomeModel.DevelopIncome floatValue]]},@{@"profitName":@"裂变收益",@"profitCount":[NSString stringWithFormat:@"%.2f",[_incomeModel.FissionIncome floatValue]]},]];
    }
    [self creatProfitViews:self.profitArr];
}

- (void)creatProfitViews:(NSMutableArray *)profitArr {
        for (int i = 0; i < profitArr.count; i ++) {
            PCEquityCenterProfitView *profitView = [[PCEquityCenterProfitView alloc] init];
            profitView.tag = 1000 + i;
            profitView.profitDic = profitArr[i];
            [self.headBackImageView addSubview:profitView];
            [profitView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(@(((KSCREEN_WIDTH - 30 - (profitArr.count - 1))/profitArr.count + 1)*i));
                make.bottom.equalTo(self.headBackImageView.mas_bottom);
                make.width.equalTo(@((KSCREEN_WIDTH - 30 - (profitArr.count - 1))/profitArr.count));
                make.height.equalTo(@30);
            }];
            
            if (i != profitArr.count - 1) {
                UIView *lineView = [[UIView alloc] init];
                lineView.backgroundColor = KHEXRGB(0xF96554);
                lineView.alpha = 0.55;
                XSViewBorderRadius(lineView, 1, 0, KHEXRGB(0xFFFFFF));
                [self.headBackImageView addSubview:lineView];
                [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(@(((KSCREEN_WIDTH - 30 - (profitArr.count - 1))/profitArr.count)*(i+1) + i));
                    make.bottom.equalTo(self.headBackImageView.mas_bottom).offset(-5);
                    make.width.equalTo(@1);
                    make.height.equalTo(@20);
                }];
            }
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
            [profitView addGestureRecognizer:tap];
        }
}

- (void)tapClick:(UITapGestureRecognizer *)tap {
    if ([tap.view isKindOfClass:[PCEquityCenterProfitView class]]) {
        PCEquityCenterProfitView *profitView = (PCEquityCenterProfitView *)tap.view;
        if (self.profitClickBlock) {
            self.profitClickBlock(self.profitArr,profitView.tag - 1000);
        }
    }
}

- (UIImageView *)headBackImageView {
    if (!_headBackImageView) {
        _headBackImageView = [[UIImageView alloc] init];
        _headBackImageView.image = [UIImage imageNamed:@"headBack"];
        _headBackImageView.userInteractionEnabled = YES;
    }
    return _headBackImageView;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"headDefault"];
        XSViewBorderRadius(_headImageView, 26.5, 0, KHEXRGB(0xFFFFFF));
    }
    return _headImageView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"壮志凌云";
        _nameLabel.textColor = KHEXRGB(0xFFFFFF);
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
    }
    return _nameLabel;
}

- (UIImageView *)identityLogol {
    if (!_identityLogol) {
        _identityLogol = [[UIImageView alloc] init];
        _identityLogol.image = [UIImage imageNamed:@"Unicorn"];
    }
    return _identityLogol;
}

- (UILabel *)identityLabel {
    if (!_identityLabel) {
        _identityLabel = [[UILabel alloc] init];
        _identityLabel.textColor = KHEXRGB(0xFFFFFF);
        _identityLabel.text = @"联合创始人";
        _identityLabel.font = [UIFont systemFontOfSize:9];
        _identityLabel.alpha = 0.8;
    }
    return _identityLabel;
}

- (UIButton *)profitCountBtn {
    if (!_profitCountBtn) {
        _profitCountBtn = [[UIButton alloc] init];
        [_profitCountBtn setTitleColor:KHEXRGB(0xFFDD76) forState:UIControlStateNormal];
        _profitCountBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _profitCountBtn;
}

- (UIButton *)crashWithdrawalBtn {
    if (!_crashWithdrawalBtn) {
        _crashWithdrawalBtn = [[UIButton alloc] init];
        [_crashWithdrawalBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_crashWithdrawalBtn setTitleColor:KHEXRGB(0xFA7655) forState:UIControlStateNormal];
        _crashWithdrawalBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [_crashWithdrawalBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        XSViewBorderRadius(_crashWithdrawalBtn, 9, 0, KHEXRGB(0xFFFFFF));
    }
    return _crashWithdrawalBtn;
}

- (NSMutableArray *)profitArr {
    if (!_profitArr) {
        _profitArr = [[NSMutableArray alloc] init];
    }
    return _profitArr;
}

@end
