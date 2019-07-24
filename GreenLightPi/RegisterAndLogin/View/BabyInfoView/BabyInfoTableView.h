//
//  BabyInfoTableView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/5.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseFormTableView.h"
@interface BabyInfoTableView : BaseFormTableView
@property (nonatomic, strong) UIImage *picImage;
@property (nonatomic, copy) void(^selectSexBlock)(NSInteger sexIndex);
@property (nonatomic, copy) void(^selectRelationBlock)(NSInteger relationIndex);
@property (nonatomic, copy) NSString *imagePathStr;
@property (nonatomic, copy) NSNumber *sex;
@property (nonatomic, copy) NSNumber *relation;
@end
