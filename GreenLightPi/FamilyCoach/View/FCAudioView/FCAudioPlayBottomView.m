//
//  FCAudioPlayBottomView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/15.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCAudioPlayBottomView.h"
#import "UIButton+Common.h"
#import "FcCoursesModel.h"

@interface FCAudioPlayBottomView ()
@property (nonatomic, strong) UIButton *bottomBtn;
@end

@implementation FCAudioPlayBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xF7F7F7);
        [self fc_creatAudioPlayBottomViews];
    }
    return self;
}

- (void)fc_creatAudioPlayBottomViews {
    NSArray *titleArr = @[@"1/4",@"文稿",@"分享"];
    NSArray *imageArr = @[@"fc_list",@"manuscript",@"fc_share"];
    CGFloat btnWidth = KSCREEN_WIDTH / titleArr.count;
    for (int i = 0; i < titleArr.count; i ++) {
        self.bottomBtn = [[UIButton alloc] initWithFrame:CGRectMake(btnWidth * i, 0, btnWidth, 50)];
        self.bottomBtn.tag = 100 + i;
        [self.bottomBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [self.bottomBtn setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        [self.bottomBtn setImage:[UIImage imageNamed:imageArr[i]] forState:UIControlStateNormal];
        if (i == 1) {
            [self.bottomBtn setImage:[UIImage imageNamed:@"fc_alreadyStudy"] forState:UIControlStateSelected];
        }
        self.bottomBtn.titleLabel.font = [UIFont systemFontOfSize:9];
        [self.bottomBtn xs_layoutButtonWithButtonEdgeInsetsStyle:ButtonEdgeInsetsStyleTop WithImageAndTitleSpace:4];
        [self addSubview:self.bottomBtn];
    }
    
    for (int i = 0; i < titleArr.count; i ++) {
        UIButton *bottomBtn = [self viewWithTag:100 + i];
        if (i == 1 && [self.model.isPurchase integerValue] == 0) {
            bottomBtn.selected = !bottomBtn.selected;
        }
        @weakify(self);
        [[bottomBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.atyClickActionBlock) {
                self.atyClickActionBlock(i + 1, nil, nil);
            }
        }];
    }
}

- (void)setModel:(FcCoursesModel *)model {
    _model = model;
    UIButton *bottomBtn = [self viewWithTag:100];
    UIButton *bottomBtn1 = [self viewWithTag:101];
    [bottomBtn setTitle:[NSString stringWithFormat:@"1/%ld",self.model.consumptionDetails.count] forState:UIControlStateNormal];
//    if (![_model.consumptionType isEqualToString:@"free"]) {
//        [bottomBtn1 setTitle:@"想听" forState:UIControlStateNormal];
//    } else {
//        [bottomBtn1 setTitle:@"订阅" forState:UIControlStateNormal];
//    }
    
    if ([model.isPurchase integerValue] == 1) {
        bottomBtn1.selected = YES;
    } else {
        bottomBtn1.selected = NO;
    }
}

- (void)setIndex:(NSInteger)index {
    _index = index;
    UIButton *bottomBtn = [self viewWithTag:100];
    [bottomBtn setTitle:[NSString stringWithFormat:@"%ld/%ld",_index + 1,self.model.consumptionDetails.count] forState:UIControlStateNormal];
}

@end
