//
//  ATYUtils.m
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import "ATYUtils.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <sys/utsname.h>

@implementation ATYUtils

#pragma mark -正则匹配Email
+ (BOOL)isEmail:(NSString *)email {
    // ^([^@]*@+[^@]*)*$
    // ^[A-Za-z[0-9]]+([-_.][A-Za-z[0-9]]+)*@([A-Za-z[0-9]]+[-.])+[A-Za-z[0-9]]{2,4}$
    
    NSString *pattern = @"^([^@]*@+[^@]*)*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:email];
}

#pragma mark -正则匹配QQ
+ (BOOL)isQQ:(NSString *)qq {
    NSString *pattern = @"[1-9][0-9]{4,14}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:qq];
}

#pragma 正则匹配手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum {
    if (mobileNum.length != 11) {
        return NO;
    }
    
    // 以1开头,11位
    NSString *MOBILE = @"(^1\\d{10}$)";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    return [regextestmobile evaluateWithObject:mobileNum];
}

#pragma 正则匹配用户密码6-20位数字和字母组合
+ (BOOL)checkPassword:(NSString *)password {
    // @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}"   6-20字母数字组合
    // @"^(?![\d]+$)(?![a-zA-Z]+$)(?![^\da-zA-Z]+$).{6,18}$"   6-18位，英文字母、英文字符、数字组合（至少选2），区分大小写）
    // @"^[a-zA-Z0-9]{6,20}"    6-20位数字字母密码(纯数字,纯字母都可以)
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)(?![^[0-9]a-zA-Z]+$).{6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [pred evaluateWithObject:password];
}

#pragma mark 正则匹配中文
+ (BOOL)isChinese:(NSString *)contenStr {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:contenStr];
}

