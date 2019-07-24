//
//  RLLoginView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/30.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseView.h"

@class RLSingleTextView;
@interface RLLoginView : BaseView
@property (nonatomic, strong) RLSingleTextView *telephoneTextfield;//输入手机号码
@property (nonatomic, strong) RLSingleTextView *codeTextfield;//验证码登录
@property (nonatomic, strong) RLSingleTextView *psdTextfield;//密码登录
@end
