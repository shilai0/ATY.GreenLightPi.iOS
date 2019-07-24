//
//  BaseFormView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseDetailFormModel;

@interface BaseFormView : UIView

@property (nonatomic, strong) UITextField *textField;   // 输入框

@property (nonatomic, assign) BOOL isEdit;            // 是否可以编辑（默认可以编辑）
@property (nonatomic, assign) BOOL isShowAddImg;      // 是否显示左侧 + 图片（默认不显示）
@property (nonatomic, assign) BOOL isShowArrow;       // 是否显示右侧箭头（默认不显示，显示只展示，不显示可输入）
@property (nonatomic, assign) BOOL isEmpty;           // 是否可以为空（默认可为空，可以在提交前进行判断处理，此项可不管）
@property (nonatomic, assign) BOOL isNeed;            // 是否是必填项（默认不是）
@property (nonatomic, copy) NSString *title;          // 标题
@property (nonatomic, copy) NSString *text;           // 内容
@property (nonatomic, assign) NSInteger textColor;    // 文字颜色
@property (nonatomic, copy) NSString *placeholder;    // 占位文字
@property (nonatomic, strong) NSNumber *keyBordType;  // 键盘类型 0 默认键盘 1 数字键盘 2 身份证 3 数字加小数点
@property (nonatomic, assign) NSInteger textAlignment;// 输入项显示位置 0：居左  1：居右 不设居右

@property (nonatomic, copy) void(^didTextBlock)(NSString *text);

@end
