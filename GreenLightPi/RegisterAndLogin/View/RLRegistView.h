//
//  RLRegistView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseView.h"

@class RLSingleTextView;
@interface RLRegistView : BaseView
@property(strong,nonatomic)RLSingleTextView *codeTextfield;
@property(strong,nonatomic)RLSingleTextView *telephoneTextfield;
@property(strong,nonatomic)RLSingleTextView *pswTextfield;
@end
