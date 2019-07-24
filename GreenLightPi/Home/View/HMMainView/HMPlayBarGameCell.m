//
//  HMPlayBarGameCell.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/30.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "HMPlayBarGameCell.h"

@interface HMPlayBarGameCell ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *picImageView;
@end

@implementation HMPlayBarGameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self creatPlayBarGameCellViews];
    }
    return self;
}

- (void)creatPlayBarGameCellViews {
    [self.contentView addSubview:self.backView];
    [self.backView addSubview:self.picImageView];
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@21);
        make.right.equalTo(@(-16));
        make.bottom.equalTo(@(-22));
        make.height.equalTo(@106);
    }];
    
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@12);
        make.right.bottom.equalTo(@(-12));
    }];
}

#pragma mark -- 懒加载
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        XSViewBorderRadius(_backView, 8, 1, KHEXRGB(0xDDDDDD));
    }
    return _backView;
}

- (UIImageView *)picImageView {
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc] init];
        _picImageView.image = [UIImage imageNamed:@"playBar_Game"];
    }
    return _picImageView;
}

@end
