//
//  PCAboutAtyHeadView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/3.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "PCAboutAtyHeadView.h"

@interface PCAboutAtyHeadView ()
@property (nonatomic, strong) UIImageView *logImageView;
@property (nonatomic, strong) UILabel *versionLabel;
@end

@implementation PCAboutAtyHeadView

- (UIImageView *)logImageView {
    if (!_logImageView) {
        _logImageView = [UIImageView new];
        _logImageView.image = [UIImage imageNamed:@"fs_shareBind"];
        XSViewBorderRadius(_logImageView, 6, 0, KHEXRGB(0xFFFFFF));
    }
    return _logImageView;
}

- (UILabel *)versionLabel {
    if (!_versionLabel) {
        _versionLabel = [UILabel new];
        NSDictionary *inforDic = [[NSBundle mainBundle] infoDictionary];
        NSString *currentVersion = [inforDic objectForKey:@"CFBundleShortVersionString"];
        _versionLabel.text = [NSString stringWithFormat:@"V%@",currentVersion];
        _versionLabel.textColor = KHEXRGB(0x999999);
        _versionLabel.font = FONT(12);
        _versionLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        [self pc_creatSubViews];
    }
    return self;
}

- (void)pc_creatSubViews {
    [self addSubview:self.logImageView];
    [self addSubview:self.versionLabel];
    
    [self.logImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(@44);
        make.width.height.equalTo(@77);
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.logImageView.mas_bottom).offset(21);
        make.height.equalTo(@10);
        make.width.equalTo(@50);
    }];
}

@end
