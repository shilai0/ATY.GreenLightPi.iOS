//
//  BaseFormModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/4.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^addBlock)(NSMutableDictionary *parmas,BOOL isEmprty);

@class BaseDetailFormModel;
@interface BaseFormModel : NSObject

// plist转模型
+ (NSMutableArray *)xs_getDataWithPlist:(NSString *)plist;
// 数据转模型
+ (NSMutableArray *)xs_getdataWithArr:(NSArray *)arr;
// 模型转数据
+ (NSArray *)xs_getDicWithModelArr:(NSArray *)dataArr;
/** 获取底层模型 */
+ (BaseDetailFormModel *)xs_getModelWithArr:(NSArray <BaseFormModel *>*)dataArr fromIndexPath:(NSIndexPath *)path;
+ (BOOL)setDataWithArr:(NSArray *)dataArr filtrationArr:(NSArray *)arr block:(addBlock) addBlock;

@property (nonatomic, strong) NSNumber *section;    // 第几组
@property (nonatomic, copy) NSString *headerTitle;  // 头视图标题
@property (nonatomic, copy) NSString *footerTitle;  // 尾视图标题
@property (nonatomic, assign) BOOL isShowFooter;    // 是否显示尾视图
@property (nonatomic, assign) BOOL isDelete;        // 是否可以删除
@property (nonatomic, strong) NSMutableArray *itemsArr;

@end

@interface BaseDetailFormModel : NSObject

@property (nonatomic, assign) BOOL isEdit;            // 是否可以编辑
@property (nonatomic, assign) BOOL isShowAddImg;      // 是否显示左侧 + 图片
@property (nonatomic, assign) BOOL isShowArrow;       // 是否显示右侧箭头
@property (nonatomic, assign) BOOL isEmpty;           // 是否可以为空
@property (nonatomic, assign) BOOL isNeed;            // 是否是必填项
@property (nonatomic, copy) NSString *title;          // 标题
@property (nonatomic, copy) NSString *text;           // 内容
@property (nonatomic, copy) NSString *textColor;      // 文字颜色
@property (nonatomic, copy) NSString *placeholder;    // 占位文字
@property (nonatomic, strong) NSNumber *keyBordType;  // 键盘类型 1 数字键盘 2 身份证 3

/** dataArr 用来存储model 数据类型 */
@property(strong,nonatomic)NSArray *dataArr;
/** parmas 用来存储对应数据的键值对 */
@property(strong,nonatomic)NSDictionary *parmas;

@end
