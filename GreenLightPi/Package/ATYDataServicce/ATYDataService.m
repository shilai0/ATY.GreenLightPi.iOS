//
//  ATYDataService.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/29.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "ATYDataService.h"
#import <AFNetworking/AFNetworking.h>
#import "ATYCache.h"
#import <Photos/Photos.h>

#define defaultToken @"59CAA9017F3EFAB8"

@implementation ATYDataService

// HTTPS验证
+ (AFSecurityPolicy*)customSecurityPolicy {
    // /先导入证书
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:certificate ofType:@"cer"]; // 证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = NO;
    
    // validatesDomainName 是否需要验证域名，默认为YES；
    // 假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    // 置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    // 如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = YES;
    securityPolicy.pinnedCertificates = [NSSet setWithArray:@[certData]];
    
    return securityPolicy;
}

// 单例
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static ATYDataService *instance;
    dispatch_once(&onceToken, ^{
        NSURL *baseUrl = [NSURL URLWithString:BaseURL];
        instance = [[ATYDataService alloc] initWithBaseURL:baseUrl];
        // HTTPS ssl 验证。
        if(openHttpsSSL) {
            [self customSecurityPolicy];
        }
        instance.requestSerializer = [AFJSONRequestSerializer serializer];
        instance.responseSerializer = [AFJSONResponseSerializer serializer];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                                   @"text/html",
                                                                                   @"text/json",
                                                                                   @"text/plain",
                                                                                   @"text/javascript",
                                                                                   @"text/xml",
                                                                                   @"image/*"]];
        [instance.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    });
    return instance;
}

- (NSURLSession *)downloadSession {
    if (_downloadSession == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        // nil : nil的效果跟 [[NSOperationQueue alloc] init] 是一样的
        _downloadSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    }
    
    return _downloadSession;
}

// GET请求
+ (void)getWithUrl:(NSString *)url params:(NSDictionary *)params isReadCache:(BOOL)isReadCache success:(responseSuccess)success failed:(responseFailed)failed  {
    NSString *urlString = [BaseLink stringByAppendingString:url];
    if([url rangeOfString:@"https://api.weixin.qq.com"].location !=NSNotFound || [url rangeOfString:@"https://itunes.apple.com"].location !=NSNotFound) {
        urlString = url;
    }
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:PROJECT_TOKEN];
    if (!token) {
        token = defaultToken;
    }
    ATYDataService *dataService = [ATYDataService sharedManager];
    [dataService.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    
    NSDate *beginDate = [NSDate date];
    [dataService GET:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //请求成功的回调
        if (success) {
            success(task,responseObject);
        }
        CGFloat totalinterval = [[NSDate date] timeIntervalSinceDate:beginDate];
        NSLog(@"requestUrl:%@,totalTime:%f",urlString,totalinterval);
        //请求成功,保存数据
        [ATYCache saveDataCache:responseObject forKey:urlString];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败的回调
        id cacheData= nil;
        // 是否读取缓存
        if (isReadCache) {
            cacheData = [ATYCache readCache:urlString];
        } else {
            cacheData = nil;
        }
        
        if (failed) {
            failed(task,error,cacheData);
        }
    }];
    
}

// POST请求
+ (void)postWithUrl:(NSString *)url params:(NSDictionary *)params isReadCache:(BOOL)isReadCache success:(responseSuccess)success failed:(responseFailed)failed {
    NSDate *beginDate = [NSDate date];
    NSString *urlString = [BaseLink stringByAppendingString:url];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaults objectForKey:PROJECT_TOKEN];
    if (!token) {
        token = defaultToken;
    }
    ATYDataService *dataService = [ATYDataService sharedManager];
    [dataService.requestSerializer setValue:token forHTTPHeaderField:@"Authorization"];
    [dataService POST:urlString parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
        CGFloat totalinterval = [[NSDate date] timeIntervalSinceDate:beginDate];
        NSLog(@"requestUrl:%@,totalTime:%f",urlString,totalinterval);
        // 请求成功,保存数据
        [ATYCache saveDataCache:responseObject forKey:urlString];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        id cacheData= nil;
        // 是否读取缓存
        if (isReadCache) {
            cacheData = [ATYCache readCache:urlString];
        } else {
            cacheData = nil;
        }
        
        if (failed) {
            failed(task,error,cacheData);
        }
    }];
}

