//
//  VTGlobalObject.h
//  clover
//
//  Created by clover on 15/9/20.
//  Copyright © 2015年 clover. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface VTGlobalObject : NSObject


/**
 *  @author clover, 15-09-20 15:09:12
 *
 *  @brief  判断对象是否为非空
 *
 *  @param obj 对象
 *
 *  @return 非空返回YES，空返回NO
 */
+(BOOL)isnotNull:(id)obj;

/**
 *  @author clover, 15-09-20 15:09:29
 *
 *  @brief  判断对象是否空值
 *
 *  @param obj 对象
 *
 *  @return 非空返回YES，空返回NO
 */
+(BOOL)isnotNullVal:(id)obj;


/**
 *  @author clover, 16-03-11 11:03:11
 *
 *  @brief 计算UILabel的尺寸
 *
 *  @param content UILabel将展示的文字
 *  @param myFont  UILabel的字体
 *  @param maxSize 最大的尺寸
 *
 *  @return 合适的尺寸
 */
+ (CGSize)countLabelSizeWithContent:(NSString *)content
                            andFont:(UIFont *)myFont
                         andMaxSize:(CGSize)maxSize;


/**
 *  @author clover, 16-03-11 11:03:55
 *
 *  @brief 获取横屏转换率
 *
 *  @return 相对于iphone 6的横转换率
 */
+(float )getLanScreenRat;


+(float)get1080Rat;



//获取设备标识码
+(NSString *) uniqueDeviceIdentifier;

//获取设备型号
+ (NSString*)deviceVersion;

+(NSString *)iphoneInfo;

//MD5加密
+ (NSString *)MD5Secret:(NSString *)inPutText;

//十六进制颜色转UIColor
+ (UIColor *)colorWithHexString: (NSString *)stringToConvert;

+(UIImage *)loadImageWithName:(NSString *)imageName;

+(UIImage *)loadImageWithName:(NSString *)imageName andfolderName:(NSString *)folderName;

/**
 *  @author clover, 16-03-14 18:03:03
 *
 *  @brief 从一个URL中解析出参数
 *
 *  @param query    请求的URL参数
 *  @param encoding 编码方式
 *
 *  @return 参数字典
 */
+ (NSDictionary*)dictionaryFromQuery:(NSString*)query
                       usingEncoding:(NSStringEncoding)encoding;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
+(NSString *)getSoundPath:(NSString *)soundName;

+(NSString*)DataTOjsonString:(id)object;


+ (double)getCurrentTimestamp;
+ (NSString *)timestampChangesStandarTime:(NSString *)timestamp;
+ (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size;

+(BOOL)hasNewAppVersion:(NSString *)appStoreID Version:(NSString *)appVer;

+(void)cancleTimerWithName:(NSString *)timerName;
+(void)scheduledDispatchTimerWithName:(NSString *)timernName
                                delay:(double)delay
                         timeInterval:(double)interval
                                queue:(dispatch_queue_t __nullable) queue
                         repeatCounts:(int)repeats
                               action:(dispatch_block_t)action;
+(void)cancleAllTimer;

@end
