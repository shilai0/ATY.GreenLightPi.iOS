//
//  MyTeamModel.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/10.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 NickName (string, optional): 用户昵称 ,
 ImagePath (string, optional): 用户头像 ,
 CreateTime (string, optional): 用户创建时间 ,
 Count (integer, optional): 直属下级人数
 **/

NS_ASSUME_NONNULL_BEGIN

@interface MyTeamModel : NSObject
@property (nonatomic, copy) NSString *NickName;
@property (nonatomic, copy) NSString *ImagePath;
@property (nonatomic, copy) NSString *CreateTime;
@property (nonatomic, assign) NSInteger Count;
@end

NS_ASSUME_NONNULL_END
