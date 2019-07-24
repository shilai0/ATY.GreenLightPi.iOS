//
//  ATYUtils.h
//  GreenLightPi
//
//  Created by 代雅丽 on 2018/5/31.
//  Copyright © 2018年 aiteyou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ATYUtils : NSObject
/** 正则匹配email */
+(BOOL)isEmail:(NSString *)email;
/** 正则匹配QQ */
+(BOOL)isQQ:(NSString *)qq;
/** 正则匹配手机号 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;
/** 正则匹配用户密码6-20位数字和字母组合 */
+ (BOOL)checkPassword:(NSString *)password;
/** 正则匹配中文 */
+ (BOOL)isChinese:(NSString *)contenStr;
/** 正则匹配用户姓名,20位的中文或英文 */
+ (BOOL)checkUserName:(NSString *)userName;
/** 正则匹配用户姓名,10位的中文 */
+ (BOOL)checkChinaName:(NSString *)userName;
/** 正则匹配用户职业,20位的中文英文和数字 **/
+ (BOOL)checkJobName:(NSString *)userName;
/** 正则匹配用户身份证号--粗略验证 */
+ (BOOL)checkUserIdCard:(NSString *)idCard;
/** 正则匹配用户身份证号--严格验证 */
+ (BOOL)checkIDCardNumber:(NSString *)idCard;
/** 正则匹员工号,12位的数字 */
+ (BOOL)checkEmployeeNumber:(NSString *)number;
/** 验证码,4位的数字 */
+ (BOOL)checkCodeNumber:(NSString *)number;
/** 以1开头的11位纯数字 */
+ (BOOL)isNumText:(NSString *)number;
/** 正则匹配URL */
+ (BOOL)checkURL:(NSString *)url;
/** 根据视频地址获取指定时间的视频截图 */
+ (UIImage *)thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;
/** 将json格式的字符串转换为字典 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
/** 在必填项前面设置* */
+ (NSMutableAttributedString *)setTextSpecialIdentifiy:(NSArray *)textArr withTextLocation:(NSIndexPath *)indexPath withTextString:(NSString *)textString;
/** 创建提醒视图 */
+ (void)warningView:(UIView *)superView withTitle:(NSString *)warnText withTextField:(UITextField *)textField;
/** 动态计算UILabel高度自适应 */
+ (CGFloat)heightForString:(UILabel *)informationLabel andWidth:(float)width;
/** 添加缺省页视图 */
+ (void)addDefaultViewWithView:(UIView *)defaultView withDefaultImage:(NSString *)imageName withDefaultTitle:(NSString *)title;
/** 移除当前视图上的缺省页 */
+ (void)removieDefaultView:(UIView *)defaultView;
/** 13时间戳转时间 */
+ (NSString *)fomateString:(NSNumber *)dateNum;
/** 判断字符串是否全部为空格 */
+ (BOOL)isEmpty:(NSString *)str;
/** 是否可以打开设置页面 */
+ (BOOL)canOpenSystemSettingView;
/** 跳到系统设置页面 */
+ (void)openSystemSettingView;
/** 这是文本后面添加 */
+ (NSMutableAttributedString *)setAttributedString:(NSString *)str;
/** 根据文件名，能够从本地获取json数据并解析，把数组或字典返回 */
+ (id)requestData:(NSString *)fileName;
/** 获取当前屏幕显示的ViewCtrl */
+ (UIViewController *)getCurrentViewCtrl;
/** 判断当前设备是iPhone还是iPad YES:iPad；NO:iPhone */
+ (BOOL)isiPad;
/** 判断手机是否是iPhone X */
+ (BOOL)isIPhoneX;

+ (NSString *)getDataToString:(id)obj;
/** 计算文本宽度 */
+ (CGSize)sizeWithFontNumber:(NSUInteger)number limitedInHeight:(CGFloat)height limitedInWidth:(CGFloat)width withString:(NSString *)string;
/** 获取当前时间 */
+ (NSDate *)getCurrentTime;
/** 对比当前时间 */
+ (int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
@end
