//
//  HMGameLibraryViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/4/1.
//  Copyright © 2019年 aiteyou. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    moreGame,
    gameLibrary,
} GameType;


@class HomeModel;
@interface HMGameLibraryViewController : BaseViewController
@property (nonatomic, strong) HomeModel *homeModel;
@property (nonatomic, assign) GameType gametype;
@end

NS_ASSUME_NONNULL_END
