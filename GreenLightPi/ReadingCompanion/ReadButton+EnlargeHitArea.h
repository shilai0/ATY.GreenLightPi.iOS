//
//  ReadButton+EnlargeHitArea.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/8/9.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "ReadButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReadButton (EnlargeHitArea)
@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;
@end

NS_ASSUME_NONNULL_END
