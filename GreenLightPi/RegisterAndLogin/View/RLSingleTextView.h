//
//  RLSingleTextView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/22.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface RLSingleTextView : BaseView
/** 输入框 */
@property(strong,nonatomic)UITextField *contentTextfield;

/** 获取验证码 */
@property (nonatomic, strong) UIButton *getCodebtn;

/** 是否显示leftMode */
@property (nonatomic, assign) BOOL isShowLeft;

@end

NS_ASSUME_NONNULL_END
