//
//  UIButton+EnlargeHitArea.h
//  VTPictureBook
//
//  Created by 隔壁老王 on 2019/5/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (EnlargeHitArea)
@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;
@end

NS_ASSUME_NONNULL_END
