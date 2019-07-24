//
//  PCChangePhoneNoViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/8/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

typedef NS_ENUM(NSInteger,ChangeType){
    ChangeTypeOld = 0, //旧手机号
    ChangeTypeNew,//新手机号码
};

@interface PCChangePhoneNoViewController : BaseViewController
@property(nonatomic, assign) ChangeType changeType;
@end
