//
//  FCEvaluateView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/21.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCEvaluateView.h"
#import "FCStartView.h"

@interface FCEvaluateView()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *scoreValueLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *evaluateLabel;
@property (nonatomic, strong) FCStartView *startView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *tipLabel;
@end

@implementation FCEvaluateView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self fc_creatEvaluateViews];
        self.backgroundColor = KHEXRGB(0xFFFFFF);
    }
    return self;
}

- (void)fc_creatEvaluateViews {
    [self addSubview:self.scoreValueLabel];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.evaluateLabel];
    [self addSubview:self.startView];
    [self addSubview:self.lineView];
    [self addSubview:self.descriptionTextView];
    [self.descriptionTextView addSubview:self.tipLabel];
    
    self.scoreValueLabel.hidden = YES;
    self.scoreLabel.hidden = YES;
    self.evaluateLabel.hidden = YES;
    
    [self.scoreValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(@18);
        make.width.equalTo(@(KSCREEN_WIDTH/2 - 2));
        make.height.equalTo(@23);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@28);
        make.left.equalTo(self.scoreValueLabel.mas_right).offset(5);
        make.right.equalTo(self);
        make.height.equalTo(@13);
    }];
    
    [self.evaluateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.scoreValueLabel.mas_bottom).offset(9);
        make.height.equalTo(@14);
    }];
    
    [self.startView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@((KSCREEN_WIDTH - 168)/2));
        make.right.equalTo(@(-(KSCREEN_WIDTH - 168)/2));
        make.height.equalTo(@25);
        make.top.equalTo(self.evaluateLabel.mas_bottom).offset(9);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.startView.mas_bottom).offset(18);
        make.left.right.equalTo(self);
        make.height.equalTo(@1);
    }];
    
    [self.descriptionTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.lineView.mas_bottom);
        make.bottom.equalTo(self);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descriptionTextView.mas_top).offset(14);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.height.equalTo(@15);
    }];
    
    @weakify(self);
    self.startView.scoreBlock = ^(float level) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock([[NSNumber numberWithFloat:level] integerValue], nil, nil);
        }
    };
}

- (UILabel *)scoreValueLabel {
    if (!_scoreValueLabel) {
        _scoreValueLabel = [UILabel new];
        _scoreValueLabel.textColor = KHEXRGB(0x44C08C);
        _scoreValueLabel.font = [UIFont systemFontOfSize:30];
        _scoreValueLabel.textAlignment = NSTextAlignmentRight;
        _scoreValueLabel.text = @"5";
    }
    return _scoreValueLabel;
}

- (UILabel *)scoreLabel {
    if (!_scoreLabel) {
        _scoreLabel = [UILabel new];
        _scoreLabel.textColor = KHEXRGB(0x44C08C);
        _scoreLabel.font = [UIFont systemFontOfSize:14];
        _scoreLabel.text = @"分";
    }
    return _scoreLabel;
}

- (UILabel *)evaluateLabel {
    if (!_evaluateLabel) {
        _evaluateLabel = [UILabel new];
        _evaluateLabel.textColor = KHEXRGB(0x999999);
        _evaluateLabel.font = [UIFont systemFontOfSize:14];
        _evaluateLabel.text = @"推荐，非常棒的课程，值得学习！";
        _evaluateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _evaluateLabel;
}

- (FCStartView *)startView {
    if (!_startView) {
        _startView = [FCStartView new];
        _startView.canScore = YES;
        _startView.iconSize = CGSizeMake(25, 24);
        _startView.levelInt = YES;
        _startView.level = 0;
        _startView.iconFull = [UIImage imageNamed:@"comment_star_highlighted"];
        _startView.iconEmpty = [UIImage imageNamed:@"comment_star"];
        _startView.iconHalf = [UIImage imageNamed:@"comment_star_half"];

    }
    return _startView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

- (UITextView *)descriptionTextView {
    if (!_descriptionTextView) {
        _descriptionTextView = [UITextView new];
        _descriptionTextView.font = [UIFont systemFontOfSize:15];
        _descriptionTextView.textColor = KHEXRGB(0x333333);
        _descriptionTextView.delegate = self;
    }
    return _descriptionTextView;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [UILabel new];
        _tipLabel.textColor = KHEXRGB(0xC2C2C2);
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.text = @"您的宝贵评价，对我们非常有用哦~";
    }
    return _tipLabel;
}

#pragma mark -- UITextViewDelegate
- (void) textViewDidChange:(UITextView *)textView{
    if ([textView.text length] == 0) {
        [self.tipLabel setHidden:NO];
    }else{
        [self.tipLabel setHidden:YES];
    }
}

- (void)setDicData:(NSDictionary *)dicData {
    _dicData = dicData;
    self.scoreValueLabel.hidden = NO;
    self.scoreLabel.hidden = NO;
    self.evaluateLabel.hidden = NO;
    self.scoreValueLabel.text = [NSString stringWithFormat:@"%@",_dicData[@"starValue"]];
    self.evaluateLabel.text = _dicData[@"titleValue"];
}

@end
