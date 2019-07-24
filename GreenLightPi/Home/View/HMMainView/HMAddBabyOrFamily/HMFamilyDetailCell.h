//
//  HMFamilyDetailCell.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/10.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FamilyMemberApiModel;
@interface HMFamilyDetailCell : UICollectionViewCell
@property (nonatomic, strong) FamilyMemberApiModel *memberModel;
@end

NS_ASSUME_NONNULL_END
