//
//  HMParkUseRankCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/3.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMParkUseRankCell.h"
#import "HMParkUseRankListView.h"
#import "UserUseLogModel.h"

@interface HMParkUseRankCell()
@property (nonatomic, strong) UIView *footerBackView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *openOrCloseBtn;
@property (nonatomic, strong) UIView *shadowView;
@end

@implementation HMParkUseRankCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = KHEXRGB(0xF7F7F7);
        [self creatHMParkUseRankCellVies];
    }
    return self;
}

- (void)creatHMParkUseRankCellVies {
    [self.contentView addSubview:self.shadowView];
    [self.shadowView addSubview:self.parkUseRankListView];
    [self.footerBackView addSubview:self.lineView];
    [self.footerBackView addSubview:self.openOrCloseBtn];

    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(@3);
        make.bottom.equalTo(@(-3));
    }];
    
    [self.parkUseRankListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.shadowView);
    }];
    
    @weakify(self);
    [[self.openOrCloseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.openOrCloseBlock) {
            self.openOrCloseBlock(!self.model.isOpen);
            self.model.isOpen = !self.model.isOpen;
            if (self.model.isOpen) {
                [self.openOrCloseBtn setTitle:@"收起" forState:UIControlStateNormal];
            } else {
                [self.openOrCloseBtn setTitle:@"展开" forState:UIControlStateNormal];
            }
        }
    }];
}

- (void)setModel:(UseLogModel *)model {
    _model = model;
    if (_model.useDetails.count > 3) {
        self.parkUseRankListView.tableFooterView = self.footerBackView;
        if (self.model.isOpen) {
            [self.openOrCloseBtn setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            [self.openOrCloseBtn setTitle:@"展开" forState:UIControlStateNormal];
        }
    }
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.layer.masksToBounds = NO;
        _shadowView.layer.shadowRadius = 8;
        _shadowView.layer.shadowOpacity = 1;
        _shadowView.layer.shadowColor = [UIColor colorWithRed:237/255.0 green:237/255.0 blue:237/255.0 alpha:1.0].CGColor;
        _shadowView.layer.shadowOffset = CGSizeMake(0,3);
    }
    return _shadowView;
}

- (HMParkUseRankListView *)parkUseRankListView {
    if (!_parkUseRankListView) {
        _parkUseRankListView = [[HMParkUseRankListView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        XSViewBorderRadius(_parkUseRankListView, 8, 0, KHEXRGB(0xFFFFFF));
    }
    return _parkUseRankListView;
}

- (UIView *)footerBackView {
    if (!_footerBackView) {
        _footerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH - 32, 65)];
        _footerBackView.backgroundColor = KHEXRGB(0xFFFFFF);
    }
    return _footerBackView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 19, KSCREEN_WIDTH - 32, 1)];
        _lineView.backgroundColor = KHEXRGB(0xE7E7E7);
    }
    return _lineView;
}

- (UIButton *)openOrCloseBtn {
    if (!_openOrCloseBtn) {
        _openOrCloseBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, KSCREEN_WIDTH - 32, 45)];
        [_openOrCloseBtn setBackgroundColor:KHEXRGB(0xFFFFFF)];
        [_openOrCloseBtn setTitleColor:KHEXRGB(0x00D399) forState:UIControlStateNormal];
        _openOrCloseBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _openOrCloseBtn;
}

@end
