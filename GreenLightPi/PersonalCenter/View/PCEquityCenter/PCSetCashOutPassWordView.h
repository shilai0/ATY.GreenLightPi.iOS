//
//  PCSetCashOutPassWordView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/12.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    passWordTypeSet,//设置提现密码 ,
    passWordTypeInput,//输入提现密码 ,
} PassWordViewType;

@interface PCSetCashOutPassWordView : BaseView
/// 当前输入的内容
@property (nonatomic, copy) NSString *code;
@property (nonatomic, strong) UITextField *textField;

- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@property (nonatomic, strong) NSMutableArray<UILabel *> *labels;
@property (nonatomic, assign) BOOL isSure;
@property (nonatomic, copy) void(^inputFinishBlock)(NSString *code,BOOL isSure);
@property (nonatomic, assign) PassWordViewType passWordType;
@end

NS_ASSUME_NONNULL_END
