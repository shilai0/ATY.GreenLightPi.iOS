//
//  WFActivityRequset.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSProtocol<JSExport>
- (void)backClick;
- (void)shareClick;
- (void)writeComment;
- (void)submitClick;
- (void)helpPayClick;
- (void)previewAppointment;
- (void)userPic:(NSInteger)userId Click:(NSString *)userType;
- (void)addRecordClick:(NSInteger)currentbabyId;
- (void)get:(NSInteger)params1 IsCollect:(NSInteger)params2;
- (void)errorAlertFn:(NSString *)errorMessage;
- (void)isFocusAction;
@end

@interface WFActivityRequset : NSObject<JSProtocol>
@property (nonatomic, copy) void(^fuctionBlock)(NSString *fuctionName);
@property (nonatomic, copy) void(^getIsCollectBlock)(NSInteger isCollect,NSInteger commentCount);
@property (nonatomic, copy) void(^getUserBlock)(NSInteger userId,NSString *userType);
@property (nonatomic, copy) void(^addRecorBlock)(NSInteger babyId);
@property (nonatomic, copy) void(^errorAlertFnBlock)(NSString *errorMessage);
@end
