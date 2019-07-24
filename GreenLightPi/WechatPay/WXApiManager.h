//
//  WXApiManager.h
//  SDKSample
//
//  Created by Jeason on 16/07/2015.
//
//

#import <Foundation/Foundation.h>
#import "WXApi.h"

@protocol WXApiManagerDelegate <NSObject>

@optional


@end

@class FcCoursesModel,StoreCardApiModel;
@interface WXApiManager : NSObject<WXApiDelegate>

@property (nonatomic, assign) id<WXApiManagerDelegate> delegate;
@property (nonatomic, strong) FcCoursesModel *model;
//@property (nonatomic, strong) StoreCardApiModel *cardModel;
+ (instancetype)sharedManager;

@end
