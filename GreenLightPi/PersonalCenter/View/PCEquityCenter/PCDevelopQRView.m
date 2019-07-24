//
//  PCDevelopQRView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/13.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "PCDevelopQRView.h"
#import "UIImageView+WebCache.h"

@interface PCDevelopQRView()
@property (nonatomic, strong) UIImageView *QRImageView;
@end

@implementation PCDevelopQRView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.5];
        [self creatDevelopQRViews];
    }
    return self;
}

- (void)creatDevelopQRViews {
    [self addSubview:self.QRImageView];
    
    [self.QRImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.height.equalTo(@(KSCREEN_WIDTH*0.8));
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [self addGestureRecognizer:tap];
}

- (void)setCodeStr:(NSString *)codeStr {
    _codeStr = codeStr;
    [self.QRImageView sd_setImageWithURL:[NSURL URLWithString:_codeStr]];
}

- (void)tap {
    if (self.atyClickActionBlock) {
        self.atyClickActionBlock(0, nil, nil);
    }
}

- (UIImageView *)QRImageView {
    if (!_QRImageView) {
        _QRImageView = [[UIImageView alloc] init];
    }
    return _QRImageView;
}

@end
