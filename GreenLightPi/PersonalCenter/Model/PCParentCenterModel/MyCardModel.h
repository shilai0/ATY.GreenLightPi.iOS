//
//  MyCardModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/11.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 BankId (integer, optional): 银行卡Id ,
 ImagePath (string, optional): 银行卡图标 ,
 BankName (string, optional): 银行卡名称 ,
 CardTypeName (string, optional): 银行卡类型 ,
 CardNumber (string, optional): 银行卡号
 BankTrueName (string, optional): 银行卡持有者名字 ,
 **/

NS_ASSUME_NONNULL_BEGIN

@interface MyCardModel : NSObject
@property (nonatomic, assign) NSInteger BankId;
@property (nonatomic, copy) NSString *ImagePath;
@property (nonatomic, copy) NSString *BankName;
@property (nonatomic, copy) NSString *CardTypeName;
@property (nonatomic, copy) NSString *CardNumber;
@property (nonatomic, assign) BOOL isSelect;
@property (nonatomic, copy) NSString *BankTrueName;
@end

NS_ASSUME_NONNULL_END
