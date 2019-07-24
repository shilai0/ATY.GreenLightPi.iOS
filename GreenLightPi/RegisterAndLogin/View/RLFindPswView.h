//
//  RLFindPswView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/26.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseView.h"

@class RLSingleTextView;
@interface RLFindPswView : BaseView
@property(strong,nonatomic)RLSingleTextView *telephoneTextfield;
@property(strong,nonatomic)RLSingleTextView *pswTextfield;
@property(strong,nonatomic)RLSingleTextView *codeTextfield;
@end

