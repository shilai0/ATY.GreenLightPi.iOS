//
//  PCMyTeamHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/10.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCMyTeamHeadView.h"

@interface PCMyTeamHeadView()
@property (nonatomic, strong) UIButton *subBtn;
@property (nonatomic, strong) UIButton *selectBtn;
@end

@implementation PCMyTeamHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
    }
    return self;
}

- (void)creatMyteamHeadViews:(NSArray *)levelArr {
    for (int i = 0; i < levelArr.count; i ++) {
        self.subBtn = [[UIButton alloc] init];
        [self.subBtn setTitle:[levelArr objectAtIndex:i] forState:UIControlStateNormal];
        [self.subBtn setTitleColor:KHEXRGB(0xF37065) forState:UIControlStateNormal];
        self.subBtn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        XSViewBorderRadius(self.subBtn, 15, 2, KHEXRGB(0xF37065));
        [self.subBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        self.subBtn.tag = 1000 + i;
        [self addSubview:self.subBtn];
        
        if (i == 0) {
            self.selectBtn = self.subBtn;
            [self.subBtn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
            [self.subBtn setBackgroundColor:KHEXRGB(0xF37065)];
        }
        
        [self.subBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@12);
            make.bottom.equalTo(@(-9));
            make.height.equalTo(@29);
            make.width.equalTo(@((KSCREEN_WIDTH - 48)/2));
            make.left.equalTo(@(15 + (((KSCREEN_WIDTH - 48)/2)*i) + 18*i));
        }];
        
        @weakify(self);
        [[self.subBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self headBtnClick:x];
        }];
    }
}

-(void)setUserLevelArr:(NSArray *)userLevelArr {
    _userLevelArr = userLevelArr;
    [self creatMyteamHeadViews:userLevelArr];
}

- (void)headBtnClick:(UIButton *)btn {
    if (btn.tag != self.selectBtn.tag) {
        [btn setTitleColor:KHEXRGB(0xFFFFFF) forState:UIControlStateNormal];
        [btn setBackgroundColor:KHEXRGB(0xF37065)];
        
        [self.selectBtn setTitleColor:KHEXRGB(0xF37065) forState:UIControlStateNormal];
        XSViewBorderRadius(self.selectBtn, 15, 2, KHEXRGB(0xF37065));
        [self.selectBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(btn.tag - 1000, nil, nil);
        }
        
        self.selectBtn = btn;
    }
}

@end
