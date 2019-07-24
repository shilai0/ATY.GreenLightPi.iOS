//
//  HMFamilyDetailFooterView.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/10.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HMFamilyDetailFooterView : UICollectionReusableView
@property (nonatomic, strong) UIButton *otherBtn;
@property (nonatomic, copy) void(^invitationBlock)(NSInteger index);
@end

NS_ASSUME_NONNULL_END
