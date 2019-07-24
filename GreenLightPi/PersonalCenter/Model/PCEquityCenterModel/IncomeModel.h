//
//  IncomeModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/9.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 NickName (string, optional): 用户昵称 ,
 ImagePath (string, optional): 用户头像 ,
 CreateTime (string, optional): 用户创建时间 ,
 Remark (string, optional): 备注信息 ,
 Money (string, optional): 收益金额
 **/

@interface IncomeModel : NSObject
@property (nonatomic, copy) NSString *NickName;
@property (nonatomic, copy) NSString *ImagePath;
@property (nonatomic, copy) NSString *CreateTime;
@property (nonatomic, copy) NSString *Remark;
@property (nonatomic, copy) NSString *Money;
@end

NS_ASSUME_NONNULL_END
