//
//  HMMainViewParentingCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/20.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMMainViewParentingCell.h"
#import "HMMainViewPatentingSubView.h"

@interface HMMainViewParentingCell()
@property (nonatomic, strong) UIView *shadowView;
@property (nonatomic, strong) UIView *backView;
@end

@implementation HMMainViewParentingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatHMMainViewParentingCellSubViews];
    }
    return self;
}

- (void)creatHMMainViewParentingCellSubViews {
    [self.contentView addSubview:self.shadowView];
    [self.shadowView addSubview:self.backView];
    
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(@16);
        make.bottom.equalTo(@(-16));
        make.height.equalTo(@208);
    }];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shadowView);
    }];
}

- (void)setParentingArr:(NSArray *)parentingArr {
    _parentingArr = parentingArr;
    for (int i = 0; i < _parentingArr.count; i ++) {
        HMMainViewPatentingSubView *parentingView = [[HMMainViewPatentingSubView alloc] initWithFrame:CGRectMake(0, 16*(i + 1) + 48*i, KSCREEN_WIDTH, 48)];
        parentingView.homeModel = _parentingArr[i];
        @weakify(self);
        parentingView.atyClickActionBlock = ^(NSInteger index, NSString *content1, NSString *content2) {
            @strongify(self);
            if (self.singleBlock) {
                self.singleBlock(i);
            }
        };
        [self.backView addSubview:parentingView];
    }
}

#pragma mark -- 懒加载
- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.layer.masksToBounds = NO;
        _shadowView.layer.shadowRadius = 8;
        _shadowView.layer.shadowOpacity = 1;
        _shadowView.layer.shadowOffset = CGSizeZero;
        _shadowView.layer.shadowColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(3,3);
    }
    return _shadowView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = KHEXRGB(0xFFFFFF);
        XSViewBorderRadius(_backView, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _backView;
}


@end
