//
//  PCMyCountModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/28.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 order_id (integer, optional): 订单id ,
 title (string, optional): 课程表Id ,
 price (number, optional): 商品价格 ,
 ctime (string, optional): 创建时间 ,
 order_no (string, optional): 订单编号 ,
 integral (integer, optional): 积分 ,
 consumptionType (string, optional): 消费方式
 brandStoreName (string, optional): 店铺品牌名称
 */

@interface PCMyCountModel : NSObject
@property (nonatomic, copy) NSNumber *order_id;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSString *ctime;
@property (nonatomic, copy) NSString *order_no;
@property (nonatomic, copy) NSNumber *integral;
@property (nonatomic, copy) NSString *consumptionType;
@property (nonatomic, copy) NSString *brandStoreName;
@end