#pragma 正则匹配用户姓名,50位的中文或英文
+ (BOOL)checkUserName:(NSString *)userName {
    NSString *pattern = @"^[a-zA-Z一-龥]{1,20}";
    //    [\u4e00-\u9fa5]
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

#pragma mark -- 正则匹配用户姓名,10位的中文
+ (BOOL)checkChinaName:(NSString *)userName {
    NSString *pattern = @"^[\u4e00-\u9fa5]{1,10}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

#pragma mark -- 正则匹配用户职业,20位的中文英文和数字
+ (BOOL)checkJobName:(NSString *)userName {
    NSString *pattern = @"[a-zA-Z\u4e00-\u9fa5][a-zA-Z0-9\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:userName];
    return isMatch;
}

#pragma 正则匹配用户身份证号15或18位--粗略判断
+ (BOOL)checkUserIdCard:(NSString *)idCard {
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

#pragma 正则匹配用户身份证号15或18位--严格判断
+ (BOOL)checkIDCardNumber:(NSString *)idCard {
    idCard = [idCard stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([idCard length] != 18) {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:idCard]) {
        return NO;
    }
    int summary = ([idCard substringWithRange:NSMakeRange(0,1)].intValue + [idCard substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([idCard substringWithRange:NSMakeRange(1,1)].intValue + [idCard substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([idCard substringWithRange:NSMakeRange(2,1)].intValue + [idCard substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([idCard substringWithRange:NSMakeRange(3,1)].intValue + [idCard substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([idCard substringWithRange:NSMakeRange(4,1)].intValue + [idCard substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([idCard substringWithRange:NSMakeRange(5,1)].intValue + [idCard substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([idCard substringWithRange:NSMakeRange(6,1)].intValue + [idCard substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [idCard substringWithRange:NSMakeRange(7,1)].intValue *1 + [idCard substringWithRange:NSMakeRange(8,1)].intValue *6
    + [idCard substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    
    return [checkBit isEqualToString:[[idCard substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

#pragma 正则匹员工号,12位的数字
+ (BOOL)checkEmployeeNumber:(NSString *)number {
    NSString *pattern = @"^[0-9]{12}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

#pragma 验证码,4位的数字
+ (BOOL)checkCodeNumber:(NSString *)number {
    NSString *pattern = @"^[0-9]{4}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:number];
    return isMatch;
}

#pragma mark -- 以1开头的11位纯数字
+ (BOOL)isNumText:(NSString *)number {
    NSString * regex = @"^1[0-9]{10}$";//
    NSPredicate * pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:number];
    if (isMatch) {
        return YES;
    } else {
        return NO;
    }
}

#pragma 正则匹配URL
+ (BOOL)checkURL:(NSString *)url {
    NSString *pattern = @"http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}

/**
 *  根据网络地址获取视频缩略图
 *
 *  @param videoURL 视频地址
 *  @param time     截取时间
 *
 *  @return 返回缩略图
 */
+ (UIImage*)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time {
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform = YES;
    assetImageGenerator.apertureMode = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef = NULL;
    CFTimeInterval thumbnailImageTime = time;
    NSError *thumbnailImageGenerationError = nil;
    thumbnailImageRef = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime, 60)actualTime:NULL error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

/*
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}

#pragma mark -在必填项前面设置
+ (NSMutableAttributedString *)setTextSpecialIdentifiy:(NSArray *)textArr withTextLocation:(NSIndexPath *)indexPath withTextString:(NSString *)textString {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textArr[indexPath.row]];
    
    // 给"*"设立字体属性
    NSRange range1 = [textArr[indexPath.row] rangeOfString:@"*"];
    [attributedString addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18],
                                      NSForegroundColorAttributeName : [UIColor redColor],
                                      NSBaselineOffsetAttributeName : @(-2)
                                      } range:range1];
    
    // 给"-----"设立字体属性
    NSRange range2 = [textArr[indexPath.row] rangeOfString:textString];
    [attributedString addAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0],
                                      NSFontAttributeName : [UIFont systemFontOfSize:14],
                                      NSBaselineOffsetAttributeName : @2
                                      } range:range2];
    return attributedString;
}

#pragma mark -创建提醒视图
+ (void)warningView:(UIView *)superView withTitle:(NSString *)warnText withTextField:(UITextField *)textField {
    __block UILabel *warnLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 64+11, [UIScreen mainScreen].bounds.size.width-60, 34)];
    warnLabel.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0];
    warnLabel.layer.borderColor = [UIColor clearColor].CGColor;
    warnLabel.layer.borderWidth = 1;
    warnLabel.layer.masksToBounds = YES;
    warnLabel.layer.cornerRadius = 8;
    warnLabel.text = warnText;
    warnLabel.textColor = [UIColor whiteColor];
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.font = [UIFont systemFontOfSize:14];
    warnLabel.adjustsFontSizeToFitWidth = YES;
    warnLabel.minimumScaleFactor = 12;
    warnLabel.alpha = 0.0;
    [superView addSubview:warnLabel];
    
    // 弹出键盘
    [textField becomeFirstResponder];
    
    [UIView animateWithDuration:0.5 animations:^{
        warnLabel.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0 delay:1.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            warnLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            
            [warnLabel removeFromSuperview];
            
            warnLabel = nil;
        }];
    }];
}

#pragma mark - label高度自适应
+ (CGFloat)heightForString:(UILabel *)informationLabel andWidth:(float)width {
    CGSize sizeToFit = [informationLabel sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    
    return sizeToFit.height;
}

#pragma mark -添加缺省页视图
+ (void)addDefaultViewWithView:(UIView *)defaultView withDefaultImage:(NSString *)imageName withDefaultTitle:(NSString *)title {
    UIImageView *defaultImgView = [UIImageView new];
    defaultImgView.tag = 40000;
    defaultImgView.image = [UIImage imageNamed:imageName];
    defaultImgView.contentMode = UIViewContentModeScaleAspectFit;
    [defaultView addSubview:defaultImgView];
    
    UILabel *defaultLabel = [UILabel new];
    defaultLabel.tag = 41000;
    defaultLabel.text = title;
    defaultLabel.textAlignment = NSTextAlignmentCenter;
    defaultLabel.font = [UIFont systemFontOfSize:15];
    defaultLabel.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1.0];
    [defaultView addSubview:defaultLabel];
    
    [defaultImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(defaultView.mas_centerX);
        make.centerY.equalTo(defaultView.mas_centerY);
    }];
    
    [defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(defaultImgView.mas_bottom).offset(10);
        make.centerX.equalTo(defaultView.mas_centerX);
    }];
}

#pragma mark -移除当前视图上的缺省页
+ (void)removieDefaultView:(UIView *)defaultView {
    UIImageView *defaultImgView = [defaultView viewWithTag:40000];
    [defaultImgView removeFromSuperview];
    
    UILabel *defaultLabel = [defaultView viewWithTag:41000];
    [defaultLabel removeFromSuperview];
    
    // 一句话移除所有子视图
    //    [defaultView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
}

#pragma mark -13位时间戳转时间
+ (NSString *)fomateString:(NSNumber *)dateNum {
    NSString *timeStampString = [dateNum stringValue];
    //  + 28800; // 因为时差问题要加8小时 == 28800 sec;
    NSTimeInterval timeInterval=[timeStampString doubleValue] / 1000.0;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    //    // 实例化一个NSDateFormatter对象
    //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //    // 设定时间格式,这里可以设置成自己需要的格式
    //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //    NSString *currentDateStr = [dateFormatter stringFromDate: date];
    //    return currentDateStr;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    // 获取此时时间戳长度
    NSTimeInterval nowTimeinterval = [[NSDate date] timeIntervalSince1970];
    int timeInt = nowTimeinterval - timeInterval; //时间差
    
    int day = timeInt / (3600 * 24);
    int hour = timeInt / 3600;
    int minute = timeInt / 60;
    
    if (day > 7) {  // 大于7天直接返回具体时间
        return [dateFormatter stringFromDate:date];
    } else {
        if(day > 0 && day <= 7) {    // 7天内
            return [NSString stringWithFormat:@"%d天以前",day];
        } else if(hour > 0)  {  // 24小时内
            return [NSString stringWithFormat:@"%d小时以前",hour];
        } else if(minute > 0){  // 60分钟内
            return [NSString stringWithFormat:@"%d分钟以前",minute];
        } else {    // 60秒内
            return [NSString stringWithFormat:@"刚刚"];
        }
    }
}

#pragma mark -判断内容是否全部为空格  YES:全部为空格  NO:不是
+ (BOOL)isEmpty:(NSString *)str {
    if (!str) {
        return true;
    } else {
        //A character set containing only the whitespace characters space (U+0020) and tab (U+0009) and the newline and nextline characters (U+000A–U+000D, U+0085).
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        //Returns a new string made by removing from both ends of the receiver characters contained in a given character set.
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        
        if ([trimedString length] == 0) {
            return YES;
        } else {
            return NO;
        }
    }
}

#pragma mark -是否可以打开设置页面
+ (BOOL)canOpenSystemSettingView {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        return YES;
    } else {
        return NO;
    }
}

#pragma mark -跳到系统设置页面
+ (void)openSystemSettingView {
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

#pragma mark -在文本后面添加
+ (NSMutableAttributedString *)setAttributedString:(NSString *)str {
    
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:str];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"*"];
    
    [attStr addAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:18],
                            NSForegroundColorAttributeName : [UIColor redColor],
                            NSBaselineOffsetAttributeName : @(-4)
                            } range:NSMakeRange(0, attStr.length)];
    
    [attributedStr appendAttributedString:attStr];
    
    return attributedStr;
}


#pragma mark -根据文件名，能够从本地获取json数据并解析，把数组或字典返回
+ (id)requestData:(NSString *)fileName {
    // 获取文件路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    NSError *error = nil;
    
    // 解析
    id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (json == nil) {
        // 解析失败
        NSLog(@"error: %@", error);
        return nil;
    }
    
    return json;
}

#pragma mark -获取当前屏幕显示的ViewCtrl
+ (UIViewController *)getCurrentWindowViewCtrl {
    UIViewController *result = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow *tempWindow in windows) {
            if (tempWindow.windowLevel == UIWindowLevelNormal) {
                window = tempWindow;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        result = nextResponder;
    } else {
        result = window.rootViewController;
    }
    return  result;
}

// 上面的方法和下面的方法是一套（缺一不可）
+ (UIViewController *)getCurrentViewCtrl {
    UIViewController  *superVC = [[self class]  getCurrentWindowViewCtrl ];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController *)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }
    return superVC;
}

#pragma mark -判断当前设备是iPhone还是iPad YES:iPad；NO:iPhone
+ (BOOL)isiPad {
    BOOL isIdiomiPad = NO;
    UIDevice *currentDevice = [UIDevice currentDevice];
    
    // 项目里只用到了手机和pad所以就判断两项
    if (currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPhone) {    // 设备是手机
        isIdiomiPad = NO;
    } else if (currentDevice.userInterfaceIdiom == UIUserInterfaceIdiomPad) {  // 设备是iPad
        isIdiomiPad = YES;
    }
    return isIdiomiPad;
}

#pragma mark -判断手机是否是iPhone X
+ (BOOL)isIPhoneX {
    if (KSCREEN_WIDTH == 375 && KSCREENH_HEIGHT == 812) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)getDataToString:(id)obj{
    NSData *data=[NSJSONSerialization dataWithJSONObject:obj options:NSJSONWritingPrettyPrinted error:nil];
    return  [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark -- 计算文本宽度
+ (CGSize)sizeWithFontNumber:(NSUInteger)number limitedInHeight:(CGFloat)height limitedInWidth:(CGFloat)width withString:(NSString *)string {
    
//    [_textsLabel.text boundingRectWithSize:CGSizeMake(BOUNDS.size.width-30, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil];
    
    
    CGSize strSize = [string boundingRectWithSize:CGSizeMake(width, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:number]} context:nil].size;
    return CGSizeMake(ceil(strSize.width), ceil(height));
}

#pragma mark -- 获取当前时间
+ (NSDate *)getCurrentTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    return date;
}

#pragma mark -- 对比当前时间
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"oneDay : %@, anotherDay : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //在指定时间前面 过了指定时间 过期
        NSLog(@"oneDay  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //没过指定时间 没过期
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //刚好时间一样.
    //NSLog(@"Both dates are the same");
    return 0;
}


@end
