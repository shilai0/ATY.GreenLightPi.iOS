//
//  RLSegmentView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "RLSegmentView.h"

@interface RLSegmentView()
@property(strong,nonatomic)UIButton *selectBtn;
@property(strong,nonatomic)UIView *lineView;
@property(strong,nonatomic)NSArray *items;
@property(assign,nonatomic)NSInteger lineWidth;
@property(strong,nonatomic)UIView *backLineView;
@end

@implementation RLSegmentView

- (UIView *)backLineView {
    if (!_backLineView) {
        _backLineView = [UIView new];
        _backLineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _backLineView;
}

- (instancetype)initWithItems:(NSArray *)items{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.items = items;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    CGFloat Width = KSCREEN_WIDTH / self.items.count;
    self.lineWidth = (KSCREEN_WIDTH - 56)/self.items.count;

    self.lineView = [UIView new];
    self.lineView.backgroundColor = KHEXRGB(0x00D399);
    [self addSubview:self.lineView];
    
    @weakify(self);
    [self.items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        UIButton *partyBtn = [UIButton new];
        partyBtn.frame = CGRectMake(idx * Width, 0, Width, 40);
        [partyBtn setTitle:NSLocalizedString(obj, nil) forState:UIControlStateNormal];
        [partyBtn setTitleColor:KHEXRGB(0x333333) forState:UIControlStateNormal];
        partyBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self addSubview:partyBtn];
        partyBtn.tag = 200 + idx;
        
        if (idx == 0) {
            self.selectBtn = partyBtn;
            [self.selectBtn setTitleColor:KHEXRGB(0x00D399) forState:UIControlStateNormal];
            self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        }
        
        [[partyBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.selectBtn != partyBtn) {
                [partyBtn setTitleColor:KHEXRGB(0x00D399) forState:UIControlStateNormal];
                partyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
                [self.selectBtn setTitleColor:KHEXRGB(0x333333) forState:UIControlStateNormal];
                self.selectBtn.titleLabel.font = [UIFont systemFontOfSize:16];
                self.selectBtn = partyBtn;
                [self setNeedsLayout];
                [self setNeedsDisplay];
            }

        }];
    }];
    
    [self addSubview:self.backLineView];
    [self.backLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@28);
        make.right.equalTo(@(-28));
        make.bottom.equalTo(self);
        make.height.equalTo(@1);
    }];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSInteger index = self.selectBtn.tag - 200;
    
    [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(self.lineWidth));
        make.bottom.equalTo(self);
        make.left.equalTo(self.backLineView.mas_left).offset(index*(self.lineWidth));
        make.height.equalTo(@3);
    }];
    
    if (self.DidSegmentClickBlock) {
        self.DidSegmentClickBlock(self.selectBtn.tag - 200);
    }
    
}

@end
