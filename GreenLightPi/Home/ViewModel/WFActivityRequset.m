//
//  WFActivityRequset.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/7/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "WFActivityRequset.h"
#import "BaseNavigationViewController.h"
#import "FCEvaluateViewController.h"
#import "UIView+Controller.h"

@implementation WFActivityRequset

- (void)backClick {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.fuctionBlock) {
            self.fuctionBlock(@"back");
        }
    });
}

- (void)shareClick {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.fuctionBlock) {
            self.fuctionBlock(@"share");
        }
    });
}

- (void)writeComment {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.fuctionBlock) {
            self.fuctionBlock(@"writeComment");
        }
    });
}

- (void)submitClick {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.fuctionBlock) {
            self.fuctionBlock(@"submit");
        }
    });
}

- (void)userPic:(NSInteger)userId Click:(NSString *)userType {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.getUserBlock) {
            self.getUserBlock(userId, userType);
        }
    });
}

- (void)helpPayClick {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.fuctionBlock) {
            self.fuctionBlock(@"helpPayClick");
        }
    });
}

- (void)previewAppointment {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.fuctionBlock) {
            self.fuctionBlock(@"previewAppointment");
        }
    });
}

- (void)addRecordClick:(NSInteger)currentbabyId {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.addRecorBlock) {
            self.addRecorBlock(currentbabyId);
        }
    });
}

- (void)get:(NSInteger)params1 IsCollect:(NSInteger)params2 {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.getIsCollectBlock) {
            self.getIsCollectBlock(params1, params2);
        }
    });
}

- (void)errorAlertFn:(NSString *)errorMessage {
    if (self.errorAlertFnBlock) {
        self.errorAlertFnBlock(errorMessage);
    }
}

- (void)isFocusAction {
    if (self.fuctionBlock) {
        self.fuctionBlock(@"isFocusAction");
    }
}

@end
