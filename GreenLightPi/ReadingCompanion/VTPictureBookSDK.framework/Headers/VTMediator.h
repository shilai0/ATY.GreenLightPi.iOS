//
//  VTMediator.h
//  VTPictureBook
//
//  Created by 隔壁老王 on 2019/3/27.
//

#import <Foundation/Foundation.h>



@interface VTMediator : NSObject
@property (nonatomic, strong) NSString *huibenUrl;
+(instancetype)sharedInstance;
//远程调用入口
-(id)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;
//本地调用入口
-(id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;
-(void)releaseCachedTargetWithTargetName:(NSString *)targetName;

@end


