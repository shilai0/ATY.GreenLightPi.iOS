//
//  VTAnimationManager.m
//  VTPictureBook
//
//  Created by wantong_clover on 2019/1/12.
//

#import "VTAnimationManager.h"


static VTAnimationManager *_instance = nil;
@interface VTAnimationManager ()<NSCopying,NSMutableCopying>

@end


@implementation VTAnimationManager

+(instancetype)sharedManager{
    if (_instance == nil) {
        _instance = [[self alloc] init];
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone{
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone{
    return _instance;
}

-(void)changeAnimation:(int)index andType:(int)type{
    if(_mIndex != index){
        if(_mType != type){
            _mType =type;
//            UnitySendMessage("Canvas", "ChangeFace",[[NSString stringWithFormat:@"%d",type] cStringUsingEncoding:NSUTF8StringEncoding]);
        }
//         UnitySendMessage("Canvas", "ChangeFace",[[NSString stringWithFormat:@"%d",index] cStringUsingEncoding:NSUTF8StringEncoding]);
           _mIndex = index;
    }
    
}

@end
