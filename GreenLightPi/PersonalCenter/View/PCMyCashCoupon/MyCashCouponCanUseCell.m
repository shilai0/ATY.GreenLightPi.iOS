//
//  MyCashCouponCanUseCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/30.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "MyCashCouponCanUseCell.h"
#import "PersonalCenterUserModel.h"

@interface MyCashCouponCanUseCell()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *tipLabel1;
@property (nonatomic, strong) UILabel *tipLabel2;
@property (nonatomic, strong) UILabel *tipLabel3;
@property (nonatomic, strong) UIView  *lineView;
@property (nonatomic, strong) UILabel *tipLabel4;
@end

@implementation MyCashCouponCanUseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = KHEXRGB(0xF7F7F7);
        [self creatMyCashCouponCanUserCellViews];
    }
    return self;
}

- (void)creatMyCashCouponCanUserCellViews {
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.backImageView];
    [self.backImageView addSubview:self.valueLabel];
    [self.backImageView addSubview:self.nameLabel];
    [self.backView addSubview:self.tipLabel1];
    [self.backView addSubview:self.tipLabel2];
    [self.backView addSubview:self.tipLabel3];
    [self.backView addSubview:self.lineView];
    [self.backView addSubview:self.tipLabel4];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@16);
        make.right.equalTo(@(-16));
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.equalTo(@119);
    }];
    
    [self.backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.backView);
        make.width.equalTo(@113);
    }];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backImageView.mas_centerX).offset(-5);
        make.height.equalTo(@25);
        make.top.equalTo(@37);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.valueLabel.mas_centerX);
        make.top.equalTo(self.valueLabel.mas_bottom).offset(11);
        make.height.equalTo(@12);
    }];
    
    [self.tipLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backImageView.mas_right).offset(28);
        make.top.equalTo(@19);
        make.height.equalTo(@13);
        make.right.equalTo(@(-16));
    }];
    
    [self.tipLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backImageView.mas_right).offset(28);
        make.top.equalTo(self.tipLabel1.mas_bottom).offset(10);
        make.height.equalTo(@13);
        make.right.equalTo(@(-16));
    }];
    
    [self.tipLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backImageView.mas_right).offset(28);
        make.top.equalTo(self.tipLabel2.mas_bottom).offset(10);
        make.height.equalTo(@13);
        make.right.equalTo(@(-16));
    }];
    
//    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.backImageView.mas_right);
//        make.top.equalTo(self.tipLabel3.mas_bottom).offset(11);
//        make.height.equalTo(@1);
//        make.right.equalTo(self.backView.mas_right);
//    }];
    
    [self.tipLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backImageView.mas_right).offset(28);
        make.top.equalTo(self.lineView.mas_bottom).offset(9);
        make.height.equalTo(@12);
        make.right.equalTo(@(-16));
    }];
    
    [self addBorderToLayer:self.lineView];
}

- (void)setPersonalCenterModel:(PersonalCenterUserModel *)personalCenterModel {
    _personalCenterModel = personalCenterModel;
    NSString *contentStr = [NSString stringWithFormat:@"¥%ld",_personalCenterModel.boxVoucher];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentStr];
    //设置尺寸
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:NSMakeRange(0, 1)]; // 0为起始位置 length是从起始位置开始 设置指定字体尺寸的长度
    self.valueLabel.attributedText = attributedString;
}

#pragma mark -- 画虚线
- (void)addBorderToLayer:(UIView *)view
{
    CAShapeLayer *border = [CAShapeLayer layer];
    //  线条颜色
    border.strokeColor = KHEXRGB(0xEAEAEA).CGColor;
    border.fillColor = nil;
    UIBezierPath *pat = [UIBezierPath bezierPath];
    [pat moveToPoint:CGPointMake(0, 0)];
    if (CGRectGetWidth(view.frame) > CGRectGetHeight(view.frame)) {
        [pat addLineToPoint:CGPointMake(view.bounds.size.width, 0)];
    }else{
        [pat addLineToPoint:CGPointMake(0, view.bounds.size.height)];
    }
    border.path = pat.CGPath;
    border.frame = view.bounds;
    border.lineWidth = 0.5;
    border.lineCap = @"butt";
    //  第一个是 线条长度   第二个是间距    nil时为实线
    border.lineDashPattern = @[@3, @2];
    [view.layer addSublayer:border];
}

#pragma mark -- 懒加载
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}

- (UIImageView *)backImageView {
    if (!_backImageView) {
        _backImageView = [[UIImageView alloc] init];
        _backImageView.image = [UIImage imageNamed:@"cashCouponBack"];
    }
    return _backImageView;
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textColor = KHEXRGB(0xFFFFFF);
        _valueLabel.font = [UIFont boldSystemFontOfSize:25];
    }
    return _valueLabel;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = KHEXRGB(0xFFFFFF);
        _nameLabel.font = [UIFont systemFontOfSize:12];
        _nameLabel.text = @"代金券";
    }
    return _nameLabel;
}

- (UILabel *)tipLabel1 {
    if (!_tipLabel1) {
        _tipLabel1 = [[UILabel alloc] init];
        _tipLabel1.textColor = KHEXRGB(0x646464);
        _tipLabel1.font = [UIFont systemFontOfSize:13];
        NSString *contentStr = @"积分兑换：可抵扣100%";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentStr];
        //设置尺寸
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(0, 5)]; // 0为起始位置 length是从起始位置开始 设置指定字体尺寸的长度
        _tipLabel1.attributedText = attributedString;
    }
    return _tipLabel1;
}

- (UILabel *)tipLabel2 {
    if (!_tipLabel2) {
        _tipLabel2 = [[UILabel alloc] init];
        _tipLabel2.textColor = KHEXRGB(0x646464);
        _tipLabel2.font = [UIFont systemFontOfSize:13];
        NSString *contentStr = @"数字商品：可抵扣60%";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentStr];
        //设置尺寸
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(0, 5)]; // 0为起始位置 length是从起始位置开始 设置指定字体尺寸的长度
        _tipLabel2.attributedText = attributedString;
    }
    return _tipLabel2;
}

- (UILabel *)tipLabel3 {
    if (!_tipLabel3) {
        _tipLabel3 = [[UILabel alloc] init];
        _tipLabel3.textColor = KHEXRGB(0x646464);
        _tipLabel3.font = [UIFont systemFontOfSize:13];
        NSString *contentStr = @"实物类商品：可抵扣20%";
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:contentStr];
        //设置尺寸
        [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13] range:NSMakeRange(0, 6)]; // 0为起始位置 length是从起始位置开始 设置指定字体尺寸的长度
        _tipLabel3.attributedText = attributedString;
    }
    return _tipLabel3;
}

- (UILabel *)tipLabel4 {
    if (!_tipLabel4) {
        _tipLabel4 = [[UILabel alloc] init];
        _tipLabel4.text = @"欢迎使用";
        _tipLabel4.textColor = KHEXRGB(0x999999);
        _tipLabel4.font = [UIFont systemFontOfSize:12];
    }
    return _tipLabel4;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(120, 88, KSCREEN_WIDTH - 32 - 120, 1)];
    }
    return _lineView;
}

@end
