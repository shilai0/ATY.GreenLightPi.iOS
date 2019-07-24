//
//  HMSelectFamilyViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/3/29.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PushFamilyType) {
    PushFamilyTypeDefault, //
    PushFamilyTypeMyFamily  //
};
@interface HMSelectFamilyViewController : BaseViewController
@property (nonatomic, assign) PushFamilyType pushFamilyType;
@property (nonatomic, copy) void(^addBabyBlock)(void);
@end

NS_ASSUME_NONNULL_END
