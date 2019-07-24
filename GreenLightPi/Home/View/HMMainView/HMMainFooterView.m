//
//  HMMainFooterView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/5/8.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "HMMainFooterView.h"

@interface HMMainFooterView()
@property (nonatomic, strong) UIImageView *tipImageView;
@end

@implementation HMMainFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        
        [self addSubview:self.tipImageView];
        
        [self.tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.equalTo(@14);
            make.width.equalTo(@214);
        }];
        
    }
    return self;
}

- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [[UIImageView alloc] init];
        _tipImageView.image = [UIImage imageNamed:@"hm_bottom"];
    }
    return _tipImageView;
}

@end
