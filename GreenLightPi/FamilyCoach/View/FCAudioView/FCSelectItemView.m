//
//  FCSelectItemView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/29.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "FCSelectItemView.h"
#import "FCAudioDetailListView.h"
#import "FcCoursesModel.h"
#import "FCSelectItemHeadView.h"

@interface FCSelectItemView ()
@property (nonatomic, strong) FCAudioDetailListView *listView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) FCSelectItemHeadView *headView;
@end

@implementation FCSelectItemView

- (FCSelectItemHeadView *)headView {
    if (!_headView) {
        _headView = [[FCSelectItemHeadView alloc] initWithFrame:CGRectMake(0, 0, KSCREEN_WIDTH, 49)];
    }
    return _headView;
}

- (FCAudioDetailListView *)listView {
    if (!_listView) {
        _listView = [[FCAudioDetailListView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _listView.tableHeaderView = self.headView;
    }
    return _listView;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [UIButton new];
        [_cancelBtn setImage:[UIImage imageNamed:@"icon_revocation1"] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:KHEXRGB(0x999999) forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancelBtn setBackgroundColor:KHEXRGB(0xF7F7F7)];
    }
    return _cancelBtn;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        [self fc_creatViews];
    }
    return self;
}

- (void)fc_creatViews {
    [self addSubview:self.listView];
    [self addSubview:self.cancelBtn];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(@(-KBottomSafeHeight));
        make.height.equalTo(@49);
    }];
    
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.cancelBtn.mas_top);
        make.height.equalTo(@(KSCREENH_HEIGHT/2));
    }];
    
    @weakify(self);
    [[self.cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(0, @"cancel", nil);
        }
    }];
    
    self.listView.pushBlock = ^(NSMutableArray *dataArr, NSIndexPath *indexPath) {
        @strongify(self);
        if (self.atyClickActionBlock) {
            self.atyClickActionBlock(indexPath.row, nil, nil);
        }
    };
}

-(void)setModel:(FcCoursesModel *)model {
    _model = model;
    self.headView.workCount = _model.consumptionDetails.count;
    self.listView.dataArr = [model.consumptionDetails mutableCopy];
    [self.listView reloadData];
}

@end
