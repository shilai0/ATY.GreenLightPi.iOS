//
//  HMBabyInfoViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/1.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, BabyInfoType) {
    BabyInfoTypeDefault, //宝宝列表进来
    BabyInfoTypeAdd,  //我的宝宝 添加宝宝进来
    BabyInfoTypeSelectAdd,//选择家庭组（没有家庭组的情况下，点击添加宝宝）
    BabyInfoTypeMyFamilyAdd//我的家庭组（没有家庭组的情况下，点击添加宝宝）
};
@class BabyModel;
@interface HMBabyInfoViewController : BaseViewController
@property (nonatomic, assign) BabyInfoType babyInfoType;
@property (nonatomic, strong) BabyModel *babyModel;
@property (nonatomic, copy) void(^saveBlock)(void);
@end

NS_ASSUME_NONNULL_END
