//
//  BaseRequest.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseRequest : NSObject

/**
 GET数据请求方法二次封装
 
 @param requestURL 数据请求地址
 @param params 请求参数(没有就传nil)
 @param successBlock 请求返回数据(如果返回为nil, 则请求失败)
 */
+ (void)GETRequestDataWithReuestURL:(NSString *)requestURL params:(NSMutableDictionary *)params success:(void(^)(NSDictionary *resultDic))successBlock;

/**
 POST数据请求方法二次封装
 
 @param requestURL 数据请求地址
 @param params 请求参数(没有就传nil)
 @param successBlock 请求返回数据(如果返回为nil, 则请求失败)
 */
+ (void)POSTRequestDataWithReuestURL:(NSString *)requestURL params:(NSMutableDictionary *)params success:(void(^)(NSDictionary *resultDic))successBlock;

/**
 上传图片
 
 @param url 请求地址
 @param params 请求参数
 @param imageArr 上传的图片
 @param successBlock 请求返回数据
 */
+ (void)UploadWithURL:(NSString *)url params:(NSDictionary *)params imageArr:(NSArray *)imageArr success:(void(^)(NSDictionary *resultDic))successBlock;

/**
 下载文件
 
 @param url 文件地址
 @param successBlock 请求返回数据
 */
+(void)DownLoadDataWithUrl:(NSString *)url Withsuccess:(void(^)(NSDictionary *resultDic))successBlock;

@end
