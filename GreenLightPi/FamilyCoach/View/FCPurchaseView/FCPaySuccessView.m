//
//  FCPaySuccessView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/10.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCPaySuccessView.h"
#import "FcCoursesModel.h"
#import "CardTypeBaseApiModel.h"

@interface FCPaySuccessView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIButton *finishBtn;
@end

@implementation FCPaySuccessView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self fc_creatPaySuccessViews];
    }
    return self;
}

- (void)fc_creatPaySuccessViews {
    [self addSubview:self.backView];
    [self.backView addSubview:self.titleLabel];
    [self.backView addSubview:self.lineView];
    [self.backView addSubview:self.tipImageView];
    [self.backView addSubview:self.tipLabel];
    [self.backView addSubview:self.priceLabel];
    [self.backView addSubview:self.finishBtn];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.backView);
        make.height.equalTo(@53);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.height.equalTo(@1);
    }];
    
    [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView.mas_centerX);
        make.top.equalTo(self.lineView.mas_bottom).offset(53);
        make.height.width.equalTo(@64);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.tipImageView.mas_bottom).offset(29);
        make.height.equalTo(@14);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.backView);
        make.top.equalTo(self.tipLabel.mas_bottom).offset(23);
        make.height.equalTo(@18);
    }];
    
    [self.finishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@43);
        make.right.equalTo(@(-43));
        make.bottom.equalTo(self.backView.mas_bottom).offset(-28);
        make.height.equalTo(@40);
    }];
    
    @weakify(self);
    [[self.finishBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, nil, nil);
        }
    }];
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [UIView new];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 4, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = KHEXRGB(0x333333);
        _titleLabel.font = FONT(16);
        _titleLabel.text = @"吴伯凡.认知方法论";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [UIImageView new];
        _tipImageView.image = [UIImage imageNamed:@"fc_paySuccess"];
    }
    return _tipImageView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = KHEXRGB(0x44C08C);
        _tipLabel.font = [UIFont boldSystemFontOfSize:14];
        _tipLabel.text = @"支付成功";
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.text = @"199";
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.textColor = KHEXRGB(0x333333);
        _priceLabel.font = [UIFont boldSystemFontOfSize:23];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _priceLabel;
}

- (UIButton *)finishBtn {
    if (!_finishBtn) {
        _finishBtn = [UIButton new];
        [_finishBtn setTitle:@"完 成" forState:UIControlStateNormal];
        [_finishBtn setTitleColor:KHEXRGB(0x44C08C) forState:UIControlStateNormal];
        XSViewBorderRadius(_finishBtn, 4, 2, KHEXRGB(0x44C08C));
    }
    return _finishBtn;
}

- (void)setModel:(FcCoursesModel *)model {
    _model = model;
    self.titleLabel.text = _model.title;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",_model.price];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |                 NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    NSInteger hour = [dateComponent hour];
    NSInteger minute = [dateComponent minute];
    self.tipLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld  购买成功",year,month,day,hour,minute];
}

//- (void)setCardModel:(StoreCardApiModel *)cardModel {
//    _cardModel = cardModel;
//    self.titleLabel.text = _cardModel.cardName;
//    self.priceLabel.text = [NSString stringWithFormat:@"%@",_cardModel.cardPrice];
//    NSDate *now = [NSDate date];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute |                 NSCalendarUnitSecond;
//    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:now];
//    NSInteger year = [dateComponent year];
//    NSInteger month = [dateComponent month];
//    NSInteger day = [dateComponent day];
//    NSInteger hour = [dateComponent hour];
//    NSInteger minute = [dateComponent minute];
//    self.tipLabel.text = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld  购买成功",year,month,day,hour,minute];
//}

@end
