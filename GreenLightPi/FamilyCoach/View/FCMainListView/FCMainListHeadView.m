//
//  FCMainListHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/16.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCMainListHeadView.h"
#import "SDCycleScrollView.h"
#import "UIButton+Common.h"

/**
 *  pageControl的默认间距
 */
static NSInteger const kDefaultSpacing = 6;

/**
 *  pageControl的默认大小
 */
static CGSize const kDefaultDotSize = {8, 2};

@interface FCMainListHeadView ()<SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *bannerView;
@property (nonatomic, strong) UIButton *lastBtn;
@property (nonatomic, strong) NSArray *originalArr;
@end

@implementation FCMainListHeadView

- (SDCycleScrollView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[SDCycleScrollView alloc] init];
        self.backgroundColor = [UIColor whiteColor];
        XSViewBorderRadius(_bannerView, 4, 0, KHEXRGB(0x333333));
    }
    return _bannerView;
}

-(instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self fc_creatHeadViews];
    }
    return self;
}

- (void)fc_creatHeadViews {
    self.bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.bannerView.titlesGroup = nil;
    self.bannerView.autoScrollTimeInterval = 3.0;
    self.bannerView.currentPageDotColor = KHEXRGB(0x11D7A6); // 自定义分页控件小圆标颜色
    self.bannerView.showPageControl = NO;
    self.bannerView.delegate = self;
//    self.bannerView.localizationImageNamesGroup = [NSArray arrayWithObjects:[UIImage imageNamed:@"sample_1"],[UIImage imageNamed:@"sample_2"],[UIImage imageNamed:@"sample_3"],[UIImage imageNamed:@"sample_4"], nil];
    [self addSubview:self.bannerView];
    
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(self);
        make.height.equalTo(@(136*KHEIGHTSCALE));
    }];
}

- (void)setBannerArr:(NSArray *)bannerArr {
    _bannerArr = bannerArr;
    [self creatCustomCPageControl:bannerArr];
    self.bannerView.imageURLStringsGroup = _bannerArr;
}

- (void)creatCustomCPageControl:(NSArray *)pageCount {
    CGFloat leftSpacing = (KSCREEN_WIDTH - kDefaultDotSize.width*pageCount.count - kDefaultSpacing*(pageCount.count - 1))/2;
    
    for (int i = 0; i < self.originalArr.count; i ++) {
        UIButton *originalBtn = (UIButton *)[self viewWithTag:100 + i];
        [originalBtn removeFromSuperview];
    }
    
    for (int i = 0; i < pageCount.count; i ++) {
        UIButton *pageBtn = [[UIButton alloc] initWithFrame:CGRectMake(leftSpacing + i*kDefaultDotSize.width + (i - 1)*kDefaultSpacing, 136*KHEIGHTSCALE - 20, kDefaultDotSize.width, kDefaultDotSize.height)];
        pageBtn.tag = 100 + i;
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

@end
