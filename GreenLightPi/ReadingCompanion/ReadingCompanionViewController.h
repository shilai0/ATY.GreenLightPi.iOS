//
//  ReadingCompanionViewController.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2019/7/3.
//  Copyright © 2019 aiteyou. All rights reserved.
//

#import "BaseViewController.h"


@protocol PlayBookAudioDelegate <NSObject>

-(void)playCurrentBook;

@end

@class VTSDKBookDataModel;
typedef NS_ENUM(NSInteger,VTPreviewState){
    VTPreviewStateNoBook = 1,
    VTPreviewStateReadStart,
    VTPreviewStateDownloadStart,
    VTPreviewStateReadEnd,
    VTPreviewStateDownloadEnd
};

NS_ASSUME_NONNULL_BEGIN

@interface ReadingCompanionViewController : BaseViewController
@property (nonatomic, assign) VTPreviewState state;
@property (nonatomic, strong) UIView *cameraView;
@property (nonatomic, weak) id<PlayBookAudioDelegate> delegate;

-(void) updateSubview:(VTSDKBookDataModel *)model;
-(void) updateProgress:(CGFloat) progress;
@end

NS_ASSUME_NONNULL_END