// 文件上传
+ (void)uploadWithUrl:(NSString *)url params:(NSDictionary *)params fileData:(NSArray *)fileData progress:(progress)progress success:(responseSuccess)success failed:(responseFailed)failed {
    
    [[ATYDataService sharedManager] POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (NSInteger i = 0; i < fileData.count; i ++) {
            NSObject *firstObject = [fileData firstObject];
            if ([firstObject isKindOfClass:[UIImage class]]) {
                UIImage *img = fileData[i];
                NSData *imageData = UIImageJPEGRepresentation(img, 1.0);   // 图片压缩
                // 上传的参数名
                NSString *name = [NSString stringWithFormat:@"file%ld", (long)i];
                // 上传filename
                NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate] * 1000;  // 时间戳命名
                NSString *timeStr = [NSString stringWithFormat:@"%f", timeInterval];
                NSString *fileStr = [timeStr substringFromIndex:timeStr.length - 6];
                NSString *fileName = [NSString stringWithFormat:@"%@_%@.jpg", name, fileStr];
                [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:@"image/jpeg"];
            } else {
                NSURL *assetUrl = [fileData firstObject];
//                AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:assetUrl options:nil];
//                AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
//                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//                [formatter setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
//                NSURL *newVideoUrl = [NSURL fileURLWithPath:[NSHomeDirectory() stringByAppendingFormat:@"/Documents/output-%@.mp4", [formatter stringFromDate:[NSDate date]]]];
//                exportSession.outputURL = newVideoUrl;
//                exportSession.outputFileType = AVFileTypeMPEG4;
//                exportSession.shouldOptimizeForNetworkUse= YES;
//                [exportSession exportAsynchronouslyWithCompletionHandler:^(void) {
                    [formData appendPartWithFileURL:assetUrl name:@"file.mp4" error:nil];
//                }];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(task,error,nil);
        }
    }];
}

// 文件下载 支持断点下载
+ (void)downloadWithUrl:(NSString *)url {
    // 1.URL
    NSURL *URL = [NSURL URLWithString:url];
    
    // 2.发起下载任务
    [ATYDataService sharedManager].downloadTask = [[ATYDataService sharedManager].downloadSession downloadTaskWithURL:URL];
    
    // 3.启动下载任务
    [[ATYDataService sharedManager].downloadTask resume];
}

// 暂停下载
- (void)pauseDownload {
    [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        self.resumeData = resumeData;
        //将已经下载的数据存到沙盒,下次APP重启后也可以继续下载
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 拼接文件路径 上面获取的文件路径加上文件名
        NSString *path = [@"sssssaad" stringByAppendingString:@".plist"];
        NSString *plistPath = [doc stringByAppendingPathComponent:path];
        self.resumeDataPath = plistPath;
        [resumeData writeToFile:plistPath atomically:YES];
        self.resumeData = resumeData;
        self.downloadTask = nil;
    }];
}

// 继续下载
- (void)resumeDownloadprogress: (progress)progress success: (downloadSuccess)success failed: (downloadFailed)failed  {
    if (self.resumeData == nil) {
        NSData *resume_data = [NSData dataWithContentsOfFile:self.resumeDataPath];
        if (resume_data == nil) {
            // 即没有内存续传数据,也没有沙盒续传数据,就续传了
            return;
        } else {
            // 当沙盒有续传数据时,在内存中保存一份
            self.resumeData = resume_data;
        }
    }
    
    // 续传数据时,依然不能使用回调
    // 续传数据时起始新发起了一个下载任务,因为cancel方法是把之前的下载任务干掉了 (类似于NSURLConnection的cancel)
    // resumeData : 当新建续传数据时,resumeData不能为空,一旦为空,就崩溃
    // downloadTaskWithResumeData :已经把Range封装进去了
    if (self.resumeData != nil) {
        self.downloadTask = [self.downloadSession downloadTaskWithResumeData:self.resumeData];
        // 重新发起续传任务时,也要手动的启动任务
        [self.downloadTask resume];
    }
}

#pragma NSURLSessionDownloadDelegate
// 监听文件下载进度的代理方法
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // 计算进度
    float downloadProgress = (float)totalBytesWritten / totalBytesExpectedToWrite;
    NSLog(@"%f",downloadProgress);
}

// 文件下载结束时的代理方法 (必须实现的)
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // location : 文件下载结束之后的缓存路径
    // 使用session实现文件下载时,文件下载结束之后,默认会删除,所以文件下载结束之后,需要我们手动的保存一份
    NSLog(@"%@",location.path);
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    // NSString *path = @"/Users/allenjzl/Desktop/ssssss/zzzz.zip";
    // 文件下载结束之后,需要立即把文件拷贝到一个不会销毁的地方
    [[NSFileManager defaultManager] copyItemAtPath:location.path toPath:[path stringByAppendingString:@"/.zzzzzzz.zip"] error:NULL];
    NSLog(@"%@",path);
}

//下载
+ (void)upDataFileWithUrl:(NSString *)url success: (downloadSuccess)success failed: (downloadFailed)failed
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString  *fullPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, @"test.mp4"];
    NSURL *strUrl = [NSURL URLWithString:url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:strUrl];
    NSURLSessionDownloadTask *task =
    [manager downloadTaskWithRequest:request
                            progress:^(NSProgress * _Nonnull downloadProgress) {
                                //下载进度
                                NSLog(@"%@",downloadProgress);
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    
                                    //                                   MBProgressHUD *bar = [MBProgressHUD new];
                                    //                                    bar.mode = MBProgressHUDModeDeterminate;
                                    //                                    [bar showAnimated:YES];
                                }];
                            }destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
                                return [NSURL fileURLWithPath:fullPath];
                            }
                   completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
                       NSLog(@"%@",response);
                       if (!error) {
                           success(response,filePath);
                       }else{
                           failed(error);
                       }
                   }];
    [task resume];
}

@end
