//
//  FCManuscriptView.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/5/8.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "FCManuscriptView.h"

@interface FCManuscriptView()
@property (nonatomic, strong) UIButton *returnBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, strong) UIWebView *manuscriptWebView;
@end

@implementation FCManuscriptView

- (instancetype)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.backgroundColor = KHEXRGB(0xFFFFFF);
        [self addSubview:self.returnBtn];
        [self addSubview:self.shareBtn];
        [self addSubview:self.manuscriptWebView];
        
        [self.returnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@16);
            make.top.equalTo(@28);
            make.width.height.equalTo(@28);
        }];
        
        [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@28);
            make.right.equalTo(@(-16));
            make.width.height.equalTo(@28);
        }];
        
        [self.manuscriptWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(@64);
        }];
        
        
        @weakify(self);
        [[self.returnBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.atyClickActionBlock) {
                self.atyClickActionBlock(0, nil, nil);
            }
        }];
        
        [[self.shareBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            if (self.atyClickActionBlock) {
                self.atyClickActionBlock(1, nil, nil);
            }
        }];
        
    }
    return self;
}

- (void)setUrlStr:(NSString *)urlStr {
    _urlStr = urlStr;
    [self.manuscriptWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlStr]]];
}

- (UIButton *)returnBtn {
    if (!_returnBtn) {
        _returnBtn = [[UIButton alloc] init];
        [_returnBtn setImage:[UIImage imageNamed:@"return"] forState:UIControlStateNormal];
    }
    return _returnBtn;
}

- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        [_shareBtn setImage:[UIImage imageNamed:@"fc_audioShare"] forState:UIControlStateNormal];
    }
    return _shareBtn;
}

- (UIWebView *)manuscriptWebView {
    if (!_manuscriptWebView) {
        _manuscriptWebView = [[UIWebView alloc] init];
    }
    return _manuscriptWebView;
}


@end
