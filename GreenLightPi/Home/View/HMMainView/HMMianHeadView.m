//
//  HMMianHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/19.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMianHeadView.h"
#import "SDCycleScrollView.h"

/**
 *  pageControl的默认间距
 */
static NSInteger const kDefaultSpacing = 6;

/**
 *  pageControl的默认大小
 */
static CGSize const kDefaultDotSize = {8, 2};

@interface HMMianHeadView()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) UIButton *lastBtn;
@property (nonatomic, strong) UIView *shelterView;
@property (nonatomic, strong) NSArray *originalArr;
@end

@implementation HMMianHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self creatSubViews];
    }
    return self;
}

- (void)creatSubViews {
    self.bannerView.titlesGroup = nil;
    self.bannerView.autoScrollTimeInterval = 3.0;
    self.bannerView.showPageControl = NO;
    self.bannerView.delegate = self;
    [self addSubview:self.bannerView];
    [self.bannerView addSubview:self.shelterView];

    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    //绘制圆角 要设置的圆角 使用“|”来组合
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.shelterView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(12, 12)];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];

    //设置大小
    maskLayer.frame = self.shelterView.bounds;

    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    self.shelterView.layer.mask = maskLayer;
}

-(void)setBannerArr:(NSArray *)bannerArr {
    _bannerArr = bannerArr;
    self.bannerView.imageURLStringsGroup = _bannerArr;
    [self creatCustomCPageControl:bannerArr];
}

- (void)creatCustomCPageControl:(NSArray *)pageCount {
    CGFloat leftSpacing = (KSCREEN_WIDTH - kDefaultDotSize.width*pageCount.count - kDefaultSpacing*(pageCount.count - 1))/2;
    
    for (int i = 0; i < self.originalArr.count; i ++) {
        UIButton *originalBtn = (UIButton *)[self viewWithTag:100 + i];
        [originalBtn removeFromSuperview];
    }
    
    for (int i = 0; i < pageCount.count; i ++) {
        UIButton *pageBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftSpacing + i*kDefaultDotSize.width + (i - 1)*kDefaultSpacing, 185*KHEIGHTSCALE - 24, kDefaultDotSize.width, kDefaultDotSize.height)];
        pageBtn.tag = 100 + i;
        XSViewBorderRadius(pageBtn, 1, 0, KHEXRGB(0xFFFFFF));
        [pageBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        if (i == 0) {
            [pageBtn setBackgroundColor:KHEXRGB(0xFFA430)];
            self.lastBtn = pageBtn;
        }
        [self.bannerView addSubview:pageBtn];
    }
    self.originalArr = pageCount;
}

#pragma mark -- SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index {
    UIButton *currentBtn = [self viewWithTag:100 + index];
    [self.lastBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
    [currentBtn setBackgroundColor:KHEXRGB(0xFFA430)];
    self.lastBtn = currentBtn;
}

#pragma mark -- 懒加载
- (SDCycleScrollView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[SDCycleScrollView alloc] init];
    }
    return _bannerView;
}

- (UIView *)shelterView {
    if (!_shelterView) {
        _shelterView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 17, KSCREEN_WIDTH, 17)];
        _shelterView.backgroundColor = KHEXRGB(0xFFFFFF);
    }
    return _shelterView;
}

@end
