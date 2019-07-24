//
//  CustomAlertView.h
//  VTPictureBook
//
//  Created by 隔壁老王 on 2019/1/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height


typedef void(^AlertResult)(NSInteger index);


@interface CustomAlertView : UIView
@property (nonatomic,copy) AlertResult resultIndex;

-(instancetype)initWithTitle:(NSString * __nullable)title message:(NSString *__nullable)message submessage:(NSString *__nullable)submessage confirmBtn:(NSString *__nullable)confirmTitle cancleBtn:(NSString *__nullable)cancleTitle;

-(instancetype)initWithTitle:(NSString *__nullable)title message:(NSString *__nullable)message image:(UIImage *__nullable)image submessage:(NSString *)submessage confirmBtn:(NSString *__nullable)confirmTitle cancleBtn:(NSString *__nullable)cancleTitle;

-(instancetype)initWithBgImage:(UIImage *__nullable)image ContentImage:(UIImage *__nullable)conImage  message:(NSString *__nullable)message;


-(void)showAlertView:(UIView *)view;
-(void)dismissAlertView;
@end

NS_ASSUME_NONNULL_END
