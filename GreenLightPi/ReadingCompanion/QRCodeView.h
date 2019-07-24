//
//  QRCodeView.h
//  VTPictureBook
//
//  Created by 隔壁老王 on 2019/4/17.
//

#import <UIKit/UIKit.h>
#import "SGQRCodeScanView.h"
NS_ASSUME_NONNULL_BEGIN

typedef void(^BtnEvent)();

@interface QRCodeView : UIView

@property (nonatomic, strong) SGQRCodeScanView *scanView;
@property (nonatomic, strong,nullable) UIButton * flashlightBtn;
@property (nonatomic, copy) BtnEvent btnEvent;
@property (nonatomic, strong) UIImageView *imageV;

-(instancetype)initWithFrame:(CGRect)frame;
-(void) addflashlightBtn;
@end

NS_ASSUME_NONNULL_END
