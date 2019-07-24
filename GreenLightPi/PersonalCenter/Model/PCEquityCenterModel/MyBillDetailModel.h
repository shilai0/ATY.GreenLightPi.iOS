//
//  MyBillDetailModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/18.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 ImagePath (string, optional): 账单类型图标地址 ,
 DateTime (string, optional): 账单时间 ,
 Money (string, optional): 账单金额 ,
 Title (string, optional): 账单标题 ,
 Remark (string, optional): 账单备注--提现申请状态
 **/

NS_ASSUME_NONNULL_BEGIN

@interface MyBillDetailModel : NSObject
@property (nonatomic, copy) NSString *ImagePath;
@property (nonatomic, copy) NSString *DateTime;
@property (nonatomic, copy) NSString *Money;
@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSString *Remark;
@end

NS_ASSUME_NONNULL_END
