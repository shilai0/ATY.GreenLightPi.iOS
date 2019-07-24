//
//  VTAnimationManager.h
//  VTPictureBook
//
//  Created by wantong_clover on 2019/1/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VTAnimationManager : NSObject
@property (nonatomic, assign) int mIndex;
@property (nonatomic, assign) int mType;
+(instancetype)sharedManager;
-(void)changeAnimation:(int)index andType:(int)type;
@end

NS_ASSUME_NONNULL_END
