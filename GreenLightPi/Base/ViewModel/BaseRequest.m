//
//  BaseRequest.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/6/2.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "BaseRequest.h"
#import "ATYDataService.h"
#import "BaseManager.h"

@implementation BaseRequest

// GET请求
+ (void)GETRequestDataWithReuestURL:(NSString *)requestURL params:(NSMutableDictionary *)params success:(void(^)(NSDictionary *resultDic))successBlock {
    
    NSMutableDictionary *requestParams;
    if (params == nil) {
        requestParams = [NSMutableDictionary dictionary];
    } else {
        requestParams = params;
    }
    
    [ATYDataService getWithUrl:requestURL params:params isReadCache:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        
        successBlock(responseObject);

        if ([responseObject[@"Success"] intValue] != Success && ![responseObject[@"Msg"][@"message"] isEqualToString:@""]) {
            [ATYToast aty_bottomMessageToast:responseObject[@"Msg"][@"message"]];
        }
        
    } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
        successBlock(nil);
        [ATYToast aty_bottomMessageToast:@"数据获取失败"];
//        NSLog(@"数据获取失败接口%@",requestURL);
//        NSLog(@"数据获取失败接口%@",error);
        NSLog(@"失败responseObject%@",responseObject);

    }];
}

// POST请求
+ (void)POSTRequestDataWithReuestURL:(NSString *)requestURL params:(NSMutableDictionary *)params success:(void(^)(NSDictionary *resultDic))successBlock {
    
    NSMutableDictionary *requestParams;
    if (params == nil) {
        requestParams = [NSMutableDictionary dictionary];
    } else {
        requestParams = params;
    }
    
    [ATYDataService postWithUrl:requestURL params:requestParams isReadCache:YES success:^(NSURLSessionDataTask *task, id responseObject) {
        
        successBlock(responseObject);
        if ([responseObject[@"Success"] intValue] != Success && ![responseObject[@"Msg"][@"message"] isEqualToString:@""]) {
            [ATYToast aty_bottomMessageToast:responseObject[@"Msg"][@"message"]];
        }
        
    } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
        successBlock(nil);
        [ATYToast aty_bottomMessageToast:@"数据获取失败"];
//        NSLog(@"数据获取失败接口%@",requestURL);
//        NSLog(@"数据获取失败接口%@",error);
        NSLog(@"失败responseObject%@",responseObject);

    }];
}

// 上传图片
+ (void)UploadWithURL:(NSString *)url params:(NSDictionary *)params imageArr:(NSArray *)imageArr success:(void(^)(NSDictionary *resultDic))successBlock {
    [MBProgressHUD showActivityMessageInWindow:@"处理中..."];
    [ATYDataService uploadWithUrl:url params:params fileData:imageArr progress:^(NSProgress *progress) {
        
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [MBProgressHUD hideHUD];
            successBlock(responseObject);
        if (![responseObject[@"Msg"][@"message"] isEqualToString:@""]) {
            [ATYToast aty_bottomMessageToast:responseObject[@"Msg"][@"message"]];
        }
    } failed:^(NSURLSessionDataTask *task, NSError *error, id responseObject) {
        [MBProgressHUD hideHUD];
        [ATYToast aty_bottomMessageToast:@"网络不稳定，上传失败"];
    }];
}

+(void)DownLoadDataWithUrl:(NSString *)url Withsuccess:(void(^)(NSDictionary *resultDic))successBlock {
    [MBProgressHUD showActivityMessageInWindow:@"下载中..."];
    [ATYDataService upDataFileWithUrl:url success:^(NSURLResponse *response, NSURL *filePath) {
        [MBProgressHUD hideHUD];
        [ATYToast aty_bottomMessageToast:@"下载完成"];
    } failed:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [ATYToast aty_bottomMessageToast:@"下载失败"];
    }];
}

@end
